angular.module('sn:consoleDisplay').config (snApiProvider)->
  snApiProvider.keyBindings.add
    '.tree-view':
      'cmd+o': 'treeView:openSelected',
      'cmd+c': 'treeView:copySelected',
      'cmd+v': 'treeView:paste'
