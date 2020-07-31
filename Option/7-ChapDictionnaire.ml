(* 1 - Definition :  *)

(* Soit c un ensemble, appelé ensemble des clefs *)
(* Soit V un autre ensemble, appelé ensemble des valeurs *)
(* Un dictionnaire est une fonction de C dans V, pas forcément définie sur C entier *)

(* Operation élémentaire *)
(* - renvoyer la valeur associée à une clef *)
(* - ajouter une association : étant donné une clef c et une valeur v *)

(* Remarque :  Un tableau est un cas particulier de dictionnaire : *)
(* si n est la longueur d'un tableau t, alors c'est un dictionnaire dont l'ensemble des cléfs est [|0;n-1|] *)

(* 2 - Dictionnaires persistants, par liste d'association *)

(* Une liste d'associataion est une liste de couples (clef,valeur) *)

(* Exemple *)

let l = [("banane",3);("carottes",5);("celeri-rave",2)];;

(* l représente le dictionnaire dont les clefs sont des chaines de char, les valeurs des entier *)
(* qui à "banane" associe 3 ...*)

(* La fonction permettant de retrouver la valeur associée à une clef est deja dans Ocaml : List.assoc *)

List.assoc "carottes" l;;

(* Ajouter un élement avec :: : cxt : O(1) *)
(* List.assoc : cxt : O(nb assoc) dans le pire des cas *)

(* La liste d'association est une manière simple mais pas optimale d'implémenter un dictionnaire *)

(* Autres méthodes *)
(* Utiliser un ABR *)
(* Utiliser un tableau "redimensionnable" trié *)

(* 3 - Dictionnaire persistant par ABR *)

(* On enregistre un couple (clef,valeur) à chaque noeud*)

type 'a arbre = Vide | Noeud of ('a arbre * 'a * 'a arbre) ;;
type ('a, 'b) dictionnaire_par_ABR = ('a*'b) arbre;;

(* Remarque : la relation d'ordre sur les couples ext lexicographique :*)
(* La premiere composante est comparée en premier *)
(* Donc ici, un ABR sera automatiquement trié selon ses clefs *)

let feuille x = Noeud(Vide,x,Vide);;

let epicerie = Noeud(
                      feuille ("bananes",2),
                      ("carottes",3),
                      feuille("celeri-rave",1)
)
;;

let rec valeur_associee c d= (*appartient*)
  (* Renvoie la valeur associée à la clef dans le dictionnaire d *)
  match d with
  | Vide -> failwith "Pas trouvé"
  | Noeud(_,e,_) when (fst e) = c -> snd e
  | Noeud(fg,e,fd) when (fst e) >  c ->  valeur_associee c fg
  | Noeud(fg,e,fd) ->  valeur_associee c fd
;;

valeur_associee "celeri-rave" epicerie;;



let rec association c v d = (*insertion*)
  match d with
  | Vide -> Noeud(Vide, (c,v),Vide)
  | Noeud (fg,(clef,valeur),fd) when clef = c -> Noeud(fg, (clef,v),fd)
  | Noeud (fg,(clef,valeur),fd) when clef < c -> Noeud(fg,(clef,valeur),association c v fd)
  | Noeud (fg,(clef,valeur),fd) -> Noeud(association c v fg,(clef,valeur),fd)
;;

association "panais" 12 epicerie;;

(* 4 - Dictionnaire mutable *)

(* EN Ocaml *)

let test = Hashtbl.create 42;;
Hashtbl.add test "navet" 12;;
test;;
Hashtbl.add test "pois" 1;;
Hashtbl.find test "pois";;


(* Exercice 1 : Trie par dénombrement (sur tableaux) *)

let incr_dico d c=
  (* d est un ('a, int) hashtbl et c est une clef de type 'a *)
  (* Augmente la valeur associée à c de 1 ou l'initialise a l si c n'était pas encore présente  *)
  try
    Hashtbl.add d c ((Hashtbl.find d c)+1)
  with
  | Not_found -> Hashtbl.add d c 1
  ;;

incr_dico test "orange";;
incr_dico test "navet";;

Hashtbl.find test "orange";;
Hashtbl.find test "navet";;

let nombre_de d c=
  (* Renvoie la valeur associé à c dans d s'il y en a et 0 sinon *)
  try
    Hashtbl.find d c
  with
  | Not_found -> 0
  ;;

(* Finir l'exo pour le 09/06/2020 *)

  let test2 = [|2;6;5;4;-2;3;6;5;-10|];;

let compte t =
  let d = Hashtbl.create (Array.length t)
  and min = ref t.(0)
  and max = ref t.(0) in
  (* Renvoie le dictionnaire x-> nb de x dans t *)
  for i=0 to (Array.length t-1) do
    let ti =  t.(i) in
    incr_dico d (t.(i));
    if !min>ti
      then min := ti;
    if !max<ti
      then max := ti;
  done;
  (!min,!max,d);
  ;;

let min,max,dic = compte test2;;
Hashtbl.find dic 5;;
print_int(min);;
print_int(max);;

let rec triDenombrement l =
  let min,max,d = compte l
  and res = ref [||] in
  for i=min to max do 
    let ni = ref (nombre_de d i) in
    if !ni > 0 then
      res := Array.append !res (Array.make !ni i);
  done;
  !res
  ;;

let rec triDenombrement2 l =
  let min,max,d = compte l
  and res = Array.make (Array.length l) 0
  and x = ref 0 in
  for i=min to max do 
    let ni = (nombre_de d i) in
    for _=0 to (ni-1) do
      res.(!x) <- i;
      incr x;
    done;               
  done;
  res
  ;;

(* Avec la complexité : *)

let rec triDenombrement2 l =
  let min,max,d = compte l        (* O(|l|) *)
  and res = Array.make (Array.length l) 0 (* O(|l|) *)
  and x = ref 0 in    (* O(1) *)
  for i=min to max do (* O(max-min) *)
    let ni = (nombre_de d i) in (* O(1) : Cette ligne contribue en O(max-min) à la complexité finale *)
    for _=0 to (ni-1) do  (* O(|t|) *)
      res.(!x) <- i;  (* O(1). Executée |t| fois. Contibue a la complexité en O(|t|) *)
      incr x; (* Idem *)
    done;               
  done;
  res (* O(1) *)
  ;;

(* Total :  *)
(* O(|t|) + O(|t|) + O(maxi-mini) + O(|t|)  *)
(* = O(|t|) + O(maxi-mini)  *)

(* Ainsi si maxi-mini est grand par rapport a la valeur de t : *)
(* Ce tri est inefficace *)
(* En revanche : si maxi-mini = O(|t|), la cxt est en O(|t|), ce qui est mieux que le tri fusion !!! *)

(* Inconvénient : On ne peut trier que des entiers ... *)

let test2 = [|2;6;5;4;-2;3;6;5;-10;|];;

triDenombrement2 test2;;

   (* Complexité : *)
   (* On compte le nmbre de tour de boucle *)
   (* incr_dico -> O(1) *)
   (* Nombre_de -> O(1) *)
   (* compte    -> O(|l|) *)
   (* While     -> Soit \Delta = (max-min), on a  \Delta *)
   (* Tri denombrement : O(\Delta ) *)

   (* Le tri est intérésant tant que les nombres ne sont pas deux à deux trop éloingnés *)
    
(* Cours : *)

   (Hashtbl.hash "bonjour") mod 40;;


(* Exercice 2 *)

(* on va utiliser un dictionnaire comme structure d'ensemble . En partique, on utilisera que les clef, et on mettra n'importe quoi comme  *)
(* valeur *)

(* Mutable : Avec des Hashtbl *)

(* Etape 1 : créer un dictionnaire avec une clef par élément de l *)
let ajoute d c=
  (* d est un ('a, int) hashtbl et c est une clef de type 'a *)
  (* Augmente la valeur associée à c de 1 ou l'initialise a l si c n'était pas encore présente  *)
  try
    if Hashtbl.find d c =0 then ()
  with
  | Not_found -> Hashtbl.add d c 1
  ;;

let ensemble_des_elements l=
  (* Renvoie un dictionnaire dont le clefs sont les éléments de 1. *)
  let res = Hashtbl.create 42 in
  List.iter (fun x -> Hashtbl.add res x l) l;
  res
;;

let ensemble_des_elementsRec l =
  let res = Hashtbl.create 42 in

  let rec boucle = function
  | [] -> ()
  | x::suite -> Hashtbl.add res x true;boucle suite
  in boucle l;
  res
  ;;

let d = ensemble_des_elementsRec [1;5;4;2];;
Hashtbl.find d 5;;

let est_une_clef c d=
  (* Indique si c est une clef de d *)
  try
    Hashtbl.find d c
  with
    |Not_found -> false
    ;;

est_une_clef 3 d;;

(* Enfin : le dédoublonage *)

let sans_doublon l=
  (* renvoie la liste l privée de ses doublons *)
  let deja_vus = Hashtbl.create 42 in
    let rec boucle = function
    (* Fonction qui parcourt l *)
    | [] -> []
    | t::q when est_une_clef t deja_vus -> boucle q
    | t::q -> Hashtbl.add deja_vus t true; 
              t::boucle q
    in
    boucle l
;;

sans_doublon [1;4;3;3;3;2;6;6;5];;

(* Cxt : *)
(* O(|l|) *)

(* Version purement récursive, à l'aide d'ABR au lieu des tables de hachage *)

type 'a arbre = Vide | Noeud of ('a arbre * 'a * 'a arbre);;

let rec appartient e a=
  match a with
  | Vide -> false
  | Noeud(fg,x,fd) when x=e ->true
  |Noeud(fg,x,fd) -> appartient e fg || appartient e fd
  ;;

  let rec insered x a =
    (* Entree : un ABR a
        Sortie : un ABR contenant les elements de a ainsi que x. Si x y etait deja, on y met un nouvel exemplaire*)
    match a with 
    |Vide -> Noeud(Vide,x,Vide)
    |Noeud(fg,e,fd) when x>=e -> Noeud(fg, e, insered x fd)
    |Noeud(fg,e,fd) -> Noeud(insered x fg, e, fd)
    ;;

let sans_doublon_rec l=
  (* renvoie la liste l privée de ses doublons *)
    let rec boucle deja_vus = function
    (* Fonction qui parcourt l *)
    (* arg sup : ABR des elements deja vus *)
    | [] -> []
    | t::q when appartient t deja_vus -> boucle deja_vus q
    | t::q ->  t::(boucle (insered t deja_vus) q)
    in
    boucle Vide l
;;

sans_doublon_rec [1;4;3;3;2;4;1;5];;


(* Pour le 16/06 : ex3 *)

let rec somme_dico l dico somme =
  match l with
  | [] -> somme
  | t::q -> somme_dico q dico (somme + Hashtbl.find dico t) 
;;


let gagnant t =
  let dico = Hashtbl.create (Array.length t)
  and l = ref [] in
  for i=0 to (Array.length t-1) do
    if (nombre_de dico t.(i))=0 then
      l := t.(i)::!l;
    incr_dico dico (t.(i))
  done;
  let rec aux liste max n=
    match liste with
    | [] -> max
    | d::q when (Hashtbl.find dico d) > n -> aux q d (Hashtbl.find dico d)
    | d::q -> aux q max n

    in 
    let predo = aux !l t.(0) (Hashtbl.find dico t.(0)) in
    if Hashtbl.find dico predo > (somme_dico !l dico 0)/2 then
      predo
    else
      ""
    
    ;;


gagnant [|"leo";"LV"|];;