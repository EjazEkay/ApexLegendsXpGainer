MainMenuFunc() {
  isLoading_Screen := ImageSearchFunction(Loading_Screen, Loading_ScreenX, Loading_ScreenY, , , , , 25)
  If isLoading_Screen
    KeysFunction("space")
}