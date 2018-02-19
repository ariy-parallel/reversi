class AI2 extends AI
  # できるだけ少なく取る
  search: ->
    y = -1
    x = -1
    max_score = 64
    for key of @movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      if @board.flip_disk(row, col).length < max_score
        y = row
        x = col
    [parseInt(y, 10), parseInt(x, 10)]