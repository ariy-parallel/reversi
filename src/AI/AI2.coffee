class AI2 extends AI
  # できるだけ少なく取る
  search: ->
    y = -1
    x = -1
    max_score = 64
    for key of @board.movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      score = @board.flip_disk(row, col).length
      if score < max_score
        max_score = score

        y = row
        x = col
    [parseInt(y, 10), parseInt(x, 10)]