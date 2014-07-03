angular.module('sn:core').factory 'snEventHandler', ->
  class SnEventHandler
    events = {}
    recordedEvents = {}
    record = false
    timer = null
    time = 0
    playing = false
    
    on: (eventName, callback)=>
      events[eventName] ||= []
      events[eventName].push(callback)
      null

    once: (eventName, callback)=>
      events[eventName] ||= []
      self = @
      events[eventName].push (data)->
        callback(data)
        self.off(eventName, callback)

      null

    off: (eventName, callback)->
      if callback
        cbIndex = events[eventName].indexOf(callback)
        cb = events[eventName].splice(cbIndex,1)
        cb = null
      else
        events[eventName] = null
      
      null

    emit: (eventName, data)=>
      if record then @recordEvent(eventName, data)

      return unless events[eventName]
  
      _.each events[eventName], (callback)->
        callback(data)
      
      true
      
    recordEvent: (eventName, data)->
      recordedEvents[time] ||= []
      recordedEvents[time].push({eventName: eventName, data: data})
      
    setTime: ->
      time += 1
      
    timerStart: =>
      timer = window.setInterval(@setTime, 100)
    
    timerStop: ->
      clearInterval(timer)
    
    toggleRecord: =>
      record = !record
      if record
        @timerStart()
      else
        @timerStop()
    
    playing: ->
      playing
    
    playback: =>
      playing = true
      t = 0
      @emit "content:play"
      
      window.setInterval ->
        _.each recordedEvents[t], (evt)->
          if evt
            _.each events[evt.eventName], (callback)->
              callback(evt.data)
        t += 1
      , 
        100
    
