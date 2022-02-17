lapis_vendor = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		lapis_vendor.shop(player, npc)
	end,
	shop = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			 --

			--[[
300041 - Cload of Shadows - Unique item for Destruction
300512 - Black Antlers - Unique item for Destruction
301020 - Black Thief Mask - Unique item for Destruction
301508 -- Lapis Full Respec for consumable.	
300510 -- Kush tiger Hat
]] --old mcoats ,300001, 300002, 300003, 300004, 300005, 300007, 300009, 300011,
			--300030, 300031, 300032, 300034, 300035, 300036, 300037, 300043
			local weapons = {
				310001,
				310002,
				310003,
				310004,
				310005,
				310006,
				310007,
				310008,
				310009,
				310010,
				310011,
				310012,
				310013,
				310014,
				310015,
				310016,
				310017,
				310018,
				310019,
				310020,
				310021,
				310022,
				310023,
				310024,
				310025,
				310026,
				310027,
				310028,
				310029,
				310030,
				310031,
				310032,
				310033,
				310034,
				310035,
				310036,
				310037,
				310038,
				310039,
				310040,
				310041,
				310042,
				310043,
				310044,
				310045,
				310046,
				310047,
				310048,
				310049,
				310050,
				310051,
				310052,
				310053,
				310054,
				310055,
				310056,
				310057,
				310058,
				310059,
				310060,
				310061,
				310062,
				310063,
				310064,
				310065,
				310066,
				310067,
				310068,
				310069,
				310071,
				310072,
				310073,
				310074,
				310075,
				310076,
				310077,
				310078,
				310079,
				310080,
				310081,
				310082,
				310083,
				310084,
				310085,
				310086,
				310087
			}

			local mcoats = {
				300161,
				300162,
				300165,
				300167,
				300169,
				300171,
				300174,
				300175,
				300177,
				300178,
				300181,
				300183,
				300185,
				300187,
				300188,
				300190,
				300192,
				300193,
				300198,
				300199,
				300202,
				300205,
				300207,
				300209,
				300212,
				300213,
				300215,
				300217,
				300219,
				300221,
				300224,
				300227,
				300228,
				300230,
				300234,
				300237,
				300239,
				300241,
				300245,
				300248,
				300249,
				300251,
				300254, --end of coats added 7-20-17
				300096,
				300097,
				300098,
				300100,
				300102,
				300104,
				300106,
				300107,
				300109,
				300113,
				300116,
				300119,
				300121,
				300123,
				300124,
				300126,
				300128,
				300130,
				300132,
				300135,
				300137,
				300139,
				300141,
				300148,
				300151,
				300153,
				300155,
				300066,
				300068,
				300072,
				300073,
				300076,
				300077,
				300080,
				300081,
				300083,
				300085,
				300087,
				300089,
				300090,
				300092,
				300093,
				300060,
				300061,
				300062,
				300063,
				300065,
				300013,
				300015,
				300017,
				300019,
				300021,
				300022,
				300027,
				300029
			}

			local fcoats = {
				300163,
				300164,
				300168,
				300170,
				300172,
				300173,
				300176,
				300179,
				300180,
				300182,
				300184,
				300186,
				300189,
				300191,
				300194,
				300195,
				300196,
				300197,
				300200,
				300201,
				300203,
				300204,
				300206,
				300208,
				300210,
				300211,
				300214,
				300216,
				300218,
				300220,
				300222,
				300223,
				300225,
				300226,
				300229,
				300231,
				300232,
				300233,
				300235,
				300236,
				300238,
				300240,
				300242,
				300243,
				300244,
				300246,
				300247,
				300250,
				300252,
				300253, --end of coats added 7-20-17
				300099,
				300101,
				300103,
				300105,
				300108,
				300110,
				300111,
				300112,
				300114,
				300115,
				300117,
				300118,
				300120,
				300122,
				300125,
				300127,
				300129,
				300131,
				300133,
				300134,
				300136,
				300138,
				300140,
				300142,
				300143,
				300144,
				300145,
				300146,
				300147,
				300149,
				300150,
				300152,
				300154,
				300156,
				300069,
				300070,
				300071,
				300074,
				300075,
				300078,
				300079,
				300082,
				300084,
				300086,
				300088,
				300091,
				300094,
				300095,
				300053,
				300054,
				300055,
				300056,
				300057,
				300058,
				300059,
				300064,
				300006,
				300008,
				300010,
				300012,
				300014,
				300016,
				300018,
				300020,
				300023,
				300028,
				300033,
				300038,
				300039,
				300040,
				300258,
				300259
			}

			local capes = {
				307001,
				307002,
				307003,
				307004,
				307005,
				307006,
				307007,
				307008,
				307009,
				307010,
				307011,
				307012,
				307013,
				307014,
				307015,
				307016,
				307017,
				307018,
				307019,
				307020,
				307021,
				307022,
				307023,
				307024,
				307025,
				307028
			}

			--old crowns 300504, 300505, 300506, 300507, 300508, 300509,
			local crowns = {
				300644, --added 7-20-17
				300542,
				300543,
				300544,
				300545,
				300546,
				300547,
				300548,
				300549,
				300550,
				300551,
				300552,
				300553,
				300554,
				300555,
				300556,
				300557,
				300558,
				300559,
				300560,
				300561,
				300562,
				300563,
				300564,
				300565,
				300566,
				300567,
				300568,
				300569,
				300570,
				300571,
				300572,
				300573,
				300574,
				300575,
				300576,
				300577,
				300578,
				300579,
				300580,
				300581,
				300582,
				300583,
				300584,
				300585,
				300586,
				300587,
				300588,
				300589,
				300590,
				300591,
				300592,
				300593,
				300594,
				300595,
				300596,
				300597,
				300598,
				300599,
				300600,
				300601,
				300602,
				300603,
				300604,
				300605,
				300606,
				300607,
				300608,
				300609,
				300610,
				300611,
				300612,
				300613,
				300614,
				300615,
				300616,
				300617,
				300618,
				300619,
				300620,
				300621,
				300622,
				300623,
				300624,
				300625,
				300626,
				300627,
				300628,
				300629,
				300630,
				300631,
				300632,
				300633,
				300634,
				300635,
				300636,
				300637,
				300638,
				300639,
				300640,
				300641,
				300642,
				300643, --end of crowns added 6-29-17
				300523,
				300524,
				300525,
				300526,
				300527,
				300528,
				300528,
				300529,
				300530,
				300531,
				300532,
				300533,
				300534,
				300535,
				300536,
				300537,
				300538,
				300539,
				300540,
				300541,
				300518,
				300519,
				300520,
				300521,
				300522,
				300502,
				300503,
				300511,
				300513,
				300514,
				300516,
				300515,
				300655,
				300656
			}

			local faceacc = {
				301019,
				301020,
				301029,
				301030,
				301031,
				301032,
				301033,
				301028,
				301021,
				301022,
				301023,
				301024,
				301025,
				301026,
				301027
			}

			local facialhair = {305701, 305702, 305703, 305704, 305705, 305706, 305707}

			local consumables = {301501, 301502, 301503, 301504, 301505, 301506, 301507}

			local skintones = {
				302001,
				302002,
				302003,
				302004,
				302005,
				302006,
				302007,
				302008,
				302009,
				302010,
				302011,
				302013,
				302015,
				302016,
				302017,
				302018
			}

			--mount series 1: 302503, 302504, 302505
			local mounts = {303102, 303107, 303112, 304104, 304107}

			local boxes = {303004, 303005, 303006}

			local options = {}

			local claimAmount = 0

			if player:checkLapis() ~= nil then
				table.insert(options, "Claim Lapis Donation")
			end

			table.insert(options, "Divine Light ((EXP Bonus))")
			table.insert(options, "Buy Weapon Skins")
			table.insert(options, "Buy Coats")
			table.insert(options, "Buy Crowns")
			table.insert(options, "Buy Capes")
			table.insert(options, "Buy Face Accessories")
			table.insert(options, "Buy Facial Hair")
			table.insert(options, "Buy Consumables")
			table.insert(options, "Buy Skin Tones")
			table.insert(options, "Buy Mounts")
			table.insert(options, "Limited-Time Offers")
			table.insert(options, "My Lapis Lazuli Balance")

			--if player.level == 99 then table.insert(items, 1010) end

			menu = player:menuString(name .. "Hi! I run the Lapis Shop. I sell things in exchange for Lapis Lazuli.", options)

			if menu == "Divine Light ((EXP Bonus))" then
				if player.registry["divine_light_explanation"] == 0 then
					player:dialogSeq(
						{
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\n\nYou can use your Lapis to create a global experience increase throughout the entire game. Let me explain how",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\n\nEvery 100 Lapis Lazuli will add 12 minutes to the Divine Light timer. So, 500 Lapis will add 1 hour of Divine Light.",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\nEvery day at 12:00 noon, Eastern Time, the daily donation total is tallied and reset. This does not end any Light that is left at midnight.",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\nLapis added to Divine Light can increase the multiplier in 3 tiers. 1.5, 1.75, and 2.0. These bonuses are obtained at 100 Lapis, 5000 Lapis, and 10000 Lapis respectively.",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\nSo in one day if the donations reaches the max 2.0 multiplier it will provide a total of 20 hours of benefit.",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\nThe multiplier will not decrease until the timer reaches 0. So you can continue to extend the multiplier for as long as you would like.",
							"<b>[BUYING DIVINE LIGHT MANUAL]\n\nIf you have more questions ask Peter."
						},
						1
					)
					player.registry["divine_light_explanation"] = 1
				end

				player:buyDivineLightWithLapis()
				return
			elseif menu == "Buy Weapon Skins" then
				player:buyLapis("What would you like to buy?", weapons)
			elseif menu == "Buy Coats" then
				gender = player:menuString(name .. "What kind of coats are you interested in?", {"Male", "Female"})
				if gender == "Male" then
					player:buyLapis("What would you like to buy?", mcoats)
				elseif gender == "Female" then
					player:buyLapis("What would you like to buy?", fcoats)
				end
			elseif menu == "Buy Crowns" then
				player:buyLapis("What would you like to buy?", crowns)
			elseif menu == "Buy Capes" then
				player:buyLapis("What would you like to buy?", capes)
			elseif menu == "Buy Face Accessories" then
				player:buyLapis("What would you like to buy?", faceacc)
			elseif menu == "Buy Facial Hair" then
				player:buyLapis("What would you like to buy?", facialhair)
			elseif menu == "Buy Consumables" then
				player:buyLapisNoPreview("What would you like to buy?", consumables)
			elseif menu == "Buy Skin Tones" then
				player:buyLapis("What would you like to buy?", skintones)
			elseif menu == "Buy Mounts" then
				player:buyLapis("What would you like to buy?", mounts)
			elseif menu == "Limited-Time Offers" then
				player:buyLapisNoPreview("What would you like to buy?", boxes)
			elseif menu == "My Lapis Lazuli Balance" then
				player:dialogSeq({t, name .. "You currently have: " .. player.lapis .. " Lapis Lazuli available."}, 1)
			elseif menu == "Claim Lapis Donation" then
				if player:checkLapis() ~= nil then
					claimAmount = player:checkLapis()
					claim =
						player:menuString(
						name .. "Thank you for your patronage!\nYou have " .. claimAmount .. " Lapis Lazuli to claim. Are you ready?",
						{"Yes", "No"}
					)
					if claim == "Yes" then
						player:claimLapis(claimAmount)
						player:addLapis(claimAmount)
						player.registry["total_lapis_bought"] = player.registry["total_lapis_bought"] + claimAmount
						player:sendMinitext(claimAmount .. " Lapis Lazuli added!")
						player:dialogSeq(
							{t, name .. "You've claimed " .. claimAmount .. " Lapis Lazuli! We appreciate your patronage!"},
							1
						)
					--async(lapis_vendor.click(player, npc))
					end
				end
			--	elseif menu == "" then
			--		player:dialogSeq({t, name..""}, 1)
			end
		end
	)
}
