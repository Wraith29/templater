discard """
  action: "run"
"""

import tables
import ../../src/templater
import strutils

block parseTemplate_insertsCorrectData:
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

block parseTemplate_multipleIterators_inserted:
  const templ = """
  <ul>
    {{#for item in items}}
    <li>{{#item}}</li>
    {{#endfor}}
  </ul>

  <ul>
    {{#for item in items | idx}}
    <li>{{#idx}}: {{#item}}</li>
    {{#endfor}}
  </ul>
  """

  var variables = newTable[string, Variable]([
    ("items", newVariable(@[newVariable("Item 0"), newVariable("Item 1")]))
  ])

  var parser = newParser(templ, variables)
  let output = parser.parse()

  doAssert output.contains("<li>Item 0</li>")
  doAssert output.contains("<li>Item 1</li>")
  doAssert output.contains("<li>0: Item 0</li>")
  doAssert output.contains("<li>1: Item 1</li>")
  doAssert not output.contains("#")
