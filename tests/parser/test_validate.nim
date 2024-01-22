discard """
  action: "compile"
"""

import tables
import ../../src/templater

const
  validTemplate = """
  <!DOCTYPE html>
  <html>
    <head>
      <title>
        {{pageTitle}}
      </title>
    </head>
  
    <body>
      {{#for item in items}}
      <p>{{item}}</p>
      {{#endfor}}
    </body>
  </html>
  """

doAssertRaises(ValidationError):
  discard newParser(validTemplate, newTable[string, Variable]())