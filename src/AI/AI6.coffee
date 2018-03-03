class AI6 extends AI5
  # アルファベータ法
  # 終盤読み切りたかったけど処理速度が無理だから5手先まで
  search: ->
    if 16 < @board.blank_cells
      @search_not_final()
    else
      @search_final()

  search_final: ->
    [result_row, result_col] = [-1, -1]
    max_score = -64
    deep = 0
    for key of @board.movable_cells()
      [row, col] = key.row_col()
      # 自分打つ
      next_board = @board.clone()
      next_board.move(row, col)
      temp_min_score = @search_final_best_of_you(next_board, deep, max_score)

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]

  search_final_best_of_AI:(board, deep, min_score) ->
    return @count_diff_with_you() if 4 <= deep
    movable_cells = board.movable_cells()
    max_score = -64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @count_diff_with_you()
      else
        return @search_final_best_of_you(board, deep + 1, max_score)
    for key of movable_cells
      [row, col] = key.row_col()
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_final_best_of_you(next_board, deep + 1, max_score)
      return score if score < min_score
      if max_score < score
        max_score = score
    max_score

  search_final_best_of_you:(board, deep, max_score) ->
    return @count_diff_with_you() if 4 <= deep
    movable_cells = board.movable_cells()
    min_score = 64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @count_diff_with_you()
      else
        return @search_final_best_of_AI(board, deep + 1, min_score)

    for key of movable_cells
      [row, col] = key.row_col()
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_final_best_of_AI(next_board, deep + 1, min_score)
      return score if max_score < score
      if score < min_score
        min_score = score
    min_score

  count_diff_with_you: ->
    disks = 0;
    for row, row_num in @board.cells
      for cell_val, col_num in row
        if cell_val is @board.AI
           disks += 1;
         else if cell_val is @board.you
          disks -= 1;
    disks;