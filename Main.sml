structure Main =
struct
  fun stringToPos s =
    case map Int.fromString
            (String.tokens Char.isSpace s) of
      [SOME x, SOME y] => SOME (x, y)
    | _ => NONE

  fun readPos () =
    case TextIO.inputLine TextIO.stdIn of
      NONE => NONE
    | SOME s => stringToPos s

  fun colorToString Reversi.BLACK = "*"
    | colorToString Reversi.WHITE = "o"

  fun rowToString board y =
    Int.toString y ^
    String.concat
      (List.tabulate
        (Reversi.boardSize,
          fn x => case Reversi.get board (x, y) of
                    SOME c => colorToString c
                  | NONE => "_"))
    ^ "\n"

  fun boardToString board =
    String.concat
      ( [" "] @
       (List.tabulate (Reversi.boardSize, fn x => Int.toString x)) @
        ["\n"] @
       (List.tabulate (Reversi.boardSize, rowToString board))
      )

  (* val printPosition = fn : int * int -> string *)
  fun printPosition (x, y) = "[" ^ (Int.toString x) ^  " " ^ (Int.toString y) ^ "]"

  (* val printPossiblies = fn : (int * int) list -> string *)
  fun printPossiblies positions =
    foldl (fn (x, y) => (printPosition x) ^ y) "" positions

  fun gameToString {board, next = SOME c} =
        boardToString board ^
        colorToString c ^
        "の手番です\n" ^
        "着手可能：" ^
        printPossiblies (Reversi.possible board c) ^
        "\n"
    | gameToString {board, next = NONE} = boardToString board ^ "終局\n"

  fun mainLoop game =
    (
      print (gameToString game);
      case readPos () of
        NONE => ()
      | SOME pos =>
        let
          val b = #board game
          val c = #next game
        in
          case c of
            NONE => ()
          | SOME color =>
            case List.exists (fn x => pos = x) (Reversi.possible b color) of
              false => mainLoop game
            | true =>
              case Reversi.step game pos of
                NONE => ()
              | SOME game => mainLoop game
        end
    )
end

val _ = Main.mainLoop Reversi.init
