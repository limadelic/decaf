class exports.LibraryFixture

class EchoSupportBase
  called: false
  echoSupport: -> @called = true

class exports.EchoSupport extends EchoSupportBase
  echoSupportCalled: -> @called

class exports.SpecialEchoSupport extends EchoSupportBase
  specialEchoSupportCalled: -> @called

class exports.LibraryInSetUp extends EchoSupportBase
  echoInSetUpLibraryCalled: -> @called