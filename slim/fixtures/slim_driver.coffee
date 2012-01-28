_ = require 'underscore'

db = new Database()
class Database
  clean: () -> @table = []
  persist: (item) -> @table.puts item
  get: (name) -> _.find @table, (item) -> item.name is name

class exports.SlimDriver
  sut: new Service()
  init: () -> db.clean()

class Service
  createPerson: (name) -> db.persist name: name
  exists: (name) -> db.get name



