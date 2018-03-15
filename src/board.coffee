class Board
  @ADJACENT = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  constructor: ->
    @cells = Setting.BOARD.INITIAL
    @this_player = Setting.DISK.BLACK
    @next_player = Setting.DISK.WHITE
    @blank_cells = 60
    @AI = "-"
    @you = "-"

  clone: ->
    jQuery.extend(true, {}, @)

  change: ->
    [@this_player, @next_player] = [@next_player, @this_player]

  count_you: ->
    disks = 0
    for row, row_num in @cells
      for cell_val, col_num in row
        if cell_val is @you
          disks += 1
    disks

  count_AI: ->
    disks = 0
    for row, row_num in @cells
      for cell_val, col_num in row
        if cell_val is @AI
          disks += 1
    disks

  draw: ->
    @draw_board()
    $(".mini_disk.you").text(@count_you())
    $(".mini_disk.AI").text(@count_AI())

  draw_board: ->
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


  draw_result: ->
    if $(".mini_disk.AI").text().to_i() < $(".mini_disk.you").text().to_i()
      $(".your_result").text("YOU WIN!!!")
    else if $(".mini_disk.you").text().to_i() < $(".mini_disk.AI").text().to_i()
      $(".your_result").text("YOU LOSE...")
    else
      $(".your_result").text("DRAW")
    $(".choose_disk").hide()
    $(".modal").fadeIn()
    $(".result").fadeIn()

  movable_cells: ->
    movable_cells = []
    for row, row_num in @cells
      for _cell_val, col_num in row when @can_move(row_num, col_num)
        movable_cells.push([row_num, col_num])
    movable_cells

  movable_cells_length: ->
    @movable_cells().length

  can_move_anywhere: ->
    for row, row_num in @cells
      for _cell_val, col_num in row
        return true if @can_move(row_num, col_num)
    false

  move:(row, col) ->
    @blank_cells -= 1
    @flip(row, col)
    @change()

  can_move:(row, col) ->
    return false unless @cells[row][col] is Setting.DISK.NONE
    for [y, x] in Board.ADJACENT
      return true if 0 < @flip_disk_each_direction(row, col, y, x).length
    false

  flip:(move_row, move_col) ->
    @cells[move_row][move_col] = @this_player
    for [y, x] in Board.ADJACENT
      for [flip_row, flip_col] in @flip_disk_each_direction(move_row, move_col, y, x)
        @cells[flip_row][flip_col] = @this_player

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