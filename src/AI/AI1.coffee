class AI1 extends AI
  search: ->
    movable_cells = {}
    for row, row_num in Setting.BOARD.INITIAL
      for _cell_val, col_num in row when @board.can_move(row_num, col_num)
        movable_cells["#{row_num}#{col_num}"] = @board.flip_disk(row_num, col_num).length

    y = 0
    x = 0
    max_score = 0
    for key, score of movable_cells
      [row, col] = key
      if max_score < score
        y = row
        x = col
    [parseInt(y, 10), parseInt(x, 10)]