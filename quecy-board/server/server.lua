TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("killsiralama", function(source, args, rawCommand)
    MySQL.Async.fetchAll("SELECT * FROM users ORDER BY `kill` DESC LIMIT 3", {}, function(result)
        if result and #result > 0 then
            local playerTable = {}
            for i, playerData in ipairs(result) do
                local playerSkin = json.decode(playerData.skin)
                table.insert(playerTable, {
                    firstname = playerData.firstname,
                    kill = playerData.kill,
                    model = playerSkin.model
                })
            end
            TriggerClientEvent('butun_ruslarin_bacisini_gotunden_sikeyim', -1, playerTable)
        else
            print("Veritabanında bulunamadı.")
        end
    end)
end)
