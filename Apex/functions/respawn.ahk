RespawnFunc() {
  isCell := ImageSearchFunction(Cell, CellX, CellY, , , , , 25)
  isReque := ImageSearchFunction(Reque, RequeX, RequeY, , , , , 25)

  If (isCell) {
    KeysFunction("w down")
    KeysFunction("w up")
  }

  If isReque
    KeysFunction("1")
}