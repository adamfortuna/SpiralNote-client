angular.module('sn:fileDisplay', ['sn:core']).config (snApiProvider)->
  snApiProvider.exposeToApi
    fileDisplay:
      active: ->
        # Tie in a service class here for this module's api
