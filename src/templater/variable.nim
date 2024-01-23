import strutils

type
  VariableKind = enum
    vkInt, vkStr, vkArr

  Variable* = ref object
    case kind: VariableKind:
    of vkInt: intVal: int
    of vkStr: strVal: string
    of vkArr: arrVal: seq[Variable]

func `$`*(v: Variable): string {.raises: [].} =
  return case v.kind:
    of vkInt: $v.intVal
    of vkStr: $v.strVal
    of vkArr: v.arrVal.join(", ")

func newVariable*(i: int): Variable {.raises: [].} =
  Variable(kind: vkInt, intVal: i)

func newVariable*(s: string): Variable {.raises: [].} =
  Variable(kind: vkStr, strVal: s)

func newVariable*(arr: seq[Variable]): Variable {.raises: [].} =
  Variable(kind: vkArr, arrVal: arr)

template isArray*(v: Variable): bool = v.kind == vkArr

iterator items*(v: Variable): Variable =
  assert v.isArray
  
  for item in v.arrVal:
    yield item
