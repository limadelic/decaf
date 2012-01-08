{ mock, stub } = require 'sinon'
exports.mock = mock
exports.stub = stub

exports.should = require 'should'

exports.verify = (fact) -> fact.should.be.true