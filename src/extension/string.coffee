String::to_i = ->
  parseInt(this, 10)

String::row_col = ->
  (char.to_i() for char in this.split(""))