# Notes on how the api modules have access to should look
The core api should be kept fairly generic. Modules should be built for almost
all functionality related to the ui. Anything that relies on changes to the server
code should go in core.

## Top level api object
`snApi`

## Event Dispatcher
`snApi.event`

functions:
  - `on(evt, callback)` - listen for an event, any data is passed to the callback
  - `once(evt, callback)` - listen for an event once, then the listener is removed
  - `off(evt, [callback])` - remove listener, pass a function to remove a specific listener
    or just the evt name to remove them all.
  - `emit(evt, [data])` - emit an event, optional data can be passed as the 2nd argument

## Files
`snApi.fs`

Api calls  related to file system access, these are going to be all async functions
since they are sent across the wire.
  
functions:
  - `copy(sourcePath, targetPath)` - copy file/directory from source to target
  - `move(sourcePath, targetPath)` - move file/directory from source to target
  - `delete(path)` - delete target (do we need a recurse option here? or can we just handle targets that are 
    directories automatically?)
  - `mkdir(path)` - Create a new directory (This should support creating directories that don't exist automatically)
  - `create(path)` - Create a new file (This should support creating directories that don't exist automatically)
  - `dirIndex(path)` - Returns an index hash of the directory given. This needs to
     be structured in such a way that we can use it for file indexing and quick jump like sublime text.
  - `dirList(path)` - returns an object representing directory structure, this needs
     to also contain file types. This is intended for use in something like the file tree view
  - `read(path)` - returns the contents of a file. It is probably a good idea to send a url
     for binary files. So we should send back a filetype so that it can be handled
     in the client. We can just display images and render pdfs in pdf.js if needed.

events:
  All events should contain the path/name of the specified file/directory
  - `fs.file:created` - A new file is created
  - `fs.file:modified` - A file is modified
  - `fs.file:deleted` - A file is deleted
  - `fs.file:moved` - A file is moved (should contain a `to:` param with the destination path)
  - `fs.dir:created` - A new dir is created
  - `fs.dir:modified` - A dir is modified
  - `fs.dir:deleted` - A dir is deleted
  - `fs.dir:moved` - A dir is moved(should contain a `to:` param with the destination path)

## Modules
`snApi.module`

The modules api is intended to allow access to other modules

  - `get(moduleName)` - Returns the module's list of exposed api functions
    This can also be used to target a specific function. ex: `get("treeView:files:select")("path/to/file")`
    
## KeyBindings
  `snApi.keyBindings`
  - `add(obj)` - add new keybindings, obj should be structured with a class at the top
    level and key combinations as 2nd level keys. ex:
    
    ```javascript
    {
      '.tree-view': {
        'cmd+o': 'treeView:openSelected',
        'cmd+c': 'treeView:copySelected',
        'cmd+v': 'treeView:paste'
      }
    }
    ```
  
## Menu
  `snApi.menu`
  
  ### Context
  `snApi.menu.context`
  Contextual right click menu
  
  - `add(obj)` - Adds new menu items to a menu scoped to the current target of the right click ex:
    
    ```javascript
      {
        '.tree-view-file': {
          'Copy': 'treeView:copySelected',
          'Delete': 'treeView:deleteSelected',
          'Paste': 'treeView:paste'
        }
      }
    ```
