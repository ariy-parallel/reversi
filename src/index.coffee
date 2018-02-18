window.onload = ->
  window.turn = new Turn
  window.board = new Board
  window.board.draw()

  $(".cell").on "click", ->
    [row, col] = $(this).attr("id").split("")
    window.board.move(window.turn.this_player, row, col)
    window.turn.change()
    window.board.draw()