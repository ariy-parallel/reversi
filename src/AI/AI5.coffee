class AI5 extends AI4
  constructor:(@board) ->
    @not_final_depth_limit = 1

  # ミニマックス法
  # 隅に傾斜付き
  search: ->
    @search_not_final()

  search_not_final: ->
    [max_score, result_row, result_col] = [-64, -1, -1]
    for i, [row, col] of @board.movable_cells()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      temp_min_score = @search_not_final_best_of_you(next_board, 0, max_score)
      temp_min_score += Setting.BOARD.SCORE[row][col]
      if max_score < temp_min_score
        [max_score, result_row, result_col] = [temp_min_score, row, col]

    [result_row, result_col]

  search_not_final_best_of_AI:(board, depth, min_score) ->
    return @AI_movable_cells_length(board) if @not_final_depth_limit <= depth
    movable_cells = board.movable_cells()
    max_score = -64
    if movable_cells.length is 0
      board.change()
      unless board.can_move_anywhere()
        return @AI_movable_cells_length(board)
      else
        return @search_not_final_best_of_you(board, depth + 1, max_score)
    for i, [row, col] of movable_cells
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_not_final_best_of_you(next_board, depth + 1, max_score)
      score += Setting.BOARD.SCORE[row][col]
      return score if score < min_score
      if max_score < score
        max_score = score
    max_score

  search_not_final_best_of_you:(board, depth, max_score) ->
    return @AI_movable_cells_length(board) if @not_final_depth_limit <= depth
    movable_cells = board.movable_cells()
    min_score = 64
    if movable_cells.length is 0
      board.change()
      unless board.can_move_anywhere()
        return 64
      else
        return @search_not_final_best_of_AI(board, depth + 1, min_score)

    for i, [row, col] of movable_cells
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_not_final_best_of_AI(next_board, depth + 1, min_score)
      score -= Setting.BOARD.SCORE[row][col]
      return score if max_score < score
      if score < min_score
        min_score = score
    min_score

  AI_movable_cells_length:(board) ->
    board.movable_cells_length()