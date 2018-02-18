class Board
  constructor:(@turn) ->
    @cells =
      [
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
        ["","","","","","","",""]
      ]
    @cells[3][3] = Setting.DISK.WHITE
    @cells[3][4] = Setting.DISK.BLACK
    @cells[4][3] = Setting.DISK.BLACK
    @cells[4][4] = Setting.DISK.WHITE

  draw: ->
    for row, row_num in @cells
      for cell_val, col_num in row
        cell = $("##{row_num}#{col_num}")
        unless cell_val is ""
          cell.addClass("disk")
          cell.addClass(cell_val)

  move:(player, row, col) ->
    @cells[row][col] = player

  can_move:(row, col) ->