{ verify } = require './spec_helper'

describe 'testing the tests', ->

  it 'should find the fixtures', ->

    sut = require '../slim/fixtures/slim_driver'
    verify sut?