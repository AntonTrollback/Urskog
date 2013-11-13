app.eventListener =

  add: (type, method, func) ->

    # callbacks obj
    @callbacks = @callbacks or {}

    # type obj
    @callbacks[type] = @callbacks[type] or {}

    # methods arr
    @callbacks[type][method] = @callbacks[type][method] or []

    # push function
    @callbacks[type][method].push func

  fire: (type, method, data) ->

    # if we have any callbacks of this type
    if @callbacks and @callbacks[type] and @callbacks[type][method]

      # loop callbacks
      i = 0

      while i < @callbacks[type][method].length

        # make sure function exists

        # call
        @callbacks[type][method][i].call null, data  if @callbacks[type][method][i] and typeof @callbacks[type][method][i] is "function"
        i += 1