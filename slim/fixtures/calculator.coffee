class exports.Calculator

  constructor: (n = 0) -> @result = Number n

  square: (x) -> x * x

  clear: () -> @result = 0

  enter: (n) -> @result = Number n

  add: (n) -> @result += Number n

  multiplyTimes: (n, times) -> @result = n * times

  div: (n) -> @result /= n

  sqrt: (n) -> @result = Math.sqrt n

  drop_water: () -> throw 'sparks'

