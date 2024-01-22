discard """
  action: "run"
"""

import tables
import ../../src/templater
import strutils

const
  templ = """
  <!DOCTYPE html>
  <html>
    <head>
      <title>{{pageTitle}}</title>
    </head>

    <body>
      <h1>{{hello}}</h1>

      <ul>
        {{#for item in items}}
        <li>{{#item}}</li>
        {{#endfor}}
        </ul>
    </body>
  </html>
  """

block parseTemplate_insertsCorrectData:
  var variables = newTable[string, Variable]([
    ("pageTitle", newVariable("My Page Title")),
    ("hello", newVariable("Welcome to my parsed template")),
    ("items", newVariable(@[newVariable("Item 1")]))
  ])
  var parser = newParser(templ, variables)

  let output = parser.parse()

  doAssert output.contains("<title>My Page Title</title>")
  doAssert output.contains("<h1>Welcome to my parsed template</h1>")
  doAssert output.contains("<li>Item 1</li>")