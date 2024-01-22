import regex
import tables
import variable
import strutils

const
  variablePattern = re2 "\\{\\{([a-zA-Z0-9]*)\\}\\}"
  forLoopPattern = re2 "\\{\\{#for\\s*([a-zA-Z0-9]*)\\s*in\\s*([a-zA-Z0-9]*)\\s*(?:\\|\\s*([a-zA-Z0-9]*))?\\}\\}"
  endForPattern = re2 "\\{\\{#endfor\\}\\}"

type
  ValidationError* = object of ValueError

  Parser* = ref object
    templ: string
    variables: TableRef[string, Variable]
    index: int

## Returns a list of validation issues, to output to the user
proc validate(templ: static string): seq[string] =
  echo "Validating template"
  result = newSeq[string]()

  let
    forLoops = templ.findAll(forLoopPattern)
    endFors = templ.findAll(endForPattern)

  if forLoops.len != endFors.len:
    result.add("No. of ForLoops not equivalent to No. of EndFors")
    result.add("No. of ForLoops not equivalent to No. of EndFors")

func newParser*(templ: static string; variables: TableRef[string, Variable]): Parser {.raises: [ValidationError].} =
  ## Creates a new parser, and validates the template on build
  ## 
  ## `templ` must be a static string, meaning to load an actual template you must do:
  ## ```nim
  ## var parser = newParser(staticRead "myfile.html", newTable[string, Variable]())
  ## ```
  ## If there is a validation error on build, you can either handle the ValidationError, or let it output
  const errors = templ.validate()
  if errors.len != 0:
    raise ValidationError.newException(errors.join(",\n"))

  Parser(templ: templ, index: 0, variables: variables)

proc parse*(p: var Parser): string =
  ##

when isMainModule:
  let t = newTable[string, Variable]()

  var p = newParser("""
    {{#for item in items}}
    {{#for item2 in items}}
    {{#endfor}}
  """, t)
  
  echo p.parse()
