class AI
  constructor:(@board) ->

  search: ->

  movable_cells: ->
    movable_cells = {}
    for row, row_num in Setting.BOARD.INITIAL
      for _cell_val, col_num in row when @board.can_move(row_num, col_num)
        movable_cells["#{row_num}#{col_num}"] = ""
    movable_cells