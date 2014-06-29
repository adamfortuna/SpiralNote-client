angular.module('sn:consoleDisplay').config (snApiProvider)->
  snApiProvider.view.addTo 'bottom', """
    <sn-console-display></sn-console-display>
  """
