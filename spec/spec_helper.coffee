sinon = require 'sinon'
exports.mock = sinon.mock
exports.stub = sinon.stub
exports.spy = sinon.spy

exports.should = require 'should'

exports.verify = (fact) -> fact.should.be.true