welcomeNmail = {
	send = function(player)
		mail = "===[ Welcome to RetroTK ]===\n"
		mail = mail .. "==================================\n"
		mail = mail .. "A wonderous world of adventure is ahead of you. \n"
		mail = mail .. "To Walk - Use the Arrow Keys, left click, or hold right click. \n"
		mail = mail .. "To Attack - Use the Space bar, Auto Attack Spell, or Left Click. \n"
		mail = mail .. "\n"
		mail = mail .. "If you are having issues with NPCs, Mobs, or Items not appearing, please contact a GM or use the helpdesk on the website. \n"
		mail = mail .. "\n"

		mail = mail .. "Communication: \n"
		mail = mail .. "\n"
		mail = mail .. "To Talk - Press the Enter or \' Key. \n"
		mail = mail .. "Shift+\' (Quote) - Then type in the player name, then enter, \n"
		mail = mail .. "and then type your message and send it with the Enter key. \n"
		mail = mail .. "Whisper ! to chat with your clan members.\n"
		mail = mail .. "Whisper !! to chat with your group members.\n"
		mail = mail .. "Whisper @ to chat with your subpath members.\n"
		mail = mail .. "Whisper ? to reach out to mentors for help.\n"
		mail = mail .. "Whisper & to chat with other members looking to hunt (must join hunter list).\n"
		mail = mail .. "\n"
		mail = mail .. "Shift+1 or ! - To Shout. This reaches further than Normal Talk. \n"
		mail = mail .. "Shift+; or : - Express Emotions. Select a letter and see for yourself. \n"
		mail = mail .. "b - Opens the Boards to Read and Reply to Forum Threads! \n"
		mail = mail .. "g - Press g then type in player name and hit enter to Group! \n"
		mail = mail .. "Shift+g - Toggle On/Off your Group. \n"
		mail = mail .. "m - Press m to Open your personal Mailbox! \n"
		mail = mail .. "\n"
		mail = mail .. "Combat: \n"
		mail = mail .. "\n"
		mail = mail .. "Space Bar - Swings your Weapon \n"
		mail = mail .. "t - Press t then a letter of item in Inventory to Throw It! \n"
		mail = mail .. "Shift+z or Z - Cast a Spell by pressing Z then letter of spell then Enter \n"
		mail = mail .. "         Example: Z then s Enter. This casts spell in s slot from Spell Book!\n"
		mail = mail .. "e - Eat an Item by pressing e, then letter of food in Inventory! \n"
		mail = mail .. "u - Use an item by pressing u then letter of item in Inventory! \n"
		mail = mail .. "w or Shift+w or W - Wield any Equipment in Inventory by letter! \n"
		mail = mail .. "T - Take off item by Prompt in chat window. You can also \n"
		mail = mail .. "        remove items from status screen by double clicking! \n"
		mail = mail .. "\n"
		mail = mail .. "Miscellaneous: \n"
		mail = mail .. "\n"
		mail = mail .. "/ping - check on your connection status! \n"
		mail = mail .. "/played - See how long youve been playing for! \n"
		mail = mail .. "Shift+Q or Alt-X - To Close Out and Leave the Game! \n"
		mail = mail .. "r - Can be used to Ride wild Horses! \n"
		mail = mail .. "o - Press o to Open Doors and Interact with Objects! \n"
		mail = mail .. "Shift+E - Toggles On/Off Exchange Feature! \n"
		mail = mail .. "f - Opens the Group Tab to see your Party! \n"
		mail = mail .. "Shift+i or I - Opens the Creation System Interface! \n"
		mail = mail .. "Ctrl+Arrow Keys - This will move camera one tile at a time! \n"
		mail = mail .. "1, 2, 3, 4, 5, 6, 7, 8, 9, 0 - The number Keys are for Quickcast! \n"
		mail = mail .. "    Default is letter a - j in Spell List for 1 - 0. \n"
		mail = mail .. "    Use the Spell Macro List (F11)To customize! \n"
		mail = mail .. "Scroll Lock - Take a Screenshot to Remember! \n"
		mail = mail .. "Shift+/ or ? - To See Most of this List in Game! \n"
		mail = mail .. "==================================\n"
		mail = mail .. "Thanks for reading and we hope you enjoy your time spent with us on RetroTK!\n"

		mail2 = "===[ Welcome to RetroTK ]===\n"
		mail2 = mail2 .. "==================================\n"
		mail2 = mail2 .. "Hot Keys: \n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. "F1 Menu - Character Status Screen, Character Info & Stats, Toggles, and more as added. \n"
		mail2 = mail2 .. "F2 - Turn �Subpath Chat� On/Off! \n"
		mail2 = mail2 .. "F3 - Friends List. Save Player Names Here. \n"
		mail2 = mail2 .. "F4 - Realm Center. Locks/Unlocks Camera. \n"
		mail2 = mail2 .. "F5 - Turn �Whispers� (Private Messages) On / Off! \n"
		mail2 = mail2 .. "F6 - Turn �Shouts� (Kingdom Messages) On/Off! \n"
		mail2 = mail2 .. "F7, F8 - Turn Volume Up/Down \n"
		mail2 = mail2 .. "F9 - Ignore List. If someone is bothering you add them here. \n"
		mail2 = mail2 .. "F10 - Option Tab to Turn On/Off many Features\n"
		mail2 = mail2 .. "F11 - Spell Macro List. To Set Up Your Spells 1-0. a-j is default \n"
		mail2 = mail2 .. "F12 - Fast Walk On/Off Toggle \n"
		mail2 = mail2 .. "Ctrl-R - This will refresh your screen. \n"
		mail2 = mail2 .. "Ctrl-W - Opens the User List. Can click on names to Whisper them. \n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. "Your Character: \n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. "s - Opens your Status Tab! Page Up/Down to See your Legend! \n"
		mail2 = mail2 .. "i - Press i to open your Inventory Tab! Press Again to Expand List! \n"
		mail2 = mail2 .. "Shift+= or + - To Open your Spell List! Press Again to Expand List!  \n"
		mail2 = mail2 .. "c - Press c then letter of inventory item then comma then another item.\n"
		mail2 = mail2 .. "     Example: c then a,b Enter. This will swap item a and b in Inventory! \n"
		mail2 = mail2 .. "Shift+c or C - Press C then letter of Spell, then comma, then another. \n"
		mail2 = mail2 .. "     Example: C then i,j Enter. This will swap Spells in i and j in Spell List!\n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. "Pick up, Transfer, Drop: \n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. ", - Comma Picks Up One Item Under You and Place it in your Inventory! \n"
		mail2 = mail2 .. "Shift+, or . - This will Pick Up ALL Items Under You Place in Inventory! \n"
		mail2 = mail2 .. "Ctrl+, - This will Pick Up All Items in all Tile Around You! (9 Tiles) \n"
		mail2 = mail2 .. "h - Hand an item by letter number or Gold with \ Key! \n"
		mail2 = mail2 .. "H - Hand ALL of an item by letter or  Gold with \ Key! \n"
		mail2 = mail2 .. "d - Drop an Item by letter or Gold with \ Key! \n"
		mail2 = mail2 .. "D - Drop all of an Item by letter. View Inventory with ? Key! \n"
		mail2 = mail2 .. "\n"
		mail2 = mail2 .. "==================================\n"
		mail2 = mail2 .. "Thanks for reading and we hope you enjoy your time spent with us on RetroTK!\n"

		player:sendMail(player.name, "Controls and Hotkeys", mail2 .. "")
		player:sendMail(player.name, "Welcome to RetroTK!", mail .. "")
	end
}
