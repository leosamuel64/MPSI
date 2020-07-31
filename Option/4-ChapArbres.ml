type 'a arbre = Vide | Noeud of ('a arbre * 'a * 'a arbre);;

let rec minimum a =
    match a with
    |Vide -> failwith "infini"
    |Noeud(vide,e,_)-> e
    |Noeud(fg,_,_)-> minimum fg
    ;;

let rec sans_le_min a=
    match a with
    |Vide->Vide
    |Noeud(Vide,e,fd)->fd
    |Noeud(fg,e,fd)->Noeud(sans_min fg, e ,fd)
    ;;

let rec insered x a =
    (* Entree : un ABR a
        Sortie : un ABR contenant les elements de a ainsi que x. Si x y etait deja, on y met un nouvel exemplaire*)
    match a with 
    |Vide -> Noeud(Vide,x,Vide)
    |Noeud(fg,e,fd) when x>=e -> Noeud(fg, e, insered x fd)
    |Noeud(fg,e,fd) -> Noeud(insered x fg, e, fd)
    ;;

let rec abr_of_list = function
    |[]->Vide
    |t::q -> insered t (abr_of_list q)
    ;;

let rec list_of_abr a=
    match a with
    |Vide -> []
    |Noeud(fg,e,fd)-> list_of_abr fg @(e::list_of_abr fd)
    ;;

let tri_par_abr l=
list_of_abr (abr_of_list l)
;;