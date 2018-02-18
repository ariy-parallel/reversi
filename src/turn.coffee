class Turn
  constructor: ->
    @this_player = Setting.DISK.BLACK
    @next_player = Setting.DISK.WHITE

  change: ->
    [@this_player, @next_player] = [@next_player, @this_player]