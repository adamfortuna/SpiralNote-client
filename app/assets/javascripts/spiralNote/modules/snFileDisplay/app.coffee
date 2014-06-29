angular.module('sn:fileDisplay', ['sn:core']).config (snApiProvider)->
  snApiProvider.exposeToApi (api, injector)->
    fileDisplay:
      saveActive: ->
        injector.get('snFileDisplay').saveActiveBuffer()
