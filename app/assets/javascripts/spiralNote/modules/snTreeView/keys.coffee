angular.module('sn:treeView').config (snKeybindingsProvider)->
  snKeybindingsProvider.registerKeyBindings
    '.tree-view':
      'cmd+o': 'treeView:openSelected',
      'cmd+c': 'treeView:copySelected',
      'cmd+v': 'treeView:paste'
