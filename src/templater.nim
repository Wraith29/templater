import regex
import templater/[parser, variable]

proc loadTemplate*(templ: static string; vars: VarTable): string {.raises: [ValidationError, VariableError, KeyError, RegexError].} =
  var p = newParser(templ, vars)
  return p.parse()

proc loadTemplateFile*(fileName: static string; vars: VarTable): string {.raises: [ValidationError, VariableError, KeyError, RegexError].} =
  ## fileName should be a fully qualified path
  const templ = staticRead(fileName)
  return loadTemplate(templ, vars)

export variable