class exports.Calculator

  result: 0

  clear: () => @result = 0

  add: (n) => @result += Number n

  multiplyTimes: (x, y) => @result = x * y

