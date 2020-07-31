let nouvell_pile ()=Stack.create ();;
let empile x p = Stack.push x p;;
let depile p = Stack.pop p;;
let est_vide p = Stack.is_empty p;;

let enleve x p=
  (* Enleve le(s) x de p *)
    let nvp = nouvell_pile () in 
  while not (est_vide p) do
    let dp = depile p in 
    if dp = x then
    ()
    else
      empile dp nvp;
  done;
  while not(est_vide nvp) do
    empile (depile nvp) p;
  done;
;;

let enleve2 x p=
  (* Enleve les x de p et renvoie le nombre de x qu'il y avait *)
  let nvp = nouvell_pile ()
  and res = ref 0 in
while not (est_vide p) do
  let dp = depile p in 
  if dp = x then
  res:= !res + 1
  else
    empile dp nvp;
done;
while not(est_vide nvp) do
  empile (depile nvp) p;
done;
!res
;;

type ensemble = int list ;;


let rec insertion_ens v e=
  (* Ajoute v dans e s'il n'y est pas *)
  let rec insertion_ens_aux v e =
    match e with
    |[]-> true
    |t::q-> if t = v then false
                      else insertion_ens_aux v q
    in
  if insertion_ens_aux v e then
    v::e
  else
   e
    ;;

let elimination_ens v e=
  (* Enleve v de e *)
  let rec aux v e res =
    match e with
    |[]-> res
    |t::q -> if t = v then aux v q res
                      else aux v q (t::res)
    in
    aux v e []
    ;;



type couleur = Blanc | Gris ;;
type arbre = Vide | Noeud of couleur * arbre * int * arbre ;;


let rec hauteur_grise a = 
  match a with
  |Vide -> 0
  |Noeud ( Gris , fg , _ , _ ) -> 1 + (hauteur_grise fg)
  |Noeud ( Blanc , fg , _ , _) -> hauteur_grise fg 
  ;;

let non_blanc a = 
  match a with
  |Noeud ( Blanc , _ , _ , _) -> false
  |_ -> true ;;


let validation_bicolore a =
  let rec aux a =
   match a with
  |Vide -> true
  |Noeud (c , fg , _ , fd ) ->
  let ok_g = aux fg
  and ok_d = aux fd in
  match c with
  | Gris ->
  ok_g && ok_d && (hauteur_grise fg) = (hauteur_grise fd)
  | Blanc ->
  ok_g && ok_d && (hauteur_grise fg) = (hauteur_grise fd) && non_blanc fg && non_blanc fd
  in
  aux a 
  ;;

let rec appartient_abr a x =
  match a with
  |vide -> false
  |Noeud (_,_,x,_)->true
  |Noeud (_,fg,_,fd)->(appartient_abr fg x) && (appartient_abr fd x)
  ;;


let validation_abr a =
  let rec aux min max a = 
    (* min et max sont respectivement le plus petit et le plus grand int de Ocaml  *)
    match a with
    |Vide -> true
    |Noeud (_ , fg , x , fd ) ->
                              (min < x) && (x < max) && (aux x max fd) && (aux min x fg)
    in
    aux 0 4611686018427387903 a ;;

let rec insertion_abr v a = 
  match a with
  |Vide -> Noeud ( Blanc , Vide , v , Vide )
  |Noeud (c , fg , y , fd ) ->
                          if v < y
                          then Noeud (c , insertion_abr v fg , y , fd )
                          else if v = y
                          then a
                          else Noeud (c , fg , y , insertion_abr v fd ) 
  ;;