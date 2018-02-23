class AI3 extends AI
  # 相手より自分の方が折れる場所が多いように取る
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = key.row_col()
      next_board = @board.clone()
      next_board.flip(row, col)
      score = @more_move_count(next_board)

      if max_score < score
        max_score = score
        [result_row, result_col] = [row, col]

    [result_row, result_col]

  more_move_count:(board) ->
    i = board.movable_cells_length()
    board.change()
    you = board.movable_cells_length()

    i - you