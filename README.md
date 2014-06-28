# SpiralNote

Spiral note is an in browser text editor designed to use socket.io to edit files
on a server. It uses CodeMirror and AngularJS to do the heavy lifting.

The client and server app are separate right now purely because I wanted easy asset
handling with rails while in heavy development. The client portion is designed to
be used as an AngularJS module, and can be used within any app. The server is written
in nodeJS and can be found at: [SpiralNote-server](https://github.com/renz45/SpiralNote-server)

# Running the app
It's simple, just bundle the rails and and run `rails s`. Instructions for running
the node socket server are in the server repo.


# Wat no tests?
Yea, this is a side project at the moment, I'm not entirely sure how the module
system and api is going to work, so until I get something solidified I'm holding
off on tests.
