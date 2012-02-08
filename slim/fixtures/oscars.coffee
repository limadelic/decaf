nominees = () -> [['Title', title]] for title in [
  'The Artist'
  'The Descendants'
  'Extremely Loud and Incredibly Close'
  'The Help'
  'Hugo'
  'Midnight in Paris'
  'Moneyball'
  'The Tree of Life'
  'War Horse'
]

class exports.TheNomineesAre
  query: -> nominees()

class exports.AndTheAwardGoesTo
  query: -> nominees()
