--WEAPON SHOP----------------------------------------------------------------------------------------------------------
weapon_smith = {
	buy = function(player)
		local buyOptsOne = {"Fighter", "Scoundrel", "Wizard", "Priest"}

		menuOptionBuy = player:menuString("What kind of weapons are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			player:buyExtend("What do you wish to buy?", {16001, 16002, 16003, 16004, 16005, 16006, 16007, 16008, 16009, 16010})
		elseif menuOptionBuy == "Scoundrel" then
			player:buyExtend("What do you wish to buy?", {17001, 17002, 17003, 17004, 17005, 17006, 17007, 17008, 17009, 17010})
		elseif menuOptionBuy == "Wizard" then
			player:buyExtend("What do you wish to buy?", {18001, 18002, 18003, 18004, 18005, 18006, 18007, 18008, 18009, 18010})
		elseif menuOptionBuy == "Priest" then
			player:buyExtend("What do you wish to buy?", {19001, 19002, 19003, 19004, 19005, 19006, 19007, 19008, 19009, 19010})
		end
	end,
	sell = function(player)
		local sellitems = {
			16001,
			16002,
			16003,
			16004,
			16005,
			16006,
			16007,
			16008,
			16009,
			16010,
			17001,
			17002,
			17003,
			17004,
			17005,
			17006,
			17007,
			17008,
			17009,
			17010,
			18001,
			18002,
			18003,
			18004,
			18005,
			18006,
			18007,
			18008,
			18009,
			18010,
			19001,
			19002,
			19003,
			19004,
			19005,
			19006,
			19007,
			19008,
			19009,
			19010,
			434,
			435,
			436,
			437,
			16051,
			16052,
			16053,
			16054,
			16055,
			16056,
			16057,
			16058,
			16059,
			16060,
			16062,
			16063,
			16064,
			16065,
			16066, --Item drops 4/17
			17051,
			17052,
			17053,
			17054,
			17055,
			17056,
			17057,
			17058,
			17059,
			17060,
			17062,
			17063,
			17064,
			17065,
			17066, --Item drops 4/17
			18051,
			18052,
			18053,
			18054,
			18055,
			18056,
			18057,
			18058,
			18059,
			18060,
			18062,
			18063,
			18064,
			18065,
			18066, --Item drops 4/17
			19051,
			19052,
			19053,
			19054,
			19055,
			19056,
			19057,
			19058,
			19059,
			19060,
			19062,
			19063,
			19064,
			19065,
			19066
		} --Item drops 4/17

		if player.quest["caravan"] >= 2 then
			table.insert(sellitems, 294)
		end
		if player.quest["caravan"] >= 2 then
			table.insert(sellitems, 295)
		end

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

--ARMOR SHOP----------------------------------------------------------------------------------------------------------
armor_smith = {
	buy = function(player)
		local offense, defense
		local buyOptsOne = {"Fighter", "Priest"}

		menuOptionBuy = player:menuString("What kind of armor are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			offense = "Chainmail"
			defense = "Platemail"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands", "Boots"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						16101,
						16103,
						16105,
						16107,
						16109,
						16111,
						16113,
						16115,
						16117,
						16119,
						16121,
						16123,
						16125,
						16127,
						16129,
						16131,
						16133,
						16135
					}
				)
			elseif menuOptionTwo == defense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						16102,
						16104,
						16106,
						16108,
						16110,
						16112,
						16114,
						16116,
						16118,
						16120,
						16122,
						16124,
						16126,
						16128,
						16130,
						16132,
						16134,
						16136
					}
				)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", {16301, 16302, 16303, 16304, 16305, 16306, 16307, 16308, 16309})
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", {16201, 16202, 16203, 16204, 16205, 16206, 16207, 16208, 16209})
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", {16401, 16402, 16403, 16404, 16405, 16406, 16407, 16408, 16409})
			elseif menuOptionTwo == "Boots" then
				player:buyExtend("What do you wish to buy?", {16701, 16702, 16703, 16704, 16705, 16706, 16707, 16708, 16709})
			end
		elseif menuOptionBuy == "Priest" then
			offense = "Hauberk"
			defense = "Hide"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands", "Boots"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						19101,
						19103,
						19105,
						19107,
						19109,
						19111,
						19113,
						19115,
						19117,
						19119,
						19121,
						19123,
						19125,
						19127,
						19129,
						19131,
						19133,
						19135
					}
				)
			elseif menuOptionTwo == defense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						19102,
						19104,
						19106,
						19108,
						19110,
						19112,
						19114,
						19116,
						19118,
						19120,
						19122,
						19124,
						19126,
						19128,
						19130,
						19132,
						19134,
						19136
					}
				)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", {19301, 19302, 19303, 19304, 19305, 19306, 19307, 19308, 19309})
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", {19201, 19202, 19203, 19204, 19205, 19206, 19207, 19208, 19209})
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", {19401, 19402, 19403, 19404, 19405, 19406, 19407, 19408, 19409})
			elseif menuOptionTwo == "Boots" then
				player:buyExtend("What do you wish to buy?", {19701, 19702, 19703, 19704, 19705, 19706, 19707, 19708, 19709})
			end
		end
	end,
	sell = function(player)
		local sellitems = {
			16101,
			16103,
			16105,
			16107,
			16109,
			16111,
			16113,
			16115,
			16117,
			16119,
			16121,
			16123,
			16125,
			16127,
			16129,
			16131,
			16133,
			16135,
			16102,
			16104,
			16106,
			16108,
			16110,
			16112,
			16114,
			16116,
			16118,
			16120,
			16122,
			16124,
			16126,
			16128,
			16130,
			16132,
			16134,
			16136,
			16301,
			16302,
			16303,
			16304,
			16305,
			16306,
			16307,
			16308,
			16309,
			16201,
			16202,
			16203,
			16204,
			16205,
			16206,
			16207,
			16208,
			16209,
			16401,
			16402,
			16403,
			16404,
			16405,
			16406,
			16407,
			16408,
			16409,
			16701,
			16702,
			16703,
			16704,
			16705,
			16706,
			16707,
			16708,
			16709,
			19101,
			19103,
			19105,
			19107,
			19109,
			19111,
			19113,
			19115,
			19117,
			19119,
			19121,
			19123,
			19125,
			19127,
			19129,
			19131,
			19133,
			19135,
			19102,
			19104,
			19106,
			19108,
			19110,
			19112,
			19114,
			19116,
			19118,
			19120,
			19122,
			19124,
			19126,
			19128,
			19130,
			19132,
			19134,
			19136,
			19301,
			19302,
			19303,
			19304,
			19305,
			19306,
			19307,
			19308,
			19309,
			19201,
			19202,
			19203,
			19204,
			19205,
			19206,
			19207,
			19208,
			19209,
			19401,
			19402,
			19403,
			19404,
			19405,
			19406,
			19407,
			19408,
			19409,
			19701,
			19702,
			19703,
			19704,
			19705,
			19706,
			19707,
			19708,
			19709,
			291,
			292,
			293,
			15005,
			16601,
			16602,
			16603,
			16604,
			16605,
			16606,
			16607,
			16608,
			16609,
			16610,
			16611,
			16612,
			16613,
			16614,
			16615,
			16616, --Item drops 4/17
			16617,
			16618,
			16619,
			16620,
			16621,
			16622,
			16623,
			16624,
			16625,
			16626,
			16627,
			16628,
			16629,
			16630,
			16631,
			16632,
			16633,
			16634,
			16635,
			16636,
			16251,
			16252,
			16253,
			16254,
			16255,
			16256,
			16257,
			16258,
			16259,
			16260,
			16261,
			16262,
			16263,
			16264,
			16265,
			16351,
			16352,
			16353,
			16354,
			16355,
			16356,
			16357,
			16358,
			16359,
			16360,
			16361,
			16362,
			16363,
			16364,
			16365,
			16451,
			16452,
			16453,
			16454,
			16455,
			16456,
			16457,
			16458,
			16459,
			16460,
			16461,
			16462,
			16463,
			16464,
			16465,
			16751,
			16752,
			16753,
			16754,
			16755,
			16756,
			16757,
			16758,
			16759,
			16760,
			16761,
			16762,
			16763,
			16764,
			16765,
			19601,
			19602,
			19603,
			19604,
			19605,
			19606,
			19607,
			19608,
			19609,
			19610,
			19611,
			19612,
			19613,
			19614,
			19615,
			19616,
			19617,
			19618,
			19619,
			19620,
			19621,
			19622,
			19623,
			19624,
			19625,
			19626,
			19627,
			19628,
			19629,
			19630,
			19631,
			19632,
			19633,
			19634,
			19635,
			19636,
			19251,
			19252,
			19253,
			19254,
			19255,
			19256,
			19257,
			19258,
			19259,
			19260,
			19261,
			19262,
			19263,
			19264,
			19265,
			19351,
			19352,
			19353,
			19354,
			19355,
			19356,
			19357,
			19358,
			19359,
			19360,
			19361,
			19362,
			19363,
			19364,
			19365,
			19451,
			19452,
			19453,
			19454,
			19455,
			19456,
			19457,
			19458,
			19459,
			19460,
			19461,
			19462,
			19463,
			19464,
			19465,
			19751,
			19752,
			19753,
			19754,
			19755,
			19756,
			19757,
			19758,
			19759,
			19760,
			19761,
			19762,
			19763,
			19764,
			19765
		}
		 --Item drops 4/17

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

--FINERY SHOP----------------------------------------------------------------------------------------------------------
finery_shop = {
	buy = function(player)
		local offense, defense
		local buyOptsOne = {"Scoundrel", "Wizard"}

		menuOptionBuy = player:menuString("What kind of armor are you looking for?", buyOptsOne)
		if menuOptionBuy == "Scoundrel" then
			offense = "Tunic"
			defense = "Leathers"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands", "Boots"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						17101,
						17103,
						17105,
						17107,
						17109,
						17111,
						17113,
						17115,
						17117,
						17119,
						17121,
						17123,
						17125,
						17127,
						17129,
						17131,
						17133,
						17135
					}
				)
			elseif menuOptionTwo == defense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						17102,
						17104,
						17106,
						17108,
						17110,
						17112,
						17114,
						17116,
						17118,
						17120,
						17122,
						17124,
						17126,
						17128,
						17130,
						17132,
						17134,
						17136
					}
				)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", {17301, 17302, 17303, 17304, 17305, 17306, 17307, 17308, 17309})
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", {17201, 17202, 17203, 17204, 17205, 17206, 17207, 17208, 17209})
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", {17401, 17402, 17403, 17404, 17405, 17406, 17407, 17408, 17409})
			elseif menuOptionTwo == "Boots" then
				player:buyExtend("What do you wish to buy?", {17701, 17702, 17703, 17704, 17705, 17706, 17707, 17708, 17709})
			end
		elseif menuOptionBuy == "Wizard" then
			offense = "Shroud"
			defense = "Robe"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands", "Boots"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						18101,
						18103,
						18105,
						18107,
						18109,
						18111,
						18113,
						18115,
						18117,
						18119,
						18121,
						18123,
						18125,
						18127,
						18129,
						18131,
						18133,
						18135
					}
				)
			elseif menuOptionTwo == defense then
				player:buyExtend(
					"What do you wish to buy?",
					{
						18102,
						18104,
						18106,
						18108,
						18110,
						18112,
						18114,
						18116,
						18118,
						18120,
						18122,
						18124,
						18126,
						18128,
						18130,
						18132,
						18134,
						18136
					}
				)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", {18301, 18302, 18303, 18304, 18305, 18306, 18307, 18308, 18309})
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", {18201, 18202, 18203, 18204, 18205, 18206, 18207, 18208, 18209})
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", {18401, 18402, 18403, 18404, 18405, 18406, 18407, 18408, 18409})
			elseif menuOptionTwo == "Boots" then
				player:buyExtend("What do you wish to buy?", {18701, 18702, 18703, 18704, 18705, 18706, 18707, 18708, 18709})
			end
		end
	end,
	sell = function(player)
		local sellitems = {
			17101,
			17103,
			17105,
			17107,
			17109,
			17111,
			17113,
			17115,
			17117,
			17119,
			17121,
			17123,
			17125,
			17127,
			17129,
			17131,
			17133,
			17135,
			17102,
			17104,
			17106,
			17108,
			17110,
			17112,
			17114,
			17116,
			17118,
			17120,
			17122,
			17124,
			17126,
			17128,
			17130,
			17132,
			17134,
			17136,
			17301,
			17302,
			17303,
			17304,
			17305,
			17306,
			17307,
			17308,
			17309,
			17201,
			17202,
			17203,
			17204,
			17205,
			17206,
			17207,
			17208,
			17209,
			17401,
			17402,
			17403,
			17404,
			17405,
			17406,
			17407,
			17408,
			17409,
			17701,
			17702,
			17703,
			17704,
			17705,
			17706,
			17707,
			17708,
			17709,
			18101,
			18103,
			18105,
			18107,
			18109,
			18111,
			18113,
			18115,
			18117,
			18119,
			18121,
			18123,
			18125,
			18127,
			18129,
			18131,
			18133,
			18135,
			18102,
			18104,
			18106,
			18108,
			18110,
			18112,
			18114,
			18116,
			18118,
			18120,
			18122,
			18124,
			18126,
			18128,
			18130,
			18132,
			18134,
			18136,
			18301,
			18302,
			18303,
			18304,
			18305,
			18306,
			18307,
			18308,
			18309,
			18201,
			18202,
			18203,
			18204,
			18205,
			18206,
			18207,
			18208,
			18209,
			18401,
			18402,
			18403,
			18404,
			18405,
			18406,
			18407,
			18408,
			18409,
			18701,
			18702,
			18703,
			18704,
			18705,
			18706,
			18707,
			18708,
			18709,
			17601,
			17602,
			17603,
			17604,
			17605,
			17606,
			17607,
			17608,
			17609,
			17610,
			17611,
			17612,
			17613,
			17614,
			17615,
			17616, --Item drops 4/17
			17617,
			17618,
			17619,
			17620,
			17621,
			17622,
			17623,
			17624,
			17625,
			17626,
			17627,
			17628,
			17629,
			17630,
			17631,
			17632,
			17633,
			17634,
			17635,
			17636,
			17251,
			17252,
			17253,
			17254,
			17255,
			17256,
			17257,
			17258,
			17259,
			17260,
			17261,
			17262,
			17263,
			17264,
			17265,
			17351,
			17352,
			17353,
			17354,
			17355,
			17356,
			17357,
			17358,
			17359,
			17360,
			17361,
			17362,
			17363,
			17364,
			17365,
			17451,
			17452,
			17453,
			17454,
			17455,
			17456,
			17457,
			17458,
			17459,
			17460,
			17461,
			17462,
			17463,
			17464,
			17465,
			17751,
			17752,
			17753,
			17754,
			17755,
			17756,
			17757,
			17758,
			17759,
			17760,
			17761,
			17762,
			17763,
			17764,
			17765,
			18601,
			18602,
			18603,
			18604,
			18605,
			18606,
			18607,
			18608,
			18609,
			18610,
			18611,
			18612,
			18613,
			18614,
			18615,
			18616,
			18617,
			18618,
			18619,
			18620,
			18621,
			18622,
			18623,
			18624,
			18625,
			18626,
			18627,
			18628,
			18629,
			18630,
			18631,
			18632,
			18633,
			18634,
			18635,
			18636,
			18251,
			18252,
			18253,
			18254,
			18255,
			18256,
			18257,
			18258,
			18259,
			18260,
			18261,
			18262,
			18263,
			18264,
			18265,
			18351,
			18352,
			18353,
			18354,
			18355,
			18356,
			18357,
			18358,
			18359,
			18360,
			18361,
			18362,
			18363,
			18364,
			18365,
			18451,
			18452,
			18453,
			18454,
			18455,
			18456,
			18457,
			18458,
			18459,
			18460,
			18461,
			18462,
			18463,
			18464,
			18465,
			18751,
			18752,
			18753,
			18754,
			18755,
			18756,
			18757,
			18758,
			18759,
			18760,
			18761,
			18762,
			18763,
			18764,
			18765
		} --Item drops 4/17

		if player.quest["spidersilk"] >= 2 then
			table.insert(sellitems, 297)
		end

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

----CHEF SHOP------------------------------------------------------------------------------------------------------------------------------------
chef_shop = {
	buy = function(player)
		local shopInventory = {
			"little_blue_fish",
			"little_orange_fish",
			"dead_rat",
			"dead_squirrel",
			"dead_rabbit",
			"dead_snake",
			"chicken_meat",
			"snake_meat"
		}

		player:buyExtend("What do you wish to buy?", shopInventory)
	end,
	sell = function(player)
		local shopWillBuy = {
			212,
			213,
			246,
			247,
			248,
			249,
			250,
			53,
			3010,
			6030,
			6031,
			6032,
			6033,
			6034, --honey, empty bowl, lima beans, loaf of bread, egg, browned beef
			8001,
			8002,
			8003,
			8051,
			8052,
			8053,
			8054, -- dead wide eyed bunny, dead downer bunny, dead chaotic hare, bear heart, bear liver, bear brain
			8071,
			8072,
			8073,
			8074
		} -- dead piglet, dead big pig, dead fat pig, ox meat

		if player.m == 2004 then
			if player.quest["chef"] >= 2 then
				table.insert(shopWillBuy, 392)
			end --lobster claw
			if player.quest["chef"] >= 2 then
				table.insert(shopWillBuy, 393)
			end --jellyfish tentacle
			if player.quest["chef"] >= 4 then
				table.insert(shopWillBuy, 406)
			end --frog leg
		end
		player:sellExtend("What do you wish to sell?", shopWillBuy)
	end
}

--CATHAY ARMOR SHOP----------------------------------------------------------------------------------------------------------
cathay_armor_shop = {
	buy = function(player)
		local offense, defense
		local buyOptsOne = {"Fighter", "Priest"}

		local fighterChainmail = {16137, 16139, 16141, 16143, 16145, 16147, 16149, 16151, 16153, 16155}
		local fighterPlatemail = {16138, 16140, 16142, 16144, 16146, 16148, 16150, 16152, 16154, 16156}
		local fighterHelmets = {16311, 16312, 16313, 16314, 16315}
		local fighterShields = {16210, 16221, 16222, 16223, 16224}
		local fighterHands = {16411, 16412, 16413, 16414, 16415}

		local priestHauberk = {19137, 19139, 19141, 19143, 19145, 19147, 19149, 19151, 19153, 19155}
		local priestHide = {19138, 19140, 19142, 19144, 19146, 19148, 19150, 19152, 19154, 19156}
		local priestHelmets = {19311, 19312, 19313, 19314, 19315}
		local priestShields = {19210, 19221, 19222, 19223, 19224}
		local priestHands = {19411, 19412, 19413, 19414, 19415}

		menuOptionBuy = player:menuString("What kind of armor are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			offense = "Chainmail"
			defense = "Platemail"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend("What do you wish to buy?", fighterChainmail)
			elseif menuOptionTwo == defense then
				player:buyExtend("What do you wish to buy?", fighterPlatemail)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", fighterHelmets)
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", fighterShields)
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", fighterHands)
			end
		elseif menuOptionBuy == "Priest" then
			offense = "Hauberk"
			defense = "Hide"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend("What do you wish to buy?", priestHauberk)
			elseif menuOptionTwo == defense then
				player:buyExtend("What do you wish to buy?", priestHide)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", priestHelmets)
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", priestShields)
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", priestHands)
			end
		end
	end,
	sell = function(player)
		local sellitems = {
			16101,
			16103,
			16105,
			16107,
			16109,
			16111,
			16113,
			16115,
			16117,
			16119,
			16121,
			16123,
			16125,
			16127,
			16129,
			16131,
			16133,
			16135,
			16102,
			16104,
			16106,
			16108,
			16110,
			16112,
			16114,
			16116,
			16118,
			16120,
			16122,
			16124,
			16126,
			16128,
			16130,
			16132,
			16134,
			16136,
			16301,
			16302,
			16303,
			16304,
			16305,
			16306,
			16307,
			16308,
			16309,
			16201,
			16202,
			16203,
			16204,
			16205,
			16206,
			16207,
			16208,
			16209,
			16401,
			16402,
			16403,
			16404,
			16405,
			16406,
			16407,
			16408,
			16409,
			16701,
			16702,
			16703,
			16704,
			16705,
			16706,
			16707,
			16708,
			16709,
			19101,
			19103,
			19105,
			19107,
			19109,
			19111,
			19113,
			19115,
			19117,
			19119,
			19121,
			19123,
			19125,
			19127,
			19129,
			19131,
			19133,
			19135,
			19102,
			19104,
			19106,
			19108,
			19110,
			19112,
			19114,
			19116,
			19118,
			19120,
			19122,
			19124,
			19126,
			19128,
			19130,
			19132,
			19134,
			19136,
			19301,
			19302,
			19303,
			19304,
			19305,
			19306,
			19307,
			19308,
			19309,
			19201,
			19202,
			19203,
			19204,
			19205,
			19206,
			19207,
			19208,
			19209,
			19401,
			19402,
			19403,
			19404,
			19405,
			19406,
			19407,
			19408,
			19409,
			19701,
			19702,
			19703,
			19704,
			19705,
			19706,
			19707,
			19708,
			19709,
			291,
			292,
			293,
			15005,
			16137,
			16139,
			16141,
			16143,
			16145,
			16147,
			16149,
			16151,
			16153,
			16155,
			16138,
			16140,
			16142,
			16144,
			16146,
			16148,
			16150,
			16152,
			16154,
			16156,
			16311,
			16312,
			16313,
			16314,
			16315,
			16210,
			16221,
			16222,
			16223,
			16224,
			16411,
			16412,
			16413,
			16414,
			16415,
			19137,
			19139,
			19141,
			19143,
			19145,
			19147,
			19149,
			19151,
			19153,
			19155,
			19138,
			19140,
			19142,
			19144,
			19146,
			19148,
			19150,
			19152,
			19154,
			19156,
			19311,
			19312,
			19313,
			19314,
			19315,
			19210,
			19221,
			19222,
			19223,
			19224,
			19411,
			19412,
			19413,
			19414,
			19415
		}

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

--CATHAY WEAPON SHOP----------------------------------------------------------------------------------------------------------
cathay_weapon_shop = {
	buy = function(player)
		local buyOptsOne = {"Fighter", "Scoundrel", "Wizard", "Priest"}

		local fighterWeapons = {16012, 16013, 16014, 16015, 16016}
		local scoundrelWeapons = {17012, 17013, 17014, 17015, 17016}
		local wizardWeapons = {18012, 18013, 18014, 18015, 18016}
		local priestWeapons = {19012, 19013, 19014, 19015, 19016}

		menuOptionBuy = player:menuString("What kind of weapons are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			player:buyExtend("What do you wish to buy?", fighterWeapons)
		elseif menuOptionBuy == "Scoundrel" then
			player:buyExtend("What do you wish to buy?", scoundrelWeapons)
		elseif menuOptionBuy == "Wizard" then
			player:buyExtend("What do you wish to buy?", wizardWeapons)
		elseif menuOptionBuy == "Priest" then
			player:buyExtend("What do you wish to buy?", priestWeapons)
		end
	end,
	sell = function(player)
		local sellitems = {
			16001,
			16002,
			16003,
			16004,
			16005,
			16006,
			16007,
			16008,
			16009,
			16010,
			17001,
			17002,
			17003,
			17004,
			17005,
			17006,
			17007,
			17008,
			17009,
			17010,
			18001,
			18002,
			18003,
			18004,
			18005,
			18006,
			18007,
			18008,
			18009,
			18010,
			19001,
			19002,
			19003,
			19004,
			19005,
			19006,
			19007,
			19008,
			19009,
			19010,
			16012,
			16013,
			16014,
			16015,
			16016,
			17012,
			17013,
			17014,
			17015,
			17016,
			18012,
			18013,
			18014,
			18015,
			18016,
			19012,
			19013,
			19014,
			19015,
			19016
		}

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

--CATHAY FINERY SHOP----------------------------------------------------------------------------------------------------------
cathay_finery_shop = {
	buy = function(player)
		local offense, defense
		local buyOptsOne = {"Scoundrel", "Wizard"}

		local scoundrelTunics = {17137, 17139, 17141, 17143, 17145, 17147, 17149, 17151, 17153, 17155}
		local scoundrelLeathers = {17138, 17140, 17142, 17144, 17146, 17148, 17150, 17152, 17154, 17156}
		local scoundrelHelmets = {17311, 17312, 17313, 17314, 17315}
		local scoundrelShields = {17210, 17221, 17222, 17223, 17224}
		local scoundrelHands = {17411, 17412, 17413, 17414, 17415}

		local wizardShrouds = {18138, 18140, 18142, 18144, 18146, 18148, 18150, 18152, 18154, 18156}
		local wizardRobes = {18137, 18139, 18141, 18143, 18145, 18147, 18149, 18151, 18153, 18155}
		local wizardHelmets = {18311, 18312, 18313, 18314, 18315}
		local wizardShields = {18210, 18221, 18222, 18223, 18224}
		local wizardHands = {18411, 18412, 18413, 18414, 18415}

		menuOptionBuy = player:menuString("What kind of armor are you looking for?", buyOptsOne)
		if menuOptionBuy == "Scoundrel" then
			offense = "Tunic"
			defense = "Leathers"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend("What do you wish to buy?", scoundrelTunics)
			elseif menuOptionTwo == defense then
				player:buyExtend("What do you wish to buy?", scoundrelLeathers)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", scoundrelHelmets)
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", scoundrelShields)
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", scoundrelHands)
			end
		elseif menuOptionBuy == "Wizard" then
			offense = "Shroud"
			defense = "Robe"
			buyOptsTwo = {offense, defense, "Helmets", "Shields", "Hands"}
			menuOptionTwo = player:menuString("Which type?", buyOptsTwo)
			if menuOptionTwo == offense then
				player:buyExtend("What do you wish to buy?", wizardShrouds)
			elseif menuOptionTwo == defense then
				player:buyExtend("What do you wish to buy?", wizardRobes)
			elseif menuOptionTwo == "Helmets" then
				player:buyExtend("What do you wish to buy?", wizardHelmets)
			elseif menuOptionTwo == "Shields" then
				player:buyExtend("What do you wish to buy?", wizardShields)
			elseif menuOptionTwo == "Hands" then
				player:buyExtend("What do you wish to buy?", wizardHands)
			end
		end
	end,
	sell = function(player)
		local sellitems = {
			17101,
			17103,
			17105,
			17107,
			17109,
			17111,
			17113,
			17115,
			17117,
			17119,
			17121,
			17123,
			17125,
			17127,
			17129,
			17131,
			17133,
			17135,
			17102,
			17104,
			17106,
			17108,
			17110,
			17112,
			17114,
			17116,
			17118,
			17120,
			17122,
			17124,
			17126,
			17128,
			17130,
			17132,
			17134,
			17136,
			17301,
			17302,
			17303,
			17304,
			17305,
			17306,
			17307,
			17308,
			17309,
			17201,
			17202,
			17203,
			17204,
			17205,
			17206,
			17207,
			17208,
			17209,
			17401,
			17402,
			17403,
			17404,
			17405,
			17406,
			17407,
			17408,
			17409,
			17701,
			17702,
			17703,
			17704,
			17705,
			17706,
			17707,
			17708,
			17709,
			18101,
			18103,
			18105,
			18107,
			18109,
			18111,
			18113,
			18115,
			18117,
			18119,
			18121,
			18123,
			18125,
			18127,
			18129,
			18131,
			18133,
			18135,
			18102,
			18104,
			18106,
			18108,
			18110,
			18112,
			18114,
			18116,
			18118,
			18120,
			18122,
			18124,
			18126,
			18128,
			18130,
			18132,
			18134,
			18136,
			18301,
			18302,
			18303,
			18304,
			18305,
			18306,
			18307,
			18308,
			18309,
			18201,
			18202,
			18203,
			18204,
			18205,
			18206,
			18207,
			18208,
			18209,
			18401,
			18402,
			18403,
			18404,
			18405,
			18406,
			18407,
			18408,
			18409,
			18701,
			18702,
			18703,
			18704,
			18705,
			18706,
			18707,
			18708,
			18709,
			17137,
			17139,
			17141,
			17143,
			17145,
			17147,
			17149,
			17151,
			17153,
			17155,
			17138,
			17140,
			17142,
			17144,
			17146,
			17148,
			17150,
			17152,
			17154,
			17156,
			17311,
			17312,
			17313,
			17314,
			17315,
			17210,
			17221,
			17222,
			17223,
			17224,
			17411,
			17412,
			17413,
			17414,
			17415,
			18138,
			18140,
			18142,
			18144,
			18146,
			18148,
			18150,
			18152,
			18154,
			18156,
			18137,
			18139,
			18141,
			18143,
			18145,
			18147,
			18149,
			18151,
			18153,
			18155,
			18311,
			18312,
			18313,
			18314,
			18315,
			18210,
			18221,
			18222,
			18223,
			18224,
			18411,
			18412,
			18413,
			18414,
			18415
		}

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

cathay_shoe_shop = {
	buy = function(player)
		local offense, defense
		local buyOptsOne = {"Fighter", "Scoundrel", "Wizard", "Priest"}

		local fighterBoots = {
			16701,
			16702,
			16703,
			16704,
			16705,
			16706,
			16707,
			16708,
			16709,
			16711,
			16712,
			16713,
			16714,
			16715
		}
		local scoundrelBoots = {
			17701,
			17702,
			17703,
			17704,
			17705,
			17706,
			17707,
			17708,
			17709,
			17711,
			17712,
			17713,
			17714,
			17715
		}
		local wizardBoots = {18701, 18702, 18703, 18704, 18705, 18706, 18707, 18708, 18709, 18711, 18712, 18713, 18714, 18715}
		local priestBoots = {19701, 19702, 19703, 19704, 19705, 19706, 19707, 19708, 19709, 19711, 19712, 19713, 19714, 19715}

		menuOptionBuy = player:menuString("What kind of Boots are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			player:buyExtend("What do you wish to buy?", fighterBoots)
		elseif menuOptionBuy == "Scoundrel" then
			player:buyExtend("What do you wish to buy?", scoundrelBoots)
		elseif menuOptionBuy == "Wizard" then
			player:buyExtend("What do you wish to buy?", wizardBoots)
		elseif menuOptionBuy == "Priest" then
			player:buyExtend("What do you wish to buy?", priestBoots)
		end
	end,
	sell = function(player)
		local shopWillBuy = {
			16701,
			16702,
			16703,
			16704,
			16705,
			16706,
			16707,
			16708,
			16709,
			16710,
			16711,
			16712,
			16713,
			16714,
			16715,
			16716,
			16717,
			16718,
			16719,
			16720,
			16721,
			16722,
			16723,
			16724,
			16725,
			16726,
			16727,
			16728,
			17701,
			17702,
			17703,
			17704,
			17705,
			17706,
			17707,
			17708,
			17709,
			17710,
			17711,
			17712,
			17713,
			17714,
			17715,
			17716,
			17717,
			17718,
			17719,
			17720,
			17721,
			17722,
			17723,
			17724,
			17725,
			17726,
			17727,
			17728,
			18701,
			18702,
			18703,
			18704,
			18705,
			18706,
			18707,
			18708,
			18709,
			18710,
			18711,
			18712,
			18713,
			18714,
			18715,
			18716,
			18717,
			18718,
			18719,
			18720,
			18721,
			18722,
			18723,
			18724,
			18725,
			18726,
			18727,
			18728,
			19701,
			19702,
			19703,
			19704,
			19705,
			19706,
			19707,
			19708,
			19709,
			19710,
			19711,
			19712,
			19713,
			19714,
			19715,
			19716,
			19717,
			19718,
			19719,
			19720,
			19721,
			19722,
			19723,
			19724,
			19725,
			19726,
			19727,
			19728
		}

		player:sellExtend("What do you wish to sell?", shopWillBuy)
	end
}

--SPEC SHOP----------------------------------------------------------------------------------------------------------
specialized_shop = {
	buy = function(player)
		local menuOptionBuy
		local menuOptionSpec
		local buyOptsOne = {"Fighter", "Scoundrel", "Wizard", "Priest"}
		local buyOptsFighter = {"Paladin", "Samurai", "DarkKnight"}
		local buyOptsScoundrel = {"Bard", "Mercenary", "Assassin"}
		local buyOptsWizard = {"Archmage", "Elemental", "Bloodmage"}
		local buyOptsPriest = {"Crusader", "Bishop", "Fallen"}

		menuOptionBuy = player:menuString("What kind of Gear are you looking for?", buyOptsOne)
		if menuOptionBuy == "Fighter" then
			menuOptionSpec = player:menuString("What path do you need it for?", buyOptsFighter)

			if menuOptionSpec == "Paladin" then
				player:buyExtend("What do you wish to buy?", {2001, 2002, 2003, 2004, 2005})
			elseif menuOptionSpec == "Samurai" then
				player:buyExtend("What do you wish to buy?", {2011, 2012, 2013, 2014, 2015})
			elseif menuOptionSpec == "DarkKnight" then
				player:buyExtend("What do you wish to buy?", {2021, 2022, 2023, 2024, 2025})
			end
		elseif menuOptionBuy == "Scoundrel" then
			menuOptionSpec = player:menuString("What path do you need it for?", buyOptsScoundrel)

			if menuOptionSpec == "Bard" then
				player:buyExtend("What do you wish to buy?", {2031, 2032, 2033, 2034, 2035})
			elseif menuOptionSpec == "Mercenary" then
				player:buyExtend("What do you wish to buy?", {2041, 2042, 2043, 2044, 2045})
			elseif menuOptionSpec == "Assassin" then
				player:buyExtend("What do you wish to buy?", {2051, 2052, 2053, 2054, 2055})
			end
		elseif menuOptionBuy == "Wizard" then
			menuOptionSpec = player:menuString("What path do you need it for?", buyOptsWizard)

			if menuOptionSpec == "Archmage" then
				player:buyExtend("What do you wish to buy?", {2061, 2062, 2063, 2064, 2065})
			elseif menuOptionSpec == "Elemental" then
				player:buyExtend("What do you wish to buy?", {2071, 2072, 2073, 2074, 2075})
			elseif menuOptionSpec == "Bloodmage" then
				player:buyExtend("What do you wish to buy?", {2081, 2082, 2083, 2084, 2085})
			end
		elseif menuOptionBuy == "Priest" then
			menuOptionSpec = player:menuString("What path do you need it for?", buyOptsPriest)

			if menuOptionSpec == "Crusader" then
				player:buyExtend("What do you wish to buy?", {2091, 2092, 2093, 2094, 2095})
			elseif menuOptionSpec == "Bishop" then
				player:buyExtend("What do you wish to buy?", {2101, 2102, 2103, 2104, 2105})
			elseif menuOptionSpec == "Fallen" then
				player:buyExtend("What do you wish to buy?", {2111, 2112, 2113, 2114, 2115})
			end
		end
	end,
	sell = function(player)
		local sellitems = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2011,
			2012,
			2013,
			2014,
			2015,
			2021,
			2022,
			2023,
			2024,
			2025,
			2031,
			2032,
			2003,
			2034,
			2035,
			2041,
			2042,
			2043,
			2044,
			2045,
			2051,
			2052,
			2053,
			2054,
			2055,
			2061,
			2062,
			2063,
			2064,
			2065,
			2071,
			2072,
			2073,
			2074,
			2075,
			2081,
			2082,
			2083,
			2084,
			2085,
			2091,
			2092,
			2093,
			2094,
			2095,
			2101,
			2102,
			2103,
			2104,
			2105,
			2111,
			2112,
			2113,
			2114,
			2115
		} --Item drops 8/28/2017 John Day

		player:sellExtend("What do you wish to sell?", sellitems)
	end
}

--[[
template_shop = {

buy = function(player)

	local shopInventory = {}

	player:buyExtend("What do you wish to buy?", shopInventory)
	
end,

sell = function(player)

	local shopWillBuy = {}
	
	player:sellExtend("What do you wish to sell?", shopWillBuy)
end
}
]] --
