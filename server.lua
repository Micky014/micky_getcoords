------------------------
--====== Config ======--
------------------------

-- Discord Webhook URL for send coords
local DiscordWebhook = ''

------------------------
--====== Script ======--
------------------------

RegisterCommand('getcoords', function(src, args, raw)
    if src == 0 then 
        return print('only players can use this command')
    end

    local playerName, playerEntity = GetPlayerName(src), GetPlayerPed(src)
    local playerCoords, playerHeading = GetEntityCoords(playerEntity), GetEntityHeading(playerEntity)

    if args[1] then
        ubi = table.concat(args, ' ')
        title = 'Get Coords - '..ubi
    end

    embed = {
        author = { name = playerName },
        title = title or 'Get Coords',
        description = '```'..playerCoords..'``````'..vector4(playerCoords, playerHeading)..'``````{ x = '..math.round(playerCoords.x, 3)..', y = '..math.round(playerCoords.y, 3)..', z = '..math.round(playerCoords.z, 3)..' }``````{ x = '..math.round(playerCoords.x, 3)..', y = '..math.round(playerCoords.y, 3)..', z = '..math.round(playerCoords.z, 3)..', h = '..math.round(playerHeading, 3)..' }```'
    }

    SendWebhook(embed)
end, true)

function SendWebhook(embed)
    PerformHttpRequest(DiscordWebhook, function(err, text, headers) 
        if err ~= 204 then
            print('error: ', err, text)
        end
    end, 'POST', json.encode({ embeds = { embed } }), { 
        ['Content-Type'] = 'application/json' 
    })
end

function math.round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end