angular.module('fsc:treeView').config (FSCKeybindingsProvider)->
  FSCKeybindingsProvider.registerKeyBindings
    '.tree-view':
      'cmd+o': 'treeView:openSelected',
      'cmd+c': 'treeView:copySelected',
      'cmd+v': 'treeView:paste'
