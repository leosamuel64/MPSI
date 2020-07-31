(* Mémoïzation et programmation dynamique *)

(* 1 - Memoïzation *)
(* 1.1 - Premier exemple : Fibonacci *)

let rec fibo_inefficace n=
  if n=0 then 0
  else if n=1 then 1
  else fibo_inefficace (n-1) + fibo_inefficace (n-2)
  ;;

  (* La mémoïzation consiste à garder en mémoire les valeurs déjà calculées  *)
  (* Ici, un simple tableau de taille n+1 suffira *)

  (* On va créer une fonction principale chargée de créer le tableau; la fnction précédente en deviendra la fonction aux *)

let fibo_memo n =
  let cache = Array.make (n+1) (-1) in  (* car -1 n'est pas possible pour un nb de fibo donc -1 n'est pas une vrai valeur*)

  let rec aux k=
    (* Ici on reprend la fonction naïve, avec deux différences :*)
    (* Au début d'un appel rec : regarder si la valeur pour k a déjà été calculée*)
    (* A la fin d'un appel : Mettre la valeur calculée dans le cache *)
    if cache.(k)<> -1 then
      (* valeur deja calculée *)
      cache.(k)
    else  
      (* Sinon on fait le calcul *)
      if k=0 then (
          cache.(0) <- 0; 
          0
        )
      else if k=1 then (
          cache.(1) <- 1; 
          1
        )
      else (
          let res = aux (k-1) + aux (k-2) in
          cache.(k)<- res;
          res
        )
    in aux n
    ;;

fibo_memo 12;;

(* Avantage : Automatique *)

let fibo_dyna n =
  let cache = Array.make (n+1) (-1) in
  cache.(0)<- 0;
  cache.(1)<- 1;
  for k=2 to n do
    cache.(k)<- cache.(k-1)+cache.(k-2)
  done;
  cache.(n)
  ;;

  fibo_dyna 1;;

(* Avantage de cette methode :  *)
(* - code plus court *)
(* - Purement impérative, plus besoin de mélanger les styles   *)
(* - La programmation impérative est en générale un peu plus rapide sur les ordis actuels  *)

(* Désavantage : *)
(* -  Ne fonctionne que dans certain cas : lorsqu'on est capable de trouver l'ordre dans lequel remplir les cases  *)
(* -  Necessite plus de reflexion -> plus de risque d'erreur  *)      
(* -  Dans certains cas, des valeurs inutile auront été calculées puisqu'on remplit *tout* le cache *)


(* Deuxième exemple : coefficient binomiaux *)

(* version sur la formule de pascal *)
let rec cbnaif p n=
  (* Renvoie p parmi n *)
  if p = 0 then 1
  else if p>n then 0
  else  cbnaif (p-1) (n-1) + cbnaif p (n-1)
  ;;

(* Version memoïsée : *)

let cbMemo p n =
  (* Triangle de pascal *)
  let cache = Array.make_matrix (n+1) (p+1) (-1) in

  let renvoi i j res =
    cache.(j).(i) <- res;
    res

    in

    let rec aux i j=
      if cache.(j).(i) <> -1 then cache.(j).(i)
      else if i=0 then renvoi i j 1
      else if i>j then renvoi i j 0
      else renvoi i j (aux (i-1) (j-1) + aux i (j-1))
    in

    aux p n
    ;;

cbMemo 2 6;;

(* Version dynamique *)

let mini a b=
  if a > b then b else a;;

let cbDyna p n =
  let cache = Array.make_matrix (n+1) (p+1) (0) in
  for j=0 to n do
    cache.(j).(0) <- 1
  done;

  for j = 1 to n do
    for i=1 to (mini p j) do
      cache.(j).(i) <- cache.(j-1).(i) + cache.(j-1).(i-1)
    done;
  done;
  cache.(n).(p)
  ;;

cbDyna 2 6;;

(* cxt : O(np) en temps et O(np) en espace *)

(* On peut optimiser en espace la version dynamique *)

(* on peut ne garder que deux lignes en mémoire : la ligne en cours de remplissage *)
(* et la ligne précédente *)

let cbDyna2 p n=
  let ligne = Array.make (p+1) 0
    and lignePrec = Array.make (p+1) 0
    in lignePrec.(0) <- 1;
    for j=1 to n do
      for i=1 to (mini j p) do
        ligne.(i)<- lignePrec.(i)+ lignePrec.(i-1);
      done;

      for i=0 to p do
        lignePrec.(i) <- ligne.(i);
      done;
    done;
    ligne.(p)
    ;;

(* exemple plus compliqué : suite de Syracuse *)

(* Soit p ∈ ℕ. On definit u^p par *)
        (* u^p_0 = p  *)
        (* ∀ n ∈ ℕ, u^p_{n+1} =  *)
              (* u^p_n / 2 si u_n est pair *)
              (* 3 u^p_n +1 sinon *)

let terme_suivant x =
  if x mod 2 =0 then x/2
  else 3*x+1
;;

let rec syracuse n p=
  if n =0 then p
  else 
      terme_suivant (syracuse (n-1) p)
  ;;

syracuse 12 7;;

(* On remarque que lorsque la suite vaut 4,2,ou 1 elle devient périodique *)

(* conjecture : quel que soit p ∈ ℕ*, u^p finit par retomber sur ce cycle *)

let rec liste_des_termes n p=
  (* Renvoie la liste [u_0^p,...,u_n^p] *)
  if n =0 then [p]
  else 
    p::(liste_des_termes (n-1) (terme_suivant p))
;;

liste_des_termes 20 7;;

(* soit p ∈ ℕ, on appelle "temps de vol" de u^p le plus petit n tel que u^p_n=4 *)

let rec temps_de_vol p=
  if p=4
  then 0
  else 1 + temps_de_vol (terme_suivant p)
  ;;

  temps_de_vol 75;;

let maxi a b =
  if a>b then a else b;;

let rec temps_de_vol_max pmax=
  (* renvoie le max des temps de vol pour p ∈ ⟦1, pmax⟧ *)
  if pmax = 1 then
    1
  else
    maxi (temps_de_vol_max (pmax-1)) 
        (temps_de_vol pmax)
  ;;

temps_de_vol_max 150;;

(* On peut améliorer ce programme par mémoïzation : *)

let temps_de_vol_max_memo pmax=
  let cache = Hashtbl.create pmax in
  (* p |-> temps de vol de p *)
  let renvoi p res =
    Hashtbl.add cache p res;
    res
  in

  Hashtbl.add cache 4 0;

  let rec temps_de_vol p =
    if Hashtbl.mem cache p then
    Hashtbl.find cache p
    else
     renvoi p (1+temps_de_vol (terme_suivant p))
  in

  let rec temps_de_vol_max pmax=
    if pmax =1 then 1
    else maxi
            (temps_de_vol pmax)
            (temps_de_vol_max (pmax-1))
      in

  temps_de_vol_max pmax
  ;;

temps_de_vol_max_memo 200000;;
temps_de_vol_max 200000;;

(* Remarque : n'importe quelle fonction peut etre mémoïzée grace a un dictionnaire *)


(* let f_memo arg=
  let cache = Hashtbl.create 42
  in

  let renvoi arg res=
    Hashtbl.add cache arg res;
    res
    in
    let rec f arg =
      if Hashtbl.mem cache arg then
        Hashtbl.find cache arg
      else 
        (* Recopier ici le contenu de la fonction f naive en passant pas renvoie pour renvoyer les valeurs *)
        ()
        in

        f arg
    ;; *)

(* Distance d'édition : *)

(* c'est le nombre minimum de fautes de frappe pour passer d'un mot à un autre *)
(* Exemple : *)
(* d("banane", "bagarre") = 3  *)
      (* En effet, on peut considérer la suite de fautes de frappes*)
      (* - 'n' -> 'g' *)
      (* - 'n' -> 'r' *)
      (* - ajouter un 'r' *)
    (* On admet qu'on ne peut pas faire mieux... *)

(* Pour calculer la distance entre deux mots, on dispose des formules de récurrence suivantes *)

(* Pour tout mot u, d(u,ε) = |u| (enlever toutes les lettre de u) *)

(* Pour tous mot u,v et toutes lettre x d(ux,vx) = d(u,v) *)

(* Pour tous mots u,v et toutes lettres x et y tq t≠y: *)
        (* d(ux,vy) = min d(u,v) +1 *)
                       (* d(ux,v) +1  *)
                       (* d(u,vy)+1 *)
                   
                   
(* Il faudrait le démontrer ... *)

(* Pour le 23/06 : Programmer le calcul de d (vesrion naive) *)
let min a b =
  if a < b then a else b 
  ;;

let min3 a b c=
  let m = min b c in
  if a < m then
    a
  else m
  ;;


let rec d m1 m2 =
  (* Renvoie la distance entre deux mots u et v *)
  if m1="" || m2="" then
    (String.length m1) + (String.length m2)
    else if m1.[String.length m1-1] = m2.[String.length m2-1] then
      d (String.sub m1 0 (String.length m1 -1)) (String.sub m2 0 (String.length m2 -1))
    else 
      min3 
          (d (String.sub m1 0 (String.length m1 -1)) (String.sub m2 0 (String.length m2 -1))+1)
          (d m1 (String.sub m2 0 (String.length m2 -1))+1)
          (d (String.sub m1 0 (String.length m1 -1)) m2 +1)
    ;;

d "banane" "bagarre";;

let listMot = ["bonjour";"test";"guitare";"hello";"television"];;


let correction mot list =
let rec aux mot list min res =
  match list with
  | [] -> res
  | t::q when (d mot t)< min -> aux mot q (d mot t) t
  | t::q -> aux mot q min res
  in 
  aux mot list max_int ""
;;

correction "gitar" listMot;;

let distance_levenstein u v =
  let rec aux i j=
    (* Renvoie d(u[:i], v[:j]) *)

    (* Cas de base *)
    if i=0 then
      j
    else if j=0 then
      i

    else if u.[i-1] = v.[j-1] then
      aux (i-1) (j-1)

    else
      1+ min3 
              (aux (i-1)  (j-1))
              (aux (i)    (j-1))
              (aux (i-1)   (j) )

  in aux (String.length u) (String.length v)
  
  ;;

distance_levenstein "anticonstitutionnelement" "bazar";;

(* Méthode inéfficace : On va la memoîzer *)

(* Pour le cache, on choisit une simple matrice de format (String.length u +1 ,String.length v +1)*)

let distance_levenstein_memo u v=
  let l_u,l_v = (String.length u),(String.length v) in
  let cache = Array.make_matrix (l_u+1) (l_v+1) (-1) in

  let renvoi i j res=
    cache.(i).(j) <-res;
    res
    in

  let rec aux i j=
    (* Renvoie d(u[:i], v[:j]) *)

    if cache.(i).(j)<>(-1) then (* la valeur a deja été calculé *)
      cache.(i).(j)
    else  

      (* Cas de base *)
      if i=0 then
        renvoi i j j
      else if j=0 then
        renvoi i j j

      else if u.[i-1] = v.[j-1] then
        aux (i-1) (j-1)

      else
      renvoi i j (
        1+ min3 
                (aux (i-1)  (j-1))
                (aux (i)    (j-1))
                (aux (i-1)   (j) ))
        
  in aux l_u l_v
;;

distance_levenstein_memo "Masseuse-kinésithérapeute" "Contraventionnalisation";;
(* Version dynamique *)

let distance_levenstein_dyna u v=
  let l_u,l_v = (String.length u),(String.length v) in
  let cache = Array.make_matrix (l_u+1) (l_v+1) (-1) in
  
  (* Cas de base *)
  for i = 0 to l_u do
      cache.(i).(0) <- i 
  done;
  for j = 0 to l_v do
    cache.(0).(j) <- j  
  done;

  for i=1 to l_u do
    for j=1 to l_v do 
      if u.[i-1] = v.[j-1] then
        cache.(i).(j) <- cache.(i-1).(j-1)
      else
        cache.(i).(j) <- 1 +min3
                       (cache.(i-1).(j-1) )   
                       (cache.(i).(j-1) )  
                       (cache.(i-1).(j) ) 
    done; 
  done;

  cache.(l_u).(l_v)
;;

distance_levenstein_dyna "banane" "bagarre";;

(* Exercice 3 : Parenthésage optimal pour un produit de matrices *)

(* 1 - Formule de récurrence : *)

(* ∀ i, j ∈ ⟦1,n⟧², si i < j :   n_{i,j} = min_k=i^j-1 n_{ik} + c_{i-1}C_{k}c_j + N_{k+1,j} *)

                 (* si i = j :   n_{}i,j = 0 *)

let nb_mult c=

    let rec aux i j =
      (* Renvoie le nombre min de mult scalaires pour A_i * ... * A_j *)
      if i = j then
        0

      else 
        let minimum = ref c.(i) in
        let calc k = (aux i k) + c.(i-1)*c.(k)*c.(j) + (aux (k+1) j) in
        for k=i+1 to j-1 do
          minimum := min !minimum (calc k)
        done;
        !minimum
      
        
        
  in 

  aux 1 ((Array.length c) -1)
  ;;

nb_mult [|2;3;4|];;

let nb_mult_rec c=
  
  let rec aux i j =
    if i=j then 0

    else let essai k = (aux i k) + c.(i-1)*c.(k)*c.(j) + (aux (k+1) j) in

    let rec boucle k=
      if k= j-1 then essai (j-1)
      else min (essai k) (boucle (k+1))
      in boucle i
    in aux 1 (Array.length c -1)
    ;;

nb_mult_rec [|2;3;4|];;

(* On fait la mémoization *)

let nb_mult_memo c=
  let n = Array.length c -1 in
  let cache = Array.make_matrix (n+1) (n+1) (-1) in
  let renvoie i j res =
    cache.(i).(j) <- res;
    res
in 
let n = Array.length c -1 in 
let cache = Array.make_matrix (n+1) (n+1) (-1) in    

let rec aux i j = 
    (* Renvoie le nb min de mult scalaires pour calculer A_i x ... x A_j *)
    (* cas de base *) 
    
    if cache.(i).(j) <> -1 then cache.(i).(j)
    else 
        if i = j then renvoie i j 0 
        
        else 
            (* Il faut calculer le minimum pur k de i à j-1 le minimum pour k de i à j-1 de:
                (aux i k) + c.(i-1)*c.(k)*c.(j) + (aux (k+1) j) *)
            
            let essai k = (aux i k) + c.(i-1)*c.(k)*c.(j) + (aux (k+1) j) in
            
            let rec boucle k = 
                if k = j-1 then renvoie i j (essai (j-1))
                else renvoie i j (min (essai k) (boucle (k+1)))
                in renvoie i j (boucle i)
in 
        
aux 1 (Array.length c-1)
;;

nb_mult_memo [|2;3;4|];;


let nb_mult_dyna c =
  (* c est le tableau des nb de colonnes. c.(0) est le nb de lignes de la première matrice.
   Renvoie le nb min de mult scalaires pour calculer A_1 × … × A_n *)
  let n = Array.length c - 1 in 
  let cache = Array.make_matrix (n+1) (n+1) 0 in

  (* cas de base -> initialisation : mettre des 0 sur la diag. C'est déjà fait !*)
  
  for i = n downto 1 do
    for j = i+1  to n do
      let essai k = cache.(i).(k) + c.(i-1)*c.(k)*c.(j) + cache.(k+1).(j) in

      let mini = ref (essai i) in
      for k = i+1 to j-1 do
        mini := min !mini (essai k)
      done;
      cache.(i).(j) <- !mini
    done
  done;
  cache.(1).(n)
;;



nb_mult_dyna [| 2;3;4;6;5;4;3;2;4;3;5;4;2;9;5;4;2;2 |];;