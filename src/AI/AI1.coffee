class AI1 extends AI
  # できるだけ多く取る
  search: ->
    y = -1
    x = -1
    max_score = 0
    for key of @board.movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      score = @board.flip_disk(row, col).length
      if max_score < score
        max_score = score
        y = row
        x = col
    [parseInt(y, 10), parseInt(x, 10)]