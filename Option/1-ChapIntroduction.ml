(*Exo 3*)
let rec factorielle n =
  if n = 0 then
    1
  else
    n*factorielle(n-1)
;; 

(*Exo 4*)

let coeffBinomial n p =
(*Version avec Factorielle*)
    (factorielle n) / factorielle (n-p)*factorielle(p)
    ;;



let rec binom n p=
(*Version avec relation de pascal*)
    if n<0 || p<0 || p =0 || p =n then 
        1
    else
        binom (n-1) p + binom (n-1) (p-1)
;;


let rec pion n p =
    if n=0 || p=0 then 
        1
    else 
        (n*pion (n-1) (p-1))/p
  
;;

print_int (pion 6 3);;

(*Exo 5*)

let bouge i j =
    (*Affiche le deplacement d'un anneau*)
    print_int i;print_string"->";print_int j;print_char '\n';

;;
let rec hanoi n d a i=
    if n = 0 then
        ()
    else begin
        hanoi (n-1) d i a;
        bouge d a;
        hanoi (n-1) i a d; 
    end
        
       

;;

hanoi 3 0 2 1;;

(*Exo 6*)

let rec f2 fk  fkp1 n=
    if n = 0 then fk
     
    else f2 fkp1 (fkp1+fk) (n-1)

let rec fiboAux (fk,fk1) n=
    if n = 0 then
        (fk,fk1)
    else 
        fiboAux ((fk1),(fk+fk1)) (n-1)
;;






let print_couple (a,b) = 
print_int a;
print_int b;;

print_couple (fiboAux(0,1) 10)