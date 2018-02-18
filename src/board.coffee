class Board
  @ADJACENT = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  constructor: ->
    @cells = Setting.BOARD.INITIAL
    @this_player = Setting.DISK.BLACK
    @next_player = Setting.DISK.WHITE

  change: ->
    console.log "change"
    [@this_player, @next_player] = [@next_player, @this_player]

  draw: ->
    for row, row_num in @cells
      for cell_val, col_num in row
        cell = $("##{row_num}#{col_num}")
        if @can_move(row_num, col_num)
          cell.addClass("movable")
        else
          cell.removeClass("movable")
        unless cell_val is Setting.DISK.NONE
          cell.addClass("disk")
          cell.removeClass(Setting.DISK.BLACK)
          cell.removeClass(Setting.DISK.WHITE)
          cell.addClass(cell_val)

  move:(row, col) ->
    @flip(row, col)
    @change()

  can_move:(row, col) ->
    return false unless @cells[row][col] is Setting.DISK.NONE
    for [y, x] in Board.ADJACENT
      return true if 0 < @flip_disk_each_direction(row, col, y, x).length
    false

  flip:(row, col) ->
    @cells[row][col] = @this_player
    for [y, x] in @flip_disk(row, col)
      @cells[y][x] = @this_player

  flip_disk:(row, col) ->
    flip_disk = []
    for [y, x] in Board.ADJACENT
      flip_disk = flip_disk.concat(@flip_disk_each_direction(row, col, y, x))
    flip_disk

  flip_disk_each_direction:(row, col, y, x) ->
    flip_disk = []
    checking_row = row
    checking_col = col
    for [0..8]
      checking_row = checking_row + y
      checking_col = checking_col + x
      # 自分の石が見つかる前に盤外にたどり着いたらひっくり返せない
      unless 0 <= checking_row <= 7 && 0 <= checking_col <= 7
        return []
      cell = @cells[checking_row][checking_col]
      # 相手の石を貯めて置く
      if cell is @next_player
        flip_disk.push([checking_row, checking_col])
      # 反対側に自分の石があればひっくり返せる
      else if cell is @this_player
        return flip_disk
      # 何も石がなければひっくり返せない
      else
        return []