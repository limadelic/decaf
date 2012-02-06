{ Server } = require './server'

port = process.argv[process.argv.length - 1]

new Server().start port