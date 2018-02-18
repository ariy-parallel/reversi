window.onload = ->
  window.board = new Board
  window.board.draw()

  $(".cell").on "click", ->
    [row, col] = (parseInt(i, 10) for i in $(this).attr("id").split(""))
    if window.board.can_move(row, col)
      window.board.move(row, col)
      ai = new AI1(window.board)
      [row2, col2] = ai.search()
      window.board.move(row2, col2)
      window.board.draw()