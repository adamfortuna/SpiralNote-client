angular.module('sn:core').factory 'snEventHandler', ->
  class SnEventHandler
    events = {}
    
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

    emit: (eventName, data)->
      return unless events[eventName]
  
      _.each events[eventName], (callback)->
        callback(data)
      
      true
      
    
