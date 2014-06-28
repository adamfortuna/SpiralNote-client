angular.module('fsc:treeView').config (FSCContextualMenuProvider)->
  FSCContextualMenuProvider.add
    '.tree-view-file':
      'Copy': 'treeView:copySelected'
      'Delete': 'treeView:deleteSelected'
      'Paste': 'treeView:paste'
