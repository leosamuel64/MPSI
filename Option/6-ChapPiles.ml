type 'a pile = 'a list ref;;

let exemple = ref [3;5;4];;

let empile x p=
  p:= x::(!p)
  ;;

let depile p=
  match !p with
  |[]-> failwith "pile vide"
  |t::q-> p:= q; t
  ;;

empile 3 exemple;;
exemple;;

(* Avec un tableau *)

type 'a pile = {donnees : 'a array;mutable fin : int};;
let exemple = {donnees = [|3;4;5;0;0;0;0|];fin =2};;

let empile x p=
  p.donnees.(p.fin +1)<-x;
  p.fin<- p.fin+1
  ;;

let depile p=
  if p.fin<0 then failwith "pile vide"
  else begin
    p.fin<-p.fin-1;
    p.donnees.(p.fin+1);
  end
  ;;

depile exemple;;
exemple;;

(* On a en Caml *)

Stack.create;; (*Nouvelle pile*)
Stack.push;; (* empile *)
Stack.pop;; (* depile *)


let pile l=
  (* Renvoie une pile avec les elements de l *)
  
  let s = Stack.create () in
  let rec pileAux l p=
    match l with
    |[]-> p
    |t::q-> Stack.push t p;pileAux q p;
    in
    pileAux l s
;;

pile [1;2;3];;
(* Fonctions elementaires sur les piles *)

let inverseSommet p=
  let a = Stack.pop p
  and b = Stack.pop p in
  Stack.push b p;Stack.push a p
  ;;

let test = Stack.create ();;
Stack.push 1 test;Stack.push 2 test;Stack.push 3 test;;


let rec longueurAuxREC p res=
  if Stack.is_empty p then
  res
  else
  begin
    Stack.pop p;
    longueurAuxREC p res+1
  end
  ;;

let longueur p=
  let np = Stack.create ()
  and res = ref 0 in

  while not (Stack.is_empty p) do
    Stack.push (Stack.pop p) np;
    res:=!res + 1;
    done;
    for i=0 to (!res-1) do
      Stack.push (Stack.pop np) p;
    done;
    !res;
    
;;

let test = Stack.create ();;
Stack.push 1 test;Stack.push 2 test;Stack.push 3 test;;

longueur test;;

let affiche p=

  
  let np = Stack.create () in
  while not (Stack.is_empty p) do
    Stack.push (Stack.pop p) np;
  done;
  while not (Stack.is_empty np) do
    let e = Stack.pop np in
    print_int(e);
    print_char(';');
    Stack.push e p;
  done;

  ;;

affiche test;;
affiche test;;

(* EAP *)

type 'a lexeme = OpBin of ('a-> 'a-> 'a)
            | Nb of 'a;;



(* Recursive/persistante *)

let applique o pile=
  match pile with
  |x::y::en_dessous -> (o x y):: en_dessous
  |_-> failwith "erreur syntaxe"
  ;;

let evalue_rec f =
  let rec aux pile a_lire=
    match a_lire with
    |[]-> (*On a fini la lecture. Contient 1 élément : le resulat *)
    begin
      match pile with
      |[res]-> res
      |_-> failwith "erreur syntaxe"
    end
    |(Nb n)::suite_f-> aux (n::pile) suite_f

    |(OpBin o)::suite_f-> aux (applique o pile) suite_f
    in
    aux [] f
    ;;

evalue_rec [Nb 2;Nb 3;OpBin (+);Nb 4;Nb 5;OpBin ( + );OpBin ( * )];;

(* Version Imperative*)

(* A présent, une formule sera de type lexeme array. *)
(* Qu'on parcourra par une boucle for *)
(* La pile sera mutable, de type Stack *)


let evalue_imp formule =
  (* Entrée : formule, de type lexeme array
     Sortie : le résultat de cette formule. *)
  let pile = Stack.create () in

  (* On parcours la formule, de gauche à droite *)
  for i =0 to Array.length formule -1 do
    (* On lit formule.(i), qui est de type lexeme.  *)
    match formule.(i) with
      
    | OpBin o -> (* On applique o aux deux éléments au sommet de la pile *)
       let x = Stack.pop pile in
       let y = Stack.pop pile in
       Stack.push (o y x) pile
       
    | Nb n -> Stack.push n pile 
  done;

  let res = Stack.pop pile in
  if not (Stack.is_empty pile) then
    failwith "erreur syntaxe"
  else
    res
;;


evalue_imp [|Nb 2; Nb 3; Nb 5; OpBin (-); OpBin ( * ) ; Nb 4; Nb 5; OpBin (+); OpBin ( * )   |];;




(* -- ex 4 : parenthèsage -- *)

(* exemple mal parenthésé *)
let ex = "au(tc)(tc" ;; (* Une parenthèse non fermée *)
let ex2 = "au(tc)t)c(" ;; (* Une parenthèse fermée avant d'être ouverte. *)

(* idée : compter le nb de parenthèses «ouvertes et pas encore fermées». Ce nombre doit :
 - rester posifif durant la lecture
 - être nul à la fin  *)


(* Version récursive *)
let bien_parenthesee c=
  (* Entrée : c, string 
     Sortie : le booléen «c est bien parenthésée » 
   *)

  let rec aux i npopef =
    (* Entrée : i, l'indice du prochain caractère à lire
                npopef, nb de parenthèses ouvertes pas encores fermées 
     *)
    if i= String.length c then npopef=0
    else
      
      match c.[i] with
      |'(' -> aux (i+1) (npopef +1  )
      |')' when npopef =0 -> false
      |')' -> aux (i+1) (npopef -1  )
      |_   -> aux (i+1) npopef

  in
  aux 0 0
;;
bien_parenthesee "()(()())";;



(* Version for *)
let bien_parenthesee c=
  (* Entrée : c, string 
     Sortie : le booléen «c est bien parenthésée » 
   *)

  let npopef = ref 0
  and res= ref true in
  for i =0 to String.length c -1 do
    match c.[i] with
    |'(' -> incr npopef
    |')' -> decr npopef
    |_   -> ()
    ;
      if !npopef < 0 then
        res:= false
  done;

  !res && !npopef=0
;;
bien_parenthesee "()) ((()())";;


(* Version while *)
let bien_parenthesee c=
  (* Entrée : c, string 
     Sortie : le booléen «c est bien parenthésée » 
   *)

  let npopef = ref 0
  and i= ref 0 in
  
  while !npopef >=0 && !i < String.length c do
    (
      match c.[!i] with
    |'(' -> incr npopef
    |')' -> decr npopef
    |_   -> ()
    )
    ;
      incr i
  done;

  !npopef=0
  
;;
bien_parenthesee "()) ((()())";;

(* question 2: avec différents types de parenthèses *)

let ex = "{ ( } )";;
let ex_bon =" (  {} [] )";;
(* état de la pile lors de la lecture ex_bon :

{     [
(  (  (   (   ∅

 *)

(* Cette fois on garde dans une pile les parenthèses ouvertes et pas encore fermées.*)
 (* Quand on rencontre une parenthèse fermante, elle doit correspondre à la parenthèse ouvrantes au sommet de la pile *)

(* Pour gérer les parenthèses ouvrantes et fermantes correspondante, utilisons une «liste d'association» *)
let parentheses=[
    ( '(', ')' );
    ( '{', '}');
    ( '[', ']');
    ( '<', '>') ];;

let rec assoc clef l =
  (* Renvoie le second élément du couple dont clef est le premier élément *)
  (* On dit que c'est l'élément associé à la clef *)
  match l with
    | [] -> failwith "clef absente"
    | (key, value)::_ when key = clef -> value
    | _::tl -> assoc  clef tl
;;

assoc '{' parentheses;;

let bien_parenthesee2 c=
  (* Cette version prend en compte les différents types de parenthèses.*)

  let popef = Stack.create ()
  and res =ref true
  and i= ref 0
  and ouvrantes = List.map fst parentheses
  and fermantes = List.map snd parentheses in
  
  while !res  && !i < String.length c do
    begin
      if  List.mem c.[!i] ouvrantes then 
        Stack.push c.[!i] popef

      else if List.mem c.[!i] fermantes then
        if Stack.is_empty popef then res:=false
        else
          let o = Stack.pop popef in (* la parenthèse ouvrante au sommet de la pile. *)
          if assoc o parentheses <> c.[!i] then
            res:=false
    end;
    
    incr i
  done;

  !res && Stack.is_empty popef
;;

bien_parenthesee2 ex;;
bien_parenthesee2 ex_bon;;
bien_parenthesee2 "()]]";;


(* Ex 2 :  retour à l'écriture normale *)

(* Exemple *)
let formule = [Nb 2; Nb 3; OpBin (+) ; Nb 4; Nb 5; OpBin (+); OpBin ( * )   ];;

(* Renvoyer alors
"((2+3)*(4+5))"
 *)

(* Principe : programme très proche de celui pour évaluer une EAP. La pile des calculs intermédiaires contiendra des chaînes. *)



(* Pour mardi prochain !*)
(* Supposer que notre formule contient des int lexemes , de sorte qu'on utilisera string_of_int pour convertir en chaîne.*)

type lexemetxt = OpBin of (string-> string-> string)
                    | Nb of int;;

let plus a b=
  "("^a^"+"^b^")"
  ;;

let moins a b=
  "("^a^"-"^b^")"
  ;;
 
let mult a b=
  "("^a^"*"^b^")"
  ;;

let div a b=
  "("^a^"/"^b^")"
  ;;

 let eap_txt formule =
  (* Entrée : formule, de type lexeme array
     Sortie : l'expression de cette formule (string). *)
  let pile = Stack.create () in

  (* On parcours la formule, de gauche à droite *)
  for i =0 to Array.length formule -1 do
    (* On lit formule.(i), qui est de type lexeme.  *)
    match formule.(i) with
      
    | OpBin o -> (* On applique o aux deux éléments au sommet de la pile *)
       let x = Stack.pop pile in
       let y = Stack.pop pile in
       Stack.push (o x y) pile
       
    | Nb n -> Stack.push (string_of_int(n)) pile 
  done;

  let res = Stack.pop pile in
  if not (Stack.is_empty pile) then
    failwith "erreur syntaxe"
  else
    res
;;


eap_txt [|Nb 2; Nb 3; Nb 5; OpBin moins; OpBin mult ; Nb 4; Nb 5; OpBin plus; OpBin mult   |];;
int_of_string "3";;

let concatAux o a b=
  let res = ref "" in
  if o (int_of_string a) (int_of_string b) = (int_of_string a) + (int_of_string b) then res :="("^a^"+"^b^")"
  else if o (int_of_string a) (int_of_string b) = (int_of_string a) -(int_of_string b) then res := "("^a^"-"^b^")"
  else if o (int_of_string a) (int_of_string b) = (int_of_string a) *(int_of_string b) then res :="("^a^"*"^b^")"
  else if o (int_of_string a) (int_of_string b) = (int_of_string a) / (int_of_string b) then res :="("^a^"/"^b^")"
  else failwith "Operateur inconnu !"
  ;
  !res;
  ;;

(* Exercice 5 : Exemple de derecursivation *)

let bouge i j =
  (*Affiche le deplacement d'un anneau*)
  print_int i;print_string"->";print_int j;print_char '\n';
;;

let rec hanoirec n d a i=
  if n = 0 then
      ()
  else begin
      hanoirec (n-1) d i a;
      bouge d a;
      hanoirec (n-1) i a d; 
  end
;;

hanoirec 3 0 2 1;;

let hanoi n=
  (* Affiche les operations pour transférer n anneaux de 0 vers 2 *)
  let aFaire = Stack.create () in
  (* (n,d,a,i) *)
  Stack.push (n,0,2,1) aFaire;
  while not(Stack.is_empty aFaire) do
    let (k,d,a,i) = Stack.pop aFaire in
    if k=0 then ()
    else if k = 1 then bouge d a
    else begin
      Stack.push ((k-1),i,a,d) aFaire;
      Stack.push (1,d,a,i) aFaire;
      Stack.push ((k-1),d,i,a) aFaire;
    end
  done;
  ;;

hanoi 3;;

(* Exercice 3 : Des chiffres et pas des lettres *)

type 'a lexeme = OpBin of ('a-> 'a-> 'a)
            | Nb of 'a;;

(* [Nb 2;Nb 2;Nb 3;OpBin ( * );OpBin (+)] -> (2+3)*2 *)

(* Methode : essayer toutes les permutations de la liste de depart. *)
(* On garde celles dont l'evaluation ne produit pas d'erreur et dont le résultat renvoi le nombre voulu *)
(* Remarque : avec n elements dans la liste, cela fera n! essais *)

let calcul formule =
  (* Entrée : formule, de type lexeme array
     Sortie : le résultat de cette formule. *)
  let pile = Stack.create () in

  (* On parcours la formule, de gauche à droite *)
  for i =0 to Array.length formule -1 do
    (* On lit formule.(i), qui est de type lexeme.  *)
    match formule.(i) with
      
    | OpBin o -> (* On applique o aux deux éléments au sommet de la pile *)
       let x = Stack.pop pile in
       let y = Stack.pop pile in
       Stack.push (o y x) pile
       
    | Nb n -> Stack.push n pile 
  done;

  let res = Stack.pop pile in
  if not (Stack.is_empty pile) then
    failwith "erreur syntaxe"
  else
    res
;;

let essai f n=
  (* Renvoie vrai ssi f est syntaxement correcte (cad calcul_rec ne déclenche pas ) *)
  (* d'erreur et son evaluation renvoie n *)
  try
  (calcul f)= n;
  with
  |_ -> false
  ;;

  (* Etape cruciale : creer la liste des permutations *)

let rec prive_de l x=
  match l with
  |[]->[]
  |t::q  when t=x -> q
  |t::q -> t::prive_de q x


let permutations l =
  (* Renvoie la liste de toutes les permutation de l *)
  (* Autrement dit : la liste des listes obtenues en mettant les elements de l dans tous les ordres possibles *)
  
  let rec visite_noeud deja_pris restant =
    (* deja_pris : element de l deja pris *)
    (* restant : element de l pas deja pris *)
    match restant with
    | [] -> [deja_pris]
    |_ -> visite_fils deja_pris restant [] restant


  and visite_fils deja_pris restant freres_aines = function
    | [] -> [deja_pris]
    | t::q->  (visite_noeud (deja_pris@[t]) (freres_aines@q))
              @
              visite_fils deja_pris restant (t::freres_aines) q

  in
  visite_noeud [] l
;;

permutations [1;2];;

(* FINIR L'EXO POUR LE 26/05 *)
(* ---- Exemple de fonction qui ne fonctionne pas ----
let rec le_compte_est_bon l n=
  (* Entrée : liste de lexème l, nombre n *)
  (* Sortie : liste des permutation de l dont l'évaluation donne n *)
    let rec aux p_restantes=
      match p_restantes with
      | [] -> []
      | f::q ->
      if (essai f n) then (f::aux q)
      else (aux q)

      in aux (permutations l)    (* <-- Bug ici : This expression has type 'a list list
                                                  but an expression was expected of type 'b lexeme array list
                                                  Type 'a list is not compatible with type 'b lexeme array  *)
      ;;
*)  


(* 6 - Files d'attentes *)

(* Réalisation en Ocaml : File d'attente persistante *)

(* enfile : 'a -> 'a file -> 'a file *)
(* defile : 'a file -> ('a, 'a file) *)
(* fileVide : 'a file *)

(* On utilise 2 liste : pour les entrées et les sorties *)

type 'a file = {entree :'a list; sortie : 'a list};;

(* Quand on enfile un element, on l'ajoute dans entree *)
(* Quand on défile un element, on l'extrait de sortie *)

(* Pour mardi 26/05 : programmer les fonctions de base *)

let fileVide = {entree=[]; sortie=[]};;

let enfile x f =
  (* Renvoie une file avec en plus x *)
  {entree = (x::f.entree) ; sortie = f.sortie}
  ;;

let rec defile f =
  (* Renvoie une file et son element défilé  *)
  match f.sortie with
  | [] -> if f.entree <> [] then defile {entree = [] ; sortie = List.rev f.entree}
            else failwith "Erreur : File Vide"
  | t::q -> (t,{entree = f.entree ; sortie = q})
  ;;

let testfile = {entree = [] ; sortie = []};; 
defile testfile;;

let enfile_liste l f =
  (* Enfile la liste l dans la file f. La tête de l est enfilée en premier. *)
  List.fold_left (fun file elem -> enfile elem file) f l;;

(* Exercice : égalité de deux files *)

let egales f1 f2=
  ((f1.sortie)@(List.rev f1.entree)) = ((f2.sortie)@(List.rev f2.entree))
;;
egales {entree=[2;1]; sortie=[3;4]} {entree=[];sortie=[3;4;1;2]};;

(* Files mutable *)
(* En Ocaml : module Queue *)

Queue.create;;
Queue.add;;
Queue.take;;
Queue.is_empty;;

(* On pourait utiliser deux piles mutable ou utiliser un tableau *)
(* Avec des pointeurs -> 1 pour le debut et 1 pour la fin *)
(* cf Centrale 2018 *)

(* Application : parcourt d'arbre *)

type 'a arbreBinaire = Vide | Noeud of ('a arbreBinaire * 'a * 'a arbreBinaire) ;;

let feuille x = Noeud(Vide, x, Vide);;
let exemple = Noeud (
                  Noeud(Vide, 2, feuille 1),
                  5,
                  Noeud(
                      Vide,
                      3,
                      Noeud(
                          Noeud(Vide, 0, Vide),
                          2,
                          Vide
                        )
                ));;

(* ex 
             5
           /    \
          2      3
         / \     / \
            1       2
                    /\
                   0
                  / \
 *)

 let rec affiche_arbre=function
  |Vide -> ()
  |Noeud(fg,e,fd) -> affiche_arbre fg;print_int e;affiche_arbre fd
  ;;

  affiche_arbre exemple;;

  let rec affiche_arbre_pref=function
  |Vide -> ()
  |Noeud(fg,e,fd) -> print_int e;affiche_arbre fg;affiche_arbre fd
  ;;

  affiche_arbre_pref exemple;;

  let rec affiche_arbre_suff=function
  |Vide -> ()
  |Noeud(fg,e,fd) -> affiche_arbre fg;affiche_arbre fd;print_int e
  ;;

  affiche_arbre_suff exemple;;

  (* Les parcourts sont les plus naturels à programmer *)

let rec somme_arbre = function
  |Vide -> 0
  |Noeud(fg,e,fd) -> (somme_arbre fg) + e + (somme_arbre fd)
  ;; 

somme_arbre exemple;;

(* On remarque que la branche de droite a été traitée avant la gauche *)
(* L'ordre d'évaluation des arguments n'est pas specifié. Ici, le membre de droite du + est évalué en premier *)

(* Parcourt en largeur *)
(* Un parcourt en largeur consiste à explorer l'arbre étage par étage, en commençcant pas les noeuds les plus proches de la racine *)

(* Pour ce faire, on garde en mémoire les prochains sous-arbres à aller explorer *)

(* -> Dans une file d'attente *)

let affiche_arbre_largeur a =

  let rec aux f=
    if f=fileVide then ()
    else match defile f with
      | Vide,suite_f -> aux suite_f
      | Noeud(fg,e,fd),suite_f -> print_int e;aux (enfile fd (enfile fg suite_f))
      in 
      
      aux (enfile a fileVide)
  ;;

affiche_arbre_largeur exemple;;

(* Variante : Renvoyons la liste des noeuds selon un parcourt en largeur *)

let list_noeud_largeur a=
  let rec aux f=
    if f=fileVide then []
    else match defile f with
      | Vide,suite_f -> aux suite_f
      | Noeud(fg,e,fd),suite_f -> e::aux (enfile fd (enfile fg suite_f))
      in 
      
      aux (enfile a fileVide)
  ;;

list_noeud_largeur exemple;;

(* Version impérative, avec une pile mutable (module Queue) *)

let affiche_arbre_largeur_imp a=
  let aVisiter = Queue.create () in
  Queue.add a aVisiter;
  while not(Queue.is_empty aVisiter) do
    match Queue.take aVisiter with
    | Vide -> ()
    |Noeud(fg,e,fd)-> print_int e; Queue.add fg aVisiter;Queue.add fd aVisiter
  done;
  ;;

affiche_arbre_largeur_imp exemple;;

let list_noeud_largeur_imp a =
  let aVisiter = Queue.create ()
  and res = ref [] in
  Queue.add a aVisiter;
  while not(Queue.is_empty aVisiter) do
    match Queue.take aVisiter with
    | Vide -> ()
    |Noeud(fg,e,fd)-> res := e::!res; Queue.add fg aVisiter;Queue.add fd aVisiter
  done;
  List.rev !res
  ;;

list_noeud_largeur exemple;;
list_noeud_largeur_imp exemple;;


(* Pour le 02/06 : Faire l'ex6 sur les arbres généalogiques*)

type arbregenealogique = Vide | Noeud of ( arbregenealogique * (string * string) *  arbregenealogique) ;;


let exemple = 
  Noeud(
    Noeud(
      Noeud(
        Noeud(Vide,("Lebrun","Benoit"),Vide),
        ("Joyot","Oihan"),
        Noeud(Vide,("Pagot","Guillaume"),Vide)), 
      ("Python","Edu"),
      Noeud(
        Noeud(Vide,("Momen","Morgan"),Vide),
        ("Malaval","Francois"),
        Noeud(Vide,("Maleville","René"),Vide))),
    ("Cule","Jean"),
    Noeud(
      Noeud(
        Noeud(Vide,("Malou","Eddy"),Vide),
        ("Hollande","Francois"),
        Noeud(Vide,("Briand","Helene"),Vide)), 
      ("Theal","Theo"),
      Noeud(
        Noeud(Vide,("Dulhoste","Oihan"),Vide),
        ("Charignon","Cyril"),
        Noeud(Vide,("Victor","Louis"),Vide)))) 
;;

let rec ancetresNommes prenom a=
  match a with
  |Vide -> []
  |Noeud(fg,e,fd) -> match e with
                      | (n,p) when p = prenom -> n::(ancetresNommes prenom fg)@(ancetresNommes prenom fd)
                      | (_,_) -> ancetresNommes prenom fg@(ancetresNommes prenom fd)
  ;;

ancetresNommes "Francois" exemple;;


let premierAncetre prenom a=
  let aVisiter = Queue.create ()
  and res = ref ""
  and boucle = ref true in
  Queue.add a aVisiter;
  while not(Queue.is_empty aVisiter) && !boucle do
    match Queue.take aVisiter with
    | Vide -> ()
    |Noeud(fg,e,fd)-> if (snd e) = prenom then begin res := (fst e);boucle := false end
                      else 
                         Queue.add fg aVisiter;Queue.add fd aVisiter
  done;
  !res
  ;;

premierAncetre "Francos" exemple;;


(* Exercice : Une variante des chiffres et des lettres *)
(* On prend une liste d'entiers et un entier n et on veut touver une liste l'élément de l dont la somme fasse n *)
(* On autorise les répétitions *)

(* ex : l = [4;5;3] et n = 18 -> prendre 5+5+5+3*)
(*      l = [4;6;8] et n = 17 -> pas possible*)

(* Etape 1 : ecrire un prédicat qui indique si c'est possible*)

let rec somme_peut_faire n l=
  if n<0 then false
  else
  match l with
  | []	-> n=0
  | t::q	-> (somme_peut_faire (n-t) l) || (somme_peut_faire n q)
  ;;

(* Etape 2 : renvoyer la liste des listes d'élément de l dont la somme vaut n *)

let rajoute_devant x ll=
  List.map
  (fun l -> x::l)
  ll;;


let rec somme_qui_fait1 n l=
  if n<0 then []
  else
    match l with
    | [] when n= 0-> [ [] ]
    | [] -> []
    | t::q	-> rajoute_devant t (somme_qui_fait1 (n-t) l)
               @
               somme_qui_fait1 n q
;;


(* A présent, on souhaite trouver la solution qui utilise le moins de nombres possibles *)

somme_qui_fait1 18 [1;4;5];;

let somme_qui_fait n l=

  let rec visite_noeud reste_a_faire deja_pris =
    (* deja pris : nb deja utilisés, *)
    (* reste_a_faire : somme à obtenir *)

    (* Cas d'arret : *)
    if reste_a_faire = 0 then
      [deja_pris]
    else if reste_a_faire < 0 then
      []
    (* cas general *)
    else
      visite_fils reste_a_faire deja_pris l


  and visite_fils reste_a_faire deja_pris = function
    | [] -> []
    | t::q -> 
        (* essai en utilisant t (descendre dans la branche t) *)
              visite_noeud (reste_a_faire - t) (t::deja_pris)
        (* Essais en utilisant un élement de q (essayer les autres branches) *)
             @ visite_fils reste_a_faire deja_pris q

             in 

                  visite_noeud n []

  ;;

  somme_qui_fait 12 [4;2];;

  (* Enfin, une version avec un parcourt en largeur qui renvoie uniquement la solution la plus simple*)

  let plus_petite_somme_qui_fait n l=
    let rec aux aVisiter =
      if aVisiter = fileVide then  failwith "pas possible"
      else 
      match defile aVisiter with
      | (reste_a_faire,deja_pris),suite_file when reste_a_faire=0 -> deja_pris
      | (reste_a_faire,deja_pris),suite_file when reste_a_faire<0 -> aux suite_file
      | (reste_a_faire,deja_pris),suite_file -> aux (fils_enfiles reste_a_faire deja_pris suite_file l)
      
    
    and fils_enfiles reste_a_faire deja_pris aVisiter = function
      (* Renvoie la file obtenu en rajoutant les fils indiqués par la liste passée en arg dans aVisiter *)
      | [] -> aVisiter 
      | t::q -> 
          let aVisiter_avec_t = enfile (reste_a_faire - t , t::deja_pris) aVisiter in
            fils_enfiles reste_a_faire deja_pris aVisiter_avec_t q

    in 

    aux (enfile (n,[]) fileVide)
;;

plus_petite_somme_qui_fait 22 [1;5;9];;


let plus_petite_somme_qui_fait_imp n l =
  let aVisiter = Queue.create () in
  let res = ref [] in
  Queue.add (n,[])  aVisiter;
  
  while not (Queue.is_empty aVisiter) && !res <> [] do
    let (reste_a_faire,deja_pris) = Queue.take aVisiter in
    if reste_a_faire = 0 then
      res:=deja_pris
    else if reste_a_faire < 0 then
      ()
    else 
      List.iter (fun t -> Queue.add (reste_a_faire - t, t::deja_pris) aVisiter) l

  done;
!res
;;

plus_petite_somme_qui_fait_imp 12 [1;2;4];;