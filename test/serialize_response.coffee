{ serialize } = require '../src/serializer'

describe 'response deserializer', ->

  verify = (response, result) ->
    serialize(response).should.equal result

  it 'should serialize empty', ->

    verify [], '000009:[000000:]'

  it 'should serialize single item', ->

    verify ['hello'], '000022:[000001:000005:hello:]'

  it 'should serialize simple list', ->

    verify ['good', 'bye'],
      '000032:[000002:000004:good:000003:bye:]'

  it 'should serialize nested list', ->

    verify ['good', 'bye', ['blue', 'sky']],
      '000072:[000003:000004:good:000003:bye:000032:'+
      '[000002:000004:blue:000003:sky:]:]'

  it 'should serialize non string types', ->

    verify [42], '000019:[000001:000002:42:]'
    verify [false], '000022:[000001:000005:false:]'

  it 'should serialize null elements', ->

    verify [null], '000021:[000001:000004:null:]'
    verify [undefined], '000021:[000001:000004:null:]'
    verify [''], '000017:[000001:000000::]'
