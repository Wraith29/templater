discard """
  action: "run"
"""

import ../../src/templater

block variableToString_mapsStringCorrectly:
  let v = newVariable("My String")

  doAssert "My String" == $v

block variableToString_mapsIntCorrectly:
  let v = newVariable(123)

  doAssert "123" == $v

block variableToString_mapsArrayCorrectly:
  let v = newVariable(@[newVariable(1), newVariable(2), newVariable(3)])

  doAssert "1, 2, 3" == $v