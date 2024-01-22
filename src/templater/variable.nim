type
  VariableKind = enum
    vkInt, vkStr, vkArr

  Variable* = ref object
    case kind: VariableKind:
    of vkInt: intVal: int
    of vkStr: strVal: string
    of vkArr: arrVal: seq[Variable]

template newVariable*(i: int): void = Variable(kind: vkInt, intVal: i)
template newVariable*(s: string): void = Variable(kind: vkStr, strVal: s)
template newVariable*(arr: seq[Variable]): void = Variable(kind: vkArr, arrVal: arr)
