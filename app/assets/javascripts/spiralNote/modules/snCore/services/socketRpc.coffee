# A simple service class to make remote procedure calls across a socket connection
# used in conjuntion with the node rpc.coffee file.

angular.module('sn:core').factory 'snSocketRpc', ($q)->
  rpcId = 0
  
  # returns a promise
  callFunction: (socket, fName, args)=>
    deferred = $q.defer()
    funcId = rpcId += 1
    socket.emit("rpc:function:call", {function: fName, functionArgs: args, id: funcId})
    socket.once "rpc:#{fName}:result:#{funcId}", (result)->
      if result.error
        deferred.reject(result)
      else
        deferred.resolve(result)
    
    deferred.promise
