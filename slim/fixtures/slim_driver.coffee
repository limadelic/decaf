_ = require 'underscore'

class Database
  clean: () -> @table = []
  persist: (item) -> @table.push item
  get: (name) -> _.find @table, (item) -> item.name is name

db = new Database()

class Service
  createPerson: (name) -> db.persist name: name
  ensureExists: (name) -> db.get(name)?

class exports.SlimDriver
  sut: new Service()
  init: () -> db.clean()


