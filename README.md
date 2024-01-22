# Templater

A Nim-based HTML templating engine

## How to use

```nim
import templater

let variables = newTable[string, Variable]([("pageTitle", newVariable("Page Title"))])
var p = newParser(staticRead "myTemplate.html", variables)

let content = p.parse()
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
