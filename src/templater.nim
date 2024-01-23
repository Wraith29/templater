import templater/parser
import templater/variable
import regex

proc loadTemplate*(templateName: static string; variables: VarTable): string {.raises: [ValidationError, VariableError, KeyError, RegexError].} =
  var p = newParser(staticRead(templateName), variables)
  return p.parse()

export parser
export variable