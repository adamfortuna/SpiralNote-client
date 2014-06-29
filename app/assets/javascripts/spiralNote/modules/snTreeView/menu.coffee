angular.module('sn:treeView').config (snApiProvider)->
  snApiProvider.menu.context.add
    '.tree-view-file':
      'Copy': 'treeView:copySelected'
      'Delete': 'treeView:deleteSelected'
      'Paste': 'treeView:paste'
