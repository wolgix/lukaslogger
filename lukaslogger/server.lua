-- Made by Tazio
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local DISCORD_WEBHOOK = "https://ptb.discordapp.com/api/webhooks/732251281799774298/m8qddKyrAskvCq0KrDLb5BmRayt5fqlVyT7k0oAQsy9s2-kNfQ42fa7faIeLZg9Tg3tI"
--local DISCORD_WEBHOOK_Tunerdiscord = "https://discord.com/api/webhooks/725015822958854175/hY7y9rM2rZyjZb6nazjc28MDBJTIHkz9qN5hFWrCLSmO2q4mnWxFWCmez0yDEjWWwHfd"
local DISCORD_NAME = "Five-Star"
local STEAM_KEY = "1B5F165DCCF413B015CC304E473309CF"
local DISCORD_IMAGE = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg" -- default is FiveM logo

--DON'T EDIT BELOW THIS

--PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "Discord Webhook is **ONLINE**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

AddEventHandler('chatMessage', function(source, name, message) 

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
	--print(tonumber(GetIDFromSource('steam', source), 16)) -- DEBUGGING
	--print('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16))
	if STEAM_KEY == '' or STEAM_KEY == nil then
		--PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			--print(image) -- DEBUGGING
			--PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

AddEventHandler('playerConnecting', function() 
    --PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "```CSS\n".. GetPlayerName(source) .. " connecting\n```", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
    --sendToDiscord("Server Login", "**" .. GetPlayerName(source) .. "** is connecting to the server.", 65280)
end)

AddEventHandler('playerDropped', function(reason) 
	local color = 16711680
	if string.match(reason, "Kicked") or string.match(reason, "Banned") then
		color = 16007897
	end
  --sendToDiscord("Server Logout", "**" .. GetPlayerName(source) .. "** has left the server. \n Reason: " .. reason, color)
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(message)
    --sendToDiscord("Death log", message, 16711680)
end)
	
RegisterNetEvent('tunerlogger')
AddEventHandler('tunerlogger',function(amount)
	

playerx = source

if playerx and amount ~= nil then

    sendToDiscord("Rechnungs-Loger", 'Spieler '..GetPlayerName(playerx)..' hat eine rechnung mit der Summe '..amount..' ausgestellt', 16711680)
end
end)
RegisterNetEvent('tunerloggertuning')
AddEventHandler('tunerloggertuning',function(price, kenzeichen)
	

playerx = source
local rawtext
if playerx and price and kenzeichen ~= nil then

	MySQL.Async.fetchScalar('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = kenzeichen
	}, function (result)
	local xPlayer = ESX.GetPlayerFromIdentifier(result)
	MySQL.Async.fetchScalar('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = kenzeichen
	}, function (result)
	
	local gta5liczence = 'license:'..result
	print(gta5liczence)
	--test
	MySQL.Async.fetchScalar('SELECT name FROM user_identifiers WHERE license = @license', {
		['@license'] = gta5liczence
	}, function (steamname)
	
	
 sendToDiscord(" Tuning-Logger", ' '..GetPlayerName(playerx)..' hat für '..steamname..' getuned!\n Kenzeichen: '..kenzeichen..'\n Preis: '..price..'$', 16711680)
end)

	end)
	
	end)

end
end)

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "Lukas logger",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end
