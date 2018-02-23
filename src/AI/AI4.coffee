class AI4 extends AI3
  # ミニマックス法
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = key.row_col()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      # 相手一番嫌なところに打つ
      temp_min_score = @min_score(next_board)

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]

  min_score:(board) ->
    temp_min_score = 64
    for key2 of board.movable_cells()
      [row2, col2] = key2.row_col()
      next2_board = board.clone()
      next2_board.move(row2, col2)

      temp_score = @more_move_count(next2_board)
      if temp_score < temp_min_score
        temp_min_score = temp_score
    temp_min_score