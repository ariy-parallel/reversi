window.onload = ->
  $("#45, #54").addClass("disk").addClass("black")
  $("#44, #55").addClass("disk").addClass("white")

  $(".cell").on "click", ->
    # 置いた時の処理