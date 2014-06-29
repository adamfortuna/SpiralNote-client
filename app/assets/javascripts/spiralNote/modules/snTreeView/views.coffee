angular.module('sn:treeView').config (snApiProvider)->
  snApiProvider.view.addTo 'sidebar', """
    <sn-tree-view></sn-tree-view>
  """
