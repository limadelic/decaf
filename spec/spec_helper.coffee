should = require 'should'

sinon = require 'sinon'
exports.mock = sinon.mock
exports.stub = sinon.stub
exports.spy = sinon.spy

exports.verify = (fact) -> fact.should.be.true