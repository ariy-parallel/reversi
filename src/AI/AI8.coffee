class AI8 extends AI7
  evaluate_not_final:(board) ->
    ai_movable = board.movable_cells_length()
    board.change()
    you_movable = board.movable_cells_length()
    ai_count = board.count_AI()
    ai_movable - (you_movable * 2) - (ai_count / 2)