
type mot = char list;;
type arbre_lex = Noeud of bool*fils
and fils = (char* arbre_lex) list;;




let rec mot_of_string_aux chaine i=
  if i < String.length chaine then
  (String.get chaine i)::(mot_of_string_aux chaine (i+1))
  else []
;;

let mot_of_string chaine =
  mot_of_string_aux chaine 0
;;

mot_of_string "test";;

let feuille= Noeud(true ,[]) ;;
let exemple=
Noeud(false ,[
'f',Noeud(false ,[
'a', Noeud(true ,[
('c', feuille)
]
)
;
 ('i', feuille)
 ])
 ]);;

 (* 3 *)

 (* Un noeud Terminal qui n'est pas une feuille est utile pour former plusieurs mots
    qui commence de la même manière  
   *)

(* 4 *)
 (* La racine est un noeud terminal si 
      - L'arbre ne contient que un seul mot
      - Ce seul mot a un seul caractère
  *)

let rec creer_aux mlist =
  match mlist with
  |[]-> Noeud(true ,[])
  |t::q->Noeud(false,[t,creer_aux q])
  ;;

  let creer m =
    let mlist = mot_of_string m in
    creer_aux mlist
    ;;

creer "test";;

let rec compterAux a =
  match a with 
  |Noeud(false,fils)->compter_fils fils
  |Noeud(true,fils)->1+compter_fils fils
and compter_fils l=
  match l with
  |[]->0
  |(c,a)::q->compterAux a + compter_fils q
;;

let compter a=
  match a with 
  |Noeud(true,[]) ->0
  |_ -> compterAux a 
;;

compter exemple;; 

let rec compterFeuille a =
  match a with 
  |Noeud(true,[])->1
  |Noeud(true,fils) | Noeud(false,fils) ->compterFeuille_fils fils 
and compterFeuille_fils l=
  match l with
  |[]->0
  |(c,a)::q->compterFeuille a + compterFeuille_fils q
;;

compterFeuille feuille;;

let rec prefixe x l =
  match l with
  |[]-> [] 
  |t::q -> (x::t)::(prefixe x q)
;;

prefixe 'a' [['v';'i';'o';'n'];['r';'r';'i';'v';'e']] ;;


let rec extraire a =
  match a with
  |Noeud(true,[])->[[]]
  |Noeud(false,fils)->extraire_fils fils 
  |Noeud(true,fils)->extraire_fils fils 
and extraire_fils l=
  match l with
  |[]-> []
  |(c,a)::q->(prefixe c (extraire a))@extraire_fils q 
;;

extraire exemple;;

let rec ajoute m a =
  match a with 
  |Noeud(b,fils) -> Noeud(b,ajoute_fils m fils)
and ajoute_fils m l =
  match m,l with
  |[],_ -> l
  |t::q1, [] -> [(t,creer_aux q1)]
  |t::q1,(c,a1)::q2 when t=c -> (c,ajoute q1 a1)::q2
  |t::q1,(c,a1)::q2 when t<c -> (t,creer_aux q1)::l
  |t::q1,(c,a1)::q2 -> (c,a1)::(ajoute_fils m q2)
;;

let rec arbre_of_listAux listmot a =
  match listmot with
  |[]->a
  |t::q-> arbre_of_listAux q (ajoute (mot_of_string t) a)
  ;;

let arbre_of_list listmot= 
  arbre_of_listAux listmot (Noeud(true ,[]))
  ;;


arbre_of_list ["avion";"attendre";"arrive";"test"];;

let dico nom_fichier =
  let f = open_in nom_fichier in
  let rec dico_rec l =
    try
      dico_rec ((input_line f)::l);
    with 
      |End_of_file -> arbre_of_list l
    in dico_rec [] ;;

dico "Prepa_Sup/SPE/DM2/motFR.txt";;

let dico2 chemin =
  let entree = open_in chemin in
  let rec aux ()=
    try
    let ligne = (input_line entree) in
      ligne :: aux ()
    with
      |End_of_file -> []
    in 
    aux ()
;;

dico2 "Prepa_Sup/SPE/DM2/motFR.txt";;

