window.onload = ->
  window.board = new Board(new Turn)
  window.board.draw()

  $(".cell").on "click", ->
    [row, col] = $(this).attr("id").split("")
    if window.board.can_move(parseInt(row, 10), parseInt(col, 10))
      window.board.move(row, col)
      window.board.draw()