angular.module('sn:fileDisplay').config (snApiProvider)->
  snApiProvider.view.addTo 'right', """
    <sn-file-display></sn-file-display>
  """
