(*Exo 1*)

let rec,rectangle f a b m=
    if b-.a<= h then
        f a *. (b-.a)
    else
        let m= (a+.b)/.2. in
        rectangle f a m h +. rectangle f m b h
    ;;

let rec rectangle_var f a b eps =
    if abs_float (f(b)-f(a)) < eps then
        f(a)*.(b-a)
    else
        let m= (a+.b)/.2. in
        rectangle_var f a m eps +. rectangle_var f m b eps
    ;;

let rec rectangle_aux f a b eps fa fb=
    (* Arguments Sup : fa= f(a)
                        fb = f(b) *)

if abs_float (fb-fa) < eps then
        fa*.(b-a)
    else
        let m= (a+.b)/.2. in
        let fm = (f m) in 
        rectangle_var_aux f a m eps fa fm  +. rectangle_var f m b eps fm fb
;;

(*Exo 2*)

let rec estTrieeCroissant l=
    match l with
    |[]->true
    |[a]-> true
    |a::b::q -> if a<=b then estTrieeCroissant q
                else false
    ;;

let rec estTrieeCroissant l=
    match l with
    |[]->true
    |[a]-> true
    |a::b::q -> if a<=b && estTrieeCroissant q
    ;;


(*Exo 4*)

let rec fusion_stricte l1 l2=
    match l1,l2 with
    |[],_->l2
    |_,[]->l1
    |t1::q1,t2::q2 when t1=t2 -> t1::(fusion_stricte q1 q2)
    |t1::q1,t2::q2 when t1<t2 -> t1::(fusion_stricte q1 l2)
    |t1::q1,t2::q2 -> t2::(fusion_stricte l1 q2)
;;

let rec partition = function
    |[]-> [],[]
    |[a]->[a],[]
    |a::b::q-> let l1,l2=partition q in a::l1,b::l2
;;


let rec tri_strict l=
    match l with
    |[]->[]
    |[a]->[a]
    |_->let l1,l2 = partition l in fusion_stricte (tri_strict l1) (tri_strict l2)
;;

let rec intersection l1 l2=


    FINIR intersection


    FAIRE UNE FONCTION QUI TRANSFORME UNE LISTE DE LISTE EN 1 SEUL LISTE
    FUSION STRICT DE LISTE CROISSANTE
(*Exo 5*)

let rec place_e l e =
    match l with
    |[]->[e]
    |t::q when e<t -> e::l
    |t::q -> t::place_e q e
    ;;

let rec tri_insertion l=
    match l with
    |[]->[]
    |t::q->  place_e tri_insertion q t
    ;; 