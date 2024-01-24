# Templater

A Nim-based HTML templating engine.

Performs Compile-time template validation, to ensure you don't get any nasty surprises when running your code.

## Usage

### Load from Template String

```nim
import templater

const myTemplate = """
<!DOCTYPE html>
<html>
    <head>
        <title>{{pageTitle}}</title>
    </head>

    <body>
        <h1>{{myHeader}}</h1>
        <ul>{{#for item in items | index}}
            <li>{{#index}}: {{#item}}</li>
        {{#endfor}}</ul>
    </body>
</html>
"""

let vars = newVarTable(("pageTitle", newVariable("My Page Title")), ("myHeader", newVariable("Page Header")), ("items", newVariable(@[newVariable("Item 0"), newVariable("Item 1")])))

let renderedTemplate = loadTemplate(myTemplate, vars)
```

### Load from a Template file

```nim
let vars = newVarTable(("pageTitle", newVariable("My Page Title")), ("myHeader", newVariable("Page Header")), ("items", newVariable(@[newVariable("Item 0"), newVariable("Item 1")])))

let renderedTemplate = loadTemplateFile(staticRead("template.html"), vars)
```

## Template Syntax

Variables:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>{{pageTitle}}</title>
    </head>

    <body>
        <h1>{{welcomeMessage}}</h1>
   </body>
</html>
```

Lists:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>My Page</title>
    </head>

    <body>
        <li>
            {{#for item in items}}
            <li>{{#item}}</li>
            {{#endfor}}
        </li>

        <li>
            {{#for item in items | index}} <!--index here is optional, and can be named anything-->
            <li>{{#index}}: {{#item}}</li>
            {{#endfor}}
        </li>
   </body>
</html>

```
