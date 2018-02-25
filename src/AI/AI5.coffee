class AI5 extends AI4
  min_score:(board, key) ->
    temp_min_score = super(board)
    # 位置スコアを加算
    temp_min_score + Setting.BOARD.ADDRESS[key]

  # ミニマックス法
  # 隅に傾斜付き
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = key.row_col()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      # 相手一番嫌なところに打つ
      temp_min_score = @min_score(next_board, key)

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]
