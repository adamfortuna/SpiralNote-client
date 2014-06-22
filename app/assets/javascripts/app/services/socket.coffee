angular.module('fullStackClass').factory 'FSCSocket', (FSCSocketRpc)->
  socketUrl = "#{window.location.hostname}:#{8282}"
  socketLink = null
  
  createHash: (string)->
    if Array::reduce
      return string.split("").reduce((a, b) ->
        a = ((a << 5) - a) + b.charCodeAt(0)
        a & a
      , 0)
    hash = 0
    return hash  if string.length is 0
    i = 0

    while i < string.length
      character = string.charCodeAt(i)
      hash = ((hash << 5) - hash) + character
      hash = hash & hash # Convert to 32bit integer
      i++
    hash

  establishConnection: ->
    # Temp, we'll probably pass the user data to this function
    userData = {user_name: "Adam R", email: "adamrensel@email.com"}

    socketLink = io(socketUrl, {query: "user=#{JSON.stringify({userName: userData.user_name, email: userData.email})}"})

  socket: ->
    socketLink
  
  emit: (eventName, data)->
    socketLink.emit(eventName, data)
  
  on: (eventName)->
    socketLink.on(eventName)
    
  once: (eventName)->
    socketLink.once(eventName)
    
  func: (fName, args)=>
    FSCSocketRpc.callFunction(socketLink, fName, args)
    
    
  
