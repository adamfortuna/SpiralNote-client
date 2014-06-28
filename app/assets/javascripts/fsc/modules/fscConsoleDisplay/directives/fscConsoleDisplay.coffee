angular.module('fsc:consoleDisplay').directive 'fscConsoleDisplay', (FSCSocket, $rootScope, $timeout)->
  replace: true
  restrict: "E"
  scope: {}
  template: """
    <div class="console console--single">
      <div class="console-ui"></div>
    </div>
  """
  link: (scope, element, attrs)->
    scope.currectReport = null
    scope.challengeComplete = false
    currentDir = '.'
    
    scope.console = new CSConsole $(element).find(".console-ui")[0],
      prompt: '$ '
      historyLabel: "fullstackclass-console"
      # syntax: consoleData.type
      welcomeMessage: 'Welcome to full stack class!'
      autoFocus: false
      # initialValue: consoleData.starting_content
      commandValidate: (line)->
        return line.length > 0
      commandHandle: (line, report, prompt)->
        FSCSocket.func('sysRunConsoleCommand', {command: line, dir: currentDir}).then (data)->
          currentDir = data.result.dir
          report({content: data.result.stdout || data.result.stderr || ''})
