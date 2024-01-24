import templater/parser
import templater/variable
import regex

proc loadTemplate*(templ: static string; vars: VarTable): string {.raises: [ValidationError, VariableError, KeyError, RegexError].} =
  var p = newParser(templ, vars)
  return p.parse()

proc loadTemplateFile*(fileName: static string; vars: VarTable): string {.raises: [ValidationError, VariableError, KeyError, RegexError].} =
  return loadTemplate(staticRead(fileName), vars)

export parser
export variable