window.onload = ->
  window.board = new Board
  window.board.draw()

  $(".cell").on "click", ->
    [row, col] = $(this).attr("id").split("")
    [row, col] = [parseInt(row, 10), parseInt(col, 10)]
    if window.board.can_move(row, col)
      window.board.move(row, col)
      window.board.draw()