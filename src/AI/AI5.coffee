class AI5 extends AI4
  # ミニマックス法
  # 隅に傾斜付き
  search: ->
    @search_not_final()

  search_not_final: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64
    deep = 0
    for key of @board.movable_cells()
      [row, col] = key.row_col()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      temp_min_score = @search_not_final_best_of_you(next_board, deep, max_score)
      temp_min_score += Setting.BOARD.ADDRESS[key]
      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]

  search_not_final_best_of_AI:(board, deep, min_score) ->
    return @AI_movable_cells_length(board) if 2 <= deep
    movable_cells = board.movable_cells()
    max_score = -64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @AI_movable_cells_length(board)
      else
        return @search_not_final_best_of_you(board, deep + 1, max_score)
    for key of movable_cells
      [row, col] = key.row_col()
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_not_final_best_of_you(next_board, deep + 1, max_score)
      return score if score < min_score
      if max_score < score
        max_score = score
    max_score

  search_not_final_best_of_you:(board, deep, max_score) ->
    return @AI_movable_cells_length(board) if 2 <= deep
    movable_cells = board.movable_cells()
    min_score = 64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @AI_movable_cells_length(board)
      else
        return @search_not_final_best_of_AI(board, deep + 1, min_score)

    for key of movable_cells
      [row, col] = key.row_col()
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_not_final_best_of_AI(next_board, deep + 1, min_score)
      return score if max_score < score
      if score < min_score
        min_score = score
    min_score

  AI_movable_cells_length:(board) ->
    board.this_player = board.AI
    board.movable_cells_length()