class exports.FixtureLoader

  path: [ '.' ]

  constructor: ->
    return if process.argv.length < 4
    @path = @path.concat process.argv[2].split ';'

  require: (module) ->
    currdir = process.cwd()
    for path in @path
      try return require currdir + '/' + path + '/' + module catch e
    throw 'Cannot find ' + module


