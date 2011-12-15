port = process.argv[2]

{ writeFile } = require 'fs'

writeFile 'out.txt', "
=============================\n
decaf running on port:#{port}\n
slim -- v0.3                 \n
=============================\n
"

app = require('express').createServer()
io = require('socket.io').listen(app)

app.listen port

io.on 'connection', -> console.log 'yay!!'