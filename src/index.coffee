window.onload = ->
  window.board = new Board
  window.board.draw()

  $(".big_disk.black").on "click", ->
    window.board.you = Setting.DISK.BLACK
    window.board.AI = Setting.DISK.WHITE
    $(".mini_disk.you").addClass("black")
    $(".mini_disk.AI").addClass("white")
    $(".modal").fadeOut()
    window.board.draw()

  $(".big_disk.white").on "click", ->
    window.board.you = Setting.DISK.WHITE
    window.board.AI = Setting.DISK.BLACK
    $(".mini_disk.you").addClass("white")
    $(".mini_disk.AI").addClass("black")
    $(".modal").fadeOut()
    AI_move()
    window.board.draw()

  $(".cell").on "click", ->
    [row, col] = $(this).attr("id").row_col()
    unless window.board.can_move(row, col)
      return

    window.board.move(row, col)
    if window.board.can_move_anywhere()
      AI_move()
    else
      window.board.change()
    window.board.draw()
    unless window.board.can_move_anywhere()
      window.board.draw_result()

  AI_move = ->
    ai = new AI8(window.board)
    [row2, col2] = ai.search()
    window.board.move(row2, col2)
    unless window.board.can_move_anywhere()
      window.board.change()
      if window.board.can_move_anywhere()
        AI_move()

  $(".result").on "click", ".retry", ->
    location.reload()