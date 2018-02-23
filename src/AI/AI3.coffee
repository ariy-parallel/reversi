class AI3 extends AI
  # 相手より自分の方が折れる場所が多いように取る
  search: ->
    y = -1
    x = -1
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      next_board = jQuery.extend(true, {}, @board)
      next_board.flip(row, col)

      i = next_board.movable_cells_length()
      next_board.change()
      you = next_board.movable_cells_length()

      score = i - you
      if max_score < score
        max_score = score
        y = row
        x = col

    [parseInt(y, 10), parseInt(x, 10)]