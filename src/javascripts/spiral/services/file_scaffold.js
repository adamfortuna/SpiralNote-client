angular.module('spiral').factory('FileScaffold', ['guid', function (guid) {
  return function() {
    return [
      { "type": "directory", "name": "Demo", "uid": guid(), "expanded": true, "files": [
          { "type": "directory", "name": "javascripts", "uid": guid(), "expanded": true, "files": [
              { "type": "file", "name": "application.js", "uid": guid(), "contents": "var test=true;", "syntax": "javascript" }
            ]
          },
          { "type": "directory", "name": "stylesheets", "uid": guid(), "expanded": true, "files": [
              { "type": "file", "name": "application.css", "uid": guid(), "contents": "body {\n\n}", "syntax": "css" }
            ]
          },
          { "type": "file", "name": "index.html", "uid": guid(), "syntax": "html", "contents": "<html>\n</html>", "open": true, "active": true }
        ]
      }
    ];
  }
}]);
