(*Exo 1*)

(*
1)
liste1=[38,1,7,0,-11,3,9,-5,8,2]

    Entiers

2)
list.tl Enlève le premier élément
#22

3)  10 | #02
      46
*)


(*Exo 2*)

let rec longueur l=
match l with
|[] -> 0
|t::suite -> 1 + longueur suite
;;

longueur [1;2;3;5;8];;


let rec somme l =
match l with
|[] -> 0
|t::suite -> t + somme suite
;;

somme [1;2;3;5;8];;
 

let max x y =
  if x>y then
    x
  else
    y
;;

let rec maximum l =
match l with
|[] -> failwith"Liste vide"
|[x] -> x
|t::suite -> max t (maximum suite)
;;
 
maximum [1;4;5;5;8;2;7;5];;

let rec appartient x l=
  match l with
  |[]-> false
  |t::suite -> if t = x then true
               else appartient x suite

  ;;

appartient 5 [0;1;2;3;4;5];;

let rec egale l1 l2 =
  match (l1, l2) with
    |[],[]-> true
    |[],_ -> false
    |_,[] -> false
    |(t::suite1,y::suite2) -> if t=y then egale suite1 suite2
                              else false
    ;;

egale [0;1;2;3] [0;1;2;3]

let rec concat l1 l2 =
  match l1 with
    |[]-> l2
    |t::suite -> t::concat suite l2
    ;;


(* Pour tout |N, Notons Cn le nombre de ::
Pour contatener une liste de longueur n avec une liste quelconque : 
On a : C0 = 0
Pour tout n € |N*, Cn = 2+ Cn-1 *)

(*Exo 4*)

let rec intervalle a b=
    (* Renvoie l'intervalle [[a;b[[ *)

    if b<a then []
    else
        a:: intervalle (a+1) b
;;


(*Exo 5*)

(*
let rec sansLes x l=
    match l with
    |[]->[]
    |t::q -> if t=x then sansLes x q
                    else t::sansLes x q
;;


let rec sansDoublon x l =
    match l with
    |[]->[]
    |t::q when t=x -> q
    |t::q -> t::sansLePremier x q
;;

let rec appartient x l=
  match l with
  |[]-> false
  |t::suite -> if t = x then true
               else appartient x suite

  ;;

let rec sansLeDernier x = function
    |[]-> []
    |t::q when t = x && not (List.mem x q) -> q
    |t::q -> t::sansLeDernier x q
;;

(* Comptons le nombre de "=" :
Pour tout n € |N, soit Cn le nombre max de = pour sansLeDernier x l pour une liste 
l de longueur n

On a :
C0=0
Pour tout n € |N, Cn <= 1 + n-1 + Cn-1 
                     <= n-1 + Cn-2
                     ... ...
                     <= n+(n-1)+ ... + 1 + C0
                     <= n(n+1)/2 = O(n**2)   
*)
(* Deuxieme Methode : Retourner la liste *)
(*)
let sansLeDernier2 x l =
    Liste.rev (sansLePremier x (List.rev l));;

*)
    

(* Troisieme methode : ecrire une fonction qui renvoie un couple (l privé de son dernier x, 
   x apparetneant a l)
   Cela revient a calculer sansLeDernier et List.mem simultanement*)

let rec sansLeDernierAux x l=

    match l with
    |[]-> [],false
    |t::q ->    let (q_sans_son_dernier x, x_dans q) = sansLeDernierAux q in
                if t=x then
                    if x_dans q then
                        t::q_sans_son_dernier x,true
                    else
                        q, true 
                else 
                    t::q_sans_son_dernier x, x_dans q

;;


;;

let rec sansDoublon l=
    match l with
        |[]->[]
        |t::q when List.Mem t q -> sansDoublon q
        |t::q ->t::sansDoublon q
        ;;

(*Pour tout n € |N, soit Cn le nombre max de :: dans sansDoublon d'une liste de longueur n
On a : [C0=0
       [A n € |N*, Cn <= C(n-1) + 3 + (n-1)= n + 2 + C(n-1)
                        Somme(k=3;n+2;k)=(n+2+3)*n/2= O(n**2)
                        
*)


let alenvers l=
    match l with
    |[]->[]
    |t::q-> alenvers q @ [t]
    ;;

(* Complexité Cn ~ n**2 *)

let alenversOpti l accu=
    match l with
    |[]-> accu
    |t::q-> alenversOpti (q) (t::accu)

;;

alenversOpti [1;2;3;4;5;6] [];;

let rec alenversOpti_Final l=
    alenversOpti l [];;

let rec envers l=
let alenversOpti l accu=
    match l with
    |[]-> accu
    |t::q-> alenversOpti (q) (t::accu)
    
    in

    alenversOpti l;;



let rec existe p l=
    match l with
    |[]->false
    |t::q-> if p t then true
            else existe p q
        ;;

let rec existe2 p l=
    match l with
    |[]->false
    |t::q-> p t || existe2 p q
            
        ;;
(*Le A||B ne verifie que A si A=true *)

existe2 (fun x-> x>0)
        [5;1;-1;3];;

let rec pourTout p l=
    match l with
    |[]-> true
    |t::q-> p t && pourTout p q ;;


let rec existeUnique p l=
    match l with
    |[]-> false
    |t::q when p t -> not (existe2 p q)
    |t::_ -> existe2 p q
    ;;

    
(*Il Existe t € l1 tq t € l2*)
let rec intersection_non_vide l1 l2=
    existe2 (fun t-> List.mem t l2 )
            (l1)
;;
(*Il Existe t € l1 tq t € l2*)


*)

(*Exo 9*)

(*
let rec appliquee f l=
    match l with
    |[]-> []
    |t::q-> (f t)::appliquee f q
    ;;

applique (fun (x,y)-> y)
         [(1,2);(3,4);(5,6)];;

let rec appliqueDouble l1 lci l2=
    match l1,l2 with
    |[],[]->[]
    |t1::q1,t2::q2 -> (lci t1 t2)::appliqueDouble q1 lci q2
    ;;
*)    
let rec implosionAux l lci res=
    match l with
    |[]-> res
    |t::q-> implosionAux q lci (lci t res)
    
    ;;

implosionAux [1;1;2;5;1] ( * ) 1;;

let rec intervalle a b=
    (* Renvoie l'intervalle [[a;b[[ *)

    if b<a then []
    else
        a:: intervalle (a+1) b
;;

(* 5 *)

let sommePremierEntier n=
    implosionAux (intervalle 1 n) (+) 0;;

let rec implosionAux2 l lci res=
    match l with
    |[]-> res
    |t::q-> implosionAux2 q lci (lci (t*t) res) 
    ;;

let sommePremierCarres n=
    implosionAux2 (intervalle 1 n) (+) 0;;

let rec implosionAux3 l lci res=
    match l with
    |[]-> res
    |t::q-> implosionAux3 q lci (lci (1.0/.t) res) 
    ;;

let rec intervalle2 a b=
    (* Renvoie l'intervalle [[a;b[[ en version float *)

    if b<a then []
    else
        a:: intervalle2 (a+.1.0) b
;;


let serieHarmonique n=
    implosionAux3 (intervalle2 1.0 n) (+.) 0.0;;



(*6*)


let rec filtre p l res=
    match l with
    |[]->res
    |t::q -> filtre p q (t::res)
    ;;
let rec longueur liste res=
    match liste with
    |[]->res
    |t::q-> longueur q (res+1)
    ;;



let rec element l i res=
    match l with
    
    |t::q-> if i = (res) then t
            else element q i (res+1)
    
    ;;

print_int(element [0;1;2] 1 0);;




(*)

let sommeSupZero l =
    let res = 0 in
    for i =0 to ((longueur l (-1))-1) do 
        if (element l i (-1)) > 0 then
           (* Ajouter (element l i (-1)) a res *)
        
    done;;
    ;;
*)

let rec dans l e=
    match l with
    |[]-> false
    |t::q-> if t =e then true
            else dans q e
            ;;

let rec intersection l1 l2 res=
    match l1 with
    |[]-> res
    |t1::q1->   if (dans l2 t1) && not(dans res t1) then intersection q1 l2 (t1::res)
                else intersection q1 l2 res
    ;;



