discard """
  action: "compile"
"""

import tables
import ../../src/templater

const
  invalidTemplate = """
  <!DOCTYPE html>
  <html>
    <head>
      <title>
        {{pageTitle}}
      </title>
    </head>
  
    <body>
      {{#for item in items}}
      {{#for item2 in items}}
      <p>{{item}}</p>
      {{#endfor}}
    </body>
  </html>
  """

block invalidTemplate_raisesValidationError:
  doAssertRaises(ValidationError):
    discard newParser(invalidTemplate, newTable[string, Variable]())