local topKillData = {}

RegisterNetEvent('butun_ruslarin_bacisini_gotunden_sikeyim')
AddEventHandler('butun_ruslarin_bacisini_gotunden_sikeyim', function(data)
    topKillData = data
end)

local DrawText3D = function(x, y, z, alpha, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        local factor = (string.len(text)) / 400
        DrawRect(_x, _y + 0.025, 0 + factor, 0.05, 0, 0, 0, 180)
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0)
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local spawnCoordinates = {
    {x = -116.38032836914, y = -431.18021240234, z = 36.311952972412}, -- 1.yi buraya yaz
    {x = -115.31078796387, y = -431.59547119141, z = 35.911895751953}, -- 2. bura
    {x = -117.38124389648, y = -430.77030029297, z = 35.5069480896} -- 3bura
}
local maxDisplayDistance = 8.0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for i, playerInfo in ipairs(topKillData) do
            local spawnCoord = spawnCoordinates[i]
            if spawnCoord then
                local distance = GetDistanceBetweenCoords(playerCoords, spawnCoord.x, spawnCoord.y, spawnCoord.z, true)
                if distance <= maxDisplayDistance then
                    local text = string.format(
                        "%s\nKills: %d",
                        playerInfo.firstname,
                        playerInfo.kill
                    )
                    local alpha = math.floor(255 * (1.0 - distance / maxDisplayDistance))
                    DrawText3D(spawnCoord.x, spawnCoord.y, spawnCoord.z, alpha, 0.4, text)
                end
            end
        end
    end
end)
