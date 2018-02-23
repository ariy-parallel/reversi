class AI4 extends AI
  # ミニマックス法
  search: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = (parseInt(i, 10) for i in key.split(""))
      next_board = jQuery.extend(true, {}, @board)
      next_board.move(row, col)

      temp_min_score = 64
      for key2 of next_board.movable_cells()
        [row2, col2] = (parseInt(i, 10) for i in key2.split(""))
        next2_board = jQuery.extend(true, {}, next_board)
        next2_board.move(row2, col2)
        i = next2_board.movable_cells_length()
        next2_board.change()
        you = next2_board.movable_cells_length()

        temp_score = i - you
        if temp_score < temp_min_score
          temp_min_score = temp_score

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [parseInt(result_row, 10), parseInt(result_col, 10)]