class AI1 extends AI
  # できるだけ多く取る
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      score = @board.flip_disk(row, col).length
      if max_score < score
        max_score = score
        [result_row, result_col] = [row, col]

    [parseInt(result_row, 10), parseInt(result_col, 10)]