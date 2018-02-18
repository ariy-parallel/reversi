class Board
  @ADJACENT = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

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
        unless cell_val is Setting.DISK.NONE
          cell.addClass("disk")
          cell.removeClass(Setting.DISK.BLACK)
          cell.removeClass(Setting.DISK.WHITE)
          cell.addClass(cell_val)

  move:(row, col) ->
    @reverse(row, col)
    @turn.change()

  reverse:(row, col) ->
    @cells[row][col] = @turn.this_player
    for [y, x] in @reverse_disk(row, col)
      @cells[y][x] = @turn.this_player

  can_move:(row, col) ->
    return false unless @cells[row][col] is Setting.DISK.NONE
    for [y, x] in Board.ADJACENT
      return true if 0 < @reverse_disk_each_direction(row, col, y, x).length
    false

  reverse_disk:(row, col) ->
    reverse_disk = []
    for [y, x] in Board.ADJACENT
      reverse_disk = reverse_disk.concat(@reverse_disk_each_direction(row, col, y, x))
    reverse_disk

  reverse_disk_each_direction:(row, col, y, x) ->
    reverse_disk = []
    cheking_row = row
    cheking_col = col
    for [0..8]
      cheking_row = cheking_row + y
      cheking_col = cheking_col + x
      # 自分の石が見つかる前に盤外にたどり着いたらひっくり返せない
      unless 0 <= cheking_row <= 7 && 0 <= cheking_col <= 7
        return []
      cell = @cells[cheking_row][cheking_col]
      # 相手の石を貯めて置く
      if cell is @turn.next_player
        reverse_disk.push([cheking_row, cheking_col])
      # 反対側に自分の石があればひっくり返せる
      else if cell is @turn.this_player
          return reverse_disk
      # 何も石がなければひっくり返せない
      else
        return []