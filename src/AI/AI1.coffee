class AI1 extends AI
  # できるだけ多く取る
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = key.row_col()
      score = @board.flip_disk(row, col).length
      if max_score < score
        max_score = score
        [result_row, result_col] = [row, col]

    [result_row, result_col]