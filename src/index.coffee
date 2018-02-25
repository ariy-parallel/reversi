window.onload = ->
  window.board = new Board
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
    ai = new AI5(window.board)
    [row2, col2] = ai.search()
    window.board.move(row2, col2)
    unless window.board.can_move_anywhere()
      window.board.change()
      if window.board.can_move_anywhere()
        AI_move()