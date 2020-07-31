(* exo 1  - Cours*)

type 'a tabRedim = {mutable longueur : int; mutable donnees : 'a array};;

(* 1 *)
let rec creeTabRedim n x =
  {longueur = n;donnees = Array.make (2*n) x};;

creeTabRedim 5 0;;

(* 2 *)

let lire t i=
  if i < t.longueur then
    t.donnees.(i)
    else failwith "Error : Out of Range"
  ;;

lire (creeTabRedim 5 8) 3;;

let ecrire t i x = 
  if i < t.longueur then
  t.donnees.(i)<-x
  else failwith "Error : Out of Range"
  ;;

let a = creeTabRedim 5 1;;
ecrire a 3 8;;
lire a 3;;

(* 3 *)


let append t x=
  if t.longueur < (Array.length t.donnees) then begin
    t.longueur <- t.longueur+1;
    ecrire t (t.longueur-1) x;
  end
  else begin
    let nouvt = Array.make ((2*Array.length t.donnees) +1) x in
    for i= 0 to (t.longueur-1) do
      nouvt.(i)<-lire t i;
    done;
    t.donnees<- nouvt;
    t.longueur <- t.longueur+1;
  end
  ;;

let b = creeTabRedim 5 1;;
append b 2;;
b;;

let pop t=
  if t.longueur > 0 then begin
  t.longueur <- t.longueur-1;
  t.donnees.(t.longueur)
  end
  else
    failwith "Erreur : Tableau Vide"
  ;;




(* 4 *)

(* 
 -Si le tableau est de "bonne" taille, la complexité est en O(1)
  Comptons le nombre d'écriture dans un tableau (Array) :
    la complexité est O(1)

 -Sinon 
  On note n la longueur initial de t.donnees :
  Comptons le nombre d'ecriture dans le tableau, on a une complexité en O(n) 

On peut calculer la complexité "moyenne" (cf cours)

  *)

(* Tester l'egalité *)

let egale t1 t2=
  (* Indique si deux tableaux de type tabRedim sont égaux *)
  if t1.longueur = t2.longueur then
    let res = ref true in
    for i=0 to t1.longueur-1 do
      if t1.donnees.(i)!=t2.donnees.(i) then
        res := false
    done;
    !res
  else false;;

let vide = {longueur = 0;donnees=[||]};;

let t =vide in append t 3;append t 2;t;;

(* Stupide car vide ne l'est plus au bout d'1 itération
Car vide est mutable et globale *)
(* Il faut faire une fonction qui renvoie un nouveau 
"tableau" vide *)

let nouveauTab () = 
  (* () veut dire none en caml->python *)
  {longueur = 0;donnees=[||]}
;;

let t= nouveauTab () in append t 3;append t 2;t;;

(* Quelques exemples de cours*)

let somme_arith n =
  let res = ref 0 in
  for i =0 to n-1 do
    res:= !res + i
  done;
    !res
;;

let x = ref 1 in
    let y = x in (* on donne un deuxième nom (un alias) à la variable x *)
    y:=!y+1; (* Ceci est une instruction *)
    !x;;

(* exemple type enregistrement *)

type eleve = {nom : string;prenom : string; mutable classe : int};;
let benoit = { nom = "Lebrun"; prenom = "Benoit";classe=801};;

type 'a ma_reference = {contenu : 'a};;
let x = {contenu = 3};;

benoit.classe <- 903;;


(* Exercice 2 : *)

type grandeur = {valeur: float; unite : int array};;

let plus x y=
  (* if x.unite = y.unite then *)
    {valeur = x.valeur +. y.valeur;unite=x.unite}
  (* else *)
    (* failwith "Pas Homogène" *)
  ;;

let oppose x=
  {valeur = -.x.valeur;unite=x.unite}
  ;;

let uniteFois x y =
   let z=Array.make 7 0 in
   for i=0 to 6 do
       z.(i) <- x.unite.(i) + y.unite.(i)
   done;
   z;;

let fois x y =
   { valeur = x.valeur *. y.valeur ; unite = uniteFois x y }
   ;;
  
let uniteinverse x=
  let z=Array.make 7 1 in
  for i=0 to 6 do
    z.(i)<- x.unite.(i)*z.(i)
  done;
  z;;

let inverse x=
  {valeur = 1.0/.x.valeur; unite = uniteinverse x}
  ;;

  (* q 2 *)
let g = {valeur = 9.81; unite = [|1;0;-2;0;0;0;0|]}
and m = {valeur = 2.0; unite = [|0;1;0;0;0;0;0|]}
and v = {valeur = 0.1; unite = [|3;0;0;0;0;0;0|]} 
and rho = {valeur = 1000.0;unite = [|-3;1;0;0;0;0;0|]}
      in 
      fois g (plus ({valeur = -1.0 ; unite = [|0;0;0;0;0;0;0|]}) (fois rho (fois v (inverse m))));;

(* ex 3 *)

let affiche_int_liste l=
  List.iter 
  (fun x-> print_int x;print_char ' ') 
  l
  ;;

affiche_int_liste [1;2;3;4;5;6;7];;

let rec mon_iter p l =
  match l with
  |[]->()
  |t::q-> p t ; mon_iter p q
  ;;

  mon_iter print_int [1;2;3;4;5;6;7];;




