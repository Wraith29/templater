import src/templater

const myTemplate = """
<!DOCTYPE html>
<html>
    <head>
        <title>{{pageTitle}}</title>
    </head>

    <body>
        <h1>{{myHeader}}</h1>
        <ul>
          {{#for item in items}}
          <li>{{#item}}</li>
          {{#endfor}}
        </ul>


        <ul>
          {{#for item2 in items | index}}
            <li>{{#index}}: {{#item2}}</li>
          {{#endfor}}
        </ul>
   </body>
</html>
"""

proc test*()  =
  let vars = newVarTable(
    ("pageTitle", newVariable("My Page Title")),
    ("myHeader", newVariable("Page Header")),
    ("items", newVariable(@[newVariable("Item 0"), newVariable("Item 1")]))
  )
  let renderedTemplate = loadTemplate(myTemplate, vars)

  echo renderedTemplate

test()