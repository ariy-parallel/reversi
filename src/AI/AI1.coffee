class AI1 extends AI
  # できるだけ多く取る
  search: ->
    y = 0
    x = 0
    max_score = 0
    for key of @movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      if max_score < @board.flip_disk(row, col).length
        y = row
        x = col
    [parseInt(y, 10), parseInt(x, 10)]