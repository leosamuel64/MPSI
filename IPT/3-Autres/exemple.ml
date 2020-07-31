
let add x y=
  x+y
  ;;

print_int
  (add (int_of_string Sys.argv.(1))
       (int_of_string Sys.argv.(2))
        );;
print_newline();;