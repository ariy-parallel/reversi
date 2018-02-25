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

    ADDRESS:
      "00": @AI.SCORE.CORNER
      "01": @AI.SCORE.C
      "02": @AI.SCORE.A
      "03": @AI.SCORE.B
      "04": @AI.SCORE.B
      "05": @AI.SCORE.A
      "06": @AI.SCORE.C
      "07": @AI.SCORE.CORNER
      "10": @AI.SCORE.C
      "11": @AI.SCORE.X
      "12": @AI.SCORE.NONE
      "13": @AI.SCORE.NONE
      "14": @AI.SCORE.NONE
      "15": @AI.SCORE.NONE
      "16": @AI.SCORE.X
      "17": @AI.SCORE.C
      "20": @AI.SCORE.A
      "21": @AI.SCORE.NONE
      "22": @AI.SCORE.NONE
      "23": @AI.SCORE.NONE
      "24": @AI.SCORE.NONE
      "25": @AI.SCORE.NONE
      "26": @AI.SCORE.NONE
      "27": @AI.SCORE.A
      "30": @AI.SCORE.B
      "31": @AI.SCORE.NONE
      "32": @AI.SCORE.NONE
      "33": @AI.SCORE.NONE
      "34": @AI.SCORE.NONE
      "35": @AI.SCORE.NONE
      "36": @AI.SCORE.NONE
      "37": @AI.SCORE.B
      "40": @AI.SCORE.B
      "41": @AI.SCORE.NONE
      "42": @AI.SCORE.NONE
      "43": @AI.SCORE.NONE
      "44": @AI.SCORE.NONE
      "45": @AI.SCORE.NONE
      "46": @AI.SCORE.NONE
      "47": @AI.SCORE.B
      "50": @AI.SCORE.A
      "51": @AI.SCORE.NONE
      "52": @AI.SCORE.NONE
      "53": @AI.SCORE.NONE
      "54": @AI.SCORE.NONE
      "55": @AI.SCORE.NONE
      "56": @AI.SCORE.NONE
      "57": @AI.SCORE.A
      "60": @AI.SCORE.C
      "61": @AI.SCORE.X
      "62": @AI.SCORE.NONE
      "63": @AI.SCORE.NONE
      "64": @AI.SCORE.NONE
      "65": @AI.SCORE.NONE
      "66": @AI.SCORE.X
      "67": @AI.SCORE.C
      "70": @AI.SCORE.CORNER
      "71": @AI.SCORE.C
      "72": @AI.SCORE.A
      "73": @AI.SCORE.B
      "74": @AI.SCORE.B
      "75": @AI.SCORE.A
      "76": @AI.SCORE.C
      "77": @AI.SCORE.CORNER