LobbyFunc(activeMode) {
  isReady_Button := ImageSearchFunction(Ready_Button, Ready_ButtonX, Ready_ButtonY, , , , , 25)
  isMatch_Type := ImageSearchFunction(Match_Type, Match_TypeX, Match_TypeY, , , , , 25)
  isEsc_Key := ImageSearchFunction(Esc_Key, Esc_KeyX, Esc_KeyY, , , , , 25)
  isSpace_Summary := ImageSearchFunction(Space_Summary, Space_SummaryX, Space_SummaryY, , , , , 25)

  If isEsc_Key
    ClickFunction(Esc_KeyX, Esc_KeyY, , 1000)

  If (isSpace_Summary) {
    KeysFunction("space")
    KeysFunction("space")
    KeysFunction("space")
  }

  If (isReady_Button && isMatch_Type && activeMode) {
    ClickFunction(Ready_ButtonX, Ready_ButtonY, 1, 1000)
  } Else If (isReady_Button && !isMatch_Type && activeMode) {
    ClickFunction(Ready_ButtonX, Ready_ButtonY - 150, , 1000)
    ClickFunction(Ready_ButtonX + 900, Ready_ButtonY - 200, , 1000)
    ClickFunction(Ready_ButtonX, Ready_ButtonY, 1, 1000)
  } Else If (isReady_Button && !isMatch_Type && !activeMode) {
    ClickFunction(Ready_ButtonX, Ready_ButtonY, 1, 1000)
  } Else If (isReady_Button && isMatch_Type && !activeMode) {
    ClickFunction(Ready_ButtonX, Ready_ButtonY - 150, , 1000)
    ClickFunction(Ready_ButtonX, Ready_ButtonY - 450, , 1000)
    ClickFunction(Ready_ButtonX, Ready_ButtonY, 1, 1000)
  }
}