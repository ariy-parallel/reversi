window.onload = ->
  window.board = new Board
  window.board.draw()

  $(".cell").on "click", ->
    [row, col] = (parseInt(i, 10) for i in $(this).attr("id").split(""))
    if window.board.can_move(row, col)
      window.board.move(row, col)
      if window.board.can_move_anywhere()
        ai = new AI3(window.board)
        [row2, col2] = ai.search()
        window.board.move(row2, col2)
        # 自分が置けなかったらパスする
        # TODO:無限ループにする
        unless window.board.can_move_anywhere()
          window.board.change()
          ai = new AI3(window.board)
          [row2, col2] = ai.search()
          window.board.move(row2, col2)
      # 相手が置けなかったらパスする
      else
        window.board.change()
      window.board.draw()