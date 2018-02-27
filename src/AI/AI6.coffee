class AI6 extends AI5
  search: ->
    if 4 < @board.blank_cells
      @search_not_final()
    else
      @search_final()

  search_final: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64

    for key of @board.movable_cells()
      [row, col] = key.row_col()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      temp_min_score = @search_best_of_you(next_board)

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]


  search_best_of_AI:(board) ->
    movable_cells = board.movable_cells()
    unless board.can_move_anywhere()
      board.change()
      unless board.can_move_anywhere()
        return board.count_AI() - board.count_you()
      else
        return @search_best_of_you(board)

    max_score = -64
    for key of movable_cells
      [row, col] = key.row_col()
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_best_of_you(next_board)
      if max_score < score
        max_score = score
    max_score

  search_best_of_you:(board) ->
    movable_cells = board.movable_cells()
    unless board.can_move_anywhere()
      board.change()
      unless board.can_move_anywhere()
        return board.count_AI() - board.count_you()
      else
        return @search_best_of_AI(board)

    min_score = 64
    for key of movable_cells
      [row, col] = key.row_col()
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_best_of_AI(next_board)
      if score < min_score
        min_score = score
    min_score

