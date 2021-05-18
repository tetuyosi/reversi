type pos = int * int
datatype color = BLACK | WHITE
type board = unit
val get = raise Fail "unimplemented"
val put = raise Fail "unimplemented"
val initBoard = raise Fail "unimplemented"
type game = {board : board, next : color option}
val init = {board = initBoard, next = SOME BLACK}
val step = raise Fail "unimplemented"
fun play moves =
  foldl (fn (pos, NONE) => NONE
          | (pos, SOME game) => step game pos)
          (SOME init)
          moves
