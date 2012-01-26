class exports.Calculator

  result: 0

  clear: () -> @result = 0

  add: (n) -> @result += Number n

  multiplyTimes: (n, times) -> @result = n * times

