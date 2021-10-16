local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--Code

RegisterServerEvent('mickey-blackmarket:server:UpdateShopItems')
AddEventHandler('mickey-blackmarket:server:UpdateShopItems', function(shop, itemData, amount)
    Config.Locations[shop]["products"][itemData.slot].amount =  Config.Locations[shop]["products"][itemData.slot].amount - amount
    if Config.Locations[shop]["products"][itemData.slot].amount <= 0 then 
        Config.Locations[shop]["products"][itemData.slot].amount = 0
    end
    TriggerClientEvent('mickey-blackmarket:client:SetShopItems', -1, shop, Config.Locations[shop]["products"])
end)

RegisterServerEvent('mickey-blackmarket:server:RestockShopItems')
AddEventHandler('mickey-blackmarket:server:RestockShopItems', function(shop)
    if Config.Locations[shop]["products"] ~= nil then 
        local randAmount = math.random(10, 50)
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + randAmount
        end
        TriggerClientEvent('mickey-blackmarket:client:RestockShopItems', -1, shop, randAmount)
    end
end)