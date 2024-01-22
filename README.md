# Templater

A Nim-based HTML templating engine

## How to use

```nim
import templater

let variables = newTable[string, Variable]([("pageTitle", newVariable("Page Title"))])
var p = newParser(staticRead "myTemplate.html", variables)

let content = p.parse()
```
