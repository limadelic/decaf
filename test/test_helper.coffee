sinon = require 'sinon'
global.mock = sinon.mock
global.stub = sinon.stub
global.spy = sinon.spy

global.verify = (fact) -> fact.should.be.true

global.p = (x) -> console.log JSON.stringify x
global.m = (x) -> p (name for name of x)