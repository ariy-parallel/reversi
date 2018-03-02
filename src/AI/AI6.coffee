class AI6 extends AI5
  search: ->
    if 10 < @board.blank_cells
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
      temp_min_score = @search_best_of_you(next_board, max_score)

      if max_score < temp_min_score
        max_score = temp_min_score
        [result_row, result_col] = [row, col]

    [result_row, result_col]


  search_best_of_AI:(board, min_score) ->
    movable_cells = board.movable_cells()
    max_score = -64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @count_diff_with_you()
      else
        return @search_best_of_you(board, max_score)
    for key of movable_cells
      [row, col] = key.row_col()
      # 自分打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_best_of_you(next_board, max_score)
      return score if score < min_score
      if max_score < score
        max_score = score
    max_score

  search_best_of_you:(board, max_score) ->
    movable_cells = board.movable_cells()
    min_score = 64
    if Object.keys(movable_cells).length is 0
      board.change()
      unless board.can_move_anywhere()
        return @count_diff_with_you()
      else
        return @search_best_of_AI(board, min_score)

    for key of movable_cells
      [row, col] = key.row_col()
      # 相手打つ
      next_board = board.clone()
      next_board.move(row, col)
      score = @search_best_of_AI(next_board, min_score)
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