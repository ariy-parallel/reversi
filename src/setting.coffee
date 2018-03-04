class Setting
  @DISK:
    BLACK: "black"
    WHITE: "white"
    NONE: ""

  @AI:
    SCORE:
      A: 0
      B: 0
      C: -5
      X: -10
      CORNER: 20
      NONE: 0

  @BOARD:
    INITIAL:
      [
        ["", "", "", "", "", "", "", ""]
        ["", "", "", "", "", "", "", ""]
        ["", "", "", "", "", "", "", ""]
        ["", "", "", @DISK.WHITE, @DISK.BLACK, "", "", ""]
        ["", "", "", @DISK.BLACK, @DISK.WHITE, "", "", ""]
        ["", "", "", "", "", "", "", ""]
        ["", "", "", "", "", "", "", ""]
        ["", "", "", "", "", "", "", ""]
      ]

    SCORE:
      [
        [@AI.SCORE.CORNER, @AI.SCORE.C, @AI.SCORE.A, @AI.SCORE.B, @AI.SCORE.B, @AI.SCORE.A, @AI.SCORE.C, @AI.SCORE.CORNER]
        [@AI.SCORE.C, @AI.SCORE.X, 0, 0, 0, 0, @AI.SCORE.X, @AI.SCORE.C]
        [@AI.SCORE.A, 0, 0, 0, 0, 0, 0, @AI.SCORE.A]
        [@AI.SCORE.B, 0, 0, 0, 0, 0, 0, @AI.SCORE.B]
        [@AI.SCORE.B, 0, 0, 0, 0, 0, 0, @AI.SCORE.B]
        [@AI.SCORE.A, 0, 0, 0, 0, 0, 0, @AI.SCORE.A]
        [@AI.SCORE.C, @AI.SCORE.X, 0, 0, 0, 0, @AI.SCORE.X, @AI.SCORE.C]
        [@AI.SCORE.CORNER, @AI.SCORE.C, @AI.SCORE.A, @AI.SCORE.B, @AI.SCORE.B, @AI.SCORE.A, @AI.SCORE.C, @AI.SCORE.CORNER]
      ]
