angular.module('sn:treeView').config (snContextualMenuProvider)->
  snContextualMenuProvider.add
    '.tree-view-file':
      'Copy': 'treeView:copySelected'
      'Delete': 'treeView:deleteSelected'
      'Paste': 'treeView:paste'
