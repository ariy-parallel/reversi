class AI6 extends AI5
  constructor:(@board) ->
    @not_final_depth_limit = 1
    @final_depth_limit = 1

  # アルファベータ法
  search: ->
    if 16 < @board.blank_cells
      @search_not_final()
    else
      @search_final()

  search_final: ->
    [max_score, result_row, result_col] = [-64, -1, -1]
    for i, [row, col] of @board.movable_cells()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      temp_min_score = @search_final_best_of_you(next_board, 0, max_score)

      if max_score < temp_min_score
        [max_score, result_row, result_col] = [temp_min_score, row, col]

    [result_row, result_col]

  search_final_best_of_AI:(board, depth, min_score) ->
    return @evaluate_final(board) if @final_depth_limit <= depth
    movable_cells = board.movable_cells()
    max_score = -64
    if movable_cells.length is 0
      board.change()
      unless board.can_move_anywhere()
        return @evaluate_final(board)
      else
        return @search_final_best_of_you(board, depth + 1, max_score)
    for i, [row, col] of movable_cells
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_final_best_of_you(next_board, depth + 1, max_score)
      return score if score < min_score
      if max_score < score
        max_score = score
    max_score

  search_final_best_of_you:(board, depth, max_score) ->
    return @evaluate_final(board) if @final_depth_limit <= depth
    movable_cells = board.movable_cells()
    min_score = 64
    if movable_cells.length is 0
      board.change()
      unless board.can_move_anywhere()
        return @evaluate_final(board)
      else
        return @search_final_best_of_AI(board, depth + 1, min_score)

    for i, [row, col] of movable_cells
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_final_best_of_AI(next_board, depth + 1, min_score)
      return score if max_score < score
      if score < min_score
        min_score = score
    min_score

  evaluate_final:(board) ->
    disks = 0
    for row, row_num in board.cells
      for cell_val, col_num in row
        if cell_val is board.AI
           disks += 1
         else if cell_val is board.you
          disks -= 1
    disks