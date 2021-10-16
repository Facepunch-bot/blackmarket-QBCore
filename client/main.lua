Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

QBCore = exports['qb-core']:GetCoreObject()


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            for _, loc in pairs(position) do
                local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
                if dist <= 500.0 then
                    if not DoesEntityExist(dealer) then
                        RequestModel("s_m_y_dealer_01")
                        while not HasModelLoaded("s_m_y_dealer_01") do
                            Wait(10)
                        end
        
                        dealer = CreatePed(26, "s_m_y_dealer_01", loc["x"], loc["y"], loc["z"], loc["h"], false, false)
                        SetEntityHeading(dealer, loc["h"])
                        SetBlockingOfNonTemporaryEvents(dealer, true)
                        TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
                        FreezeEntityPosition(dealer, true)
	                    SetEntityInvincible(dealer, true)
                    end
                else
                    Citizen.Wait(1500)
                end

                if dist <= 10 then
                    InRange = true
                    --DrawMarker(2, loc["x"], loc["y"], loc["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                    if dist <= 2 then
                        DrawText3Ds(loc["x"], loc["y"], loc["z"] + 1, '~g~E~w~ - Shop Black Market')
                        if IsControlJustPressed(0, 38) then -- E
                            if GetClockHours() >= 1 and GetClockHours() <= 3 then
                                local ShopItems = {}
                                ShopItems.label = Config.Locations[shop]["label"]
                                ShopItems.items = Config.Locations[shop]["products"]
                                ShopItems.slots = 30
                                TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                            else
                                DrawText3Ds(loc["x"], loc["y"], loc["z"] + 2, 'Come back another time.')
                            end
                        end
                    end
                end
            end
        end

        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('mickey-blackmarket:client:UpdateShop')
AddEventHandler('mickey-blackmarket:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('mickey-blackmarket:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('mickey-blackmarket:client:SetShopItems')
AddEventHandler('mickey-blackmarket:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('mickey-blackmarket:client:RestockShopItems')
AddEventHandler('mickey-blackmarket:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then 
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

--Below enables blips
--[[
Citizen.CreateThread(function()
    for store,_ in pairs(Config.Locations) do
        StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][1]["x"], Config.Locations[store]["coords"][1]["y"], Config.Locations[store]["coords"][1]["z"])
        SetBlipColour(StoreBlip, 0)

        if Config.Locations[store]["products"] == Config.Products["blackmarket"] then
            SetBlipSprite(StoreBlip, 354)
            SetBlipScale(StoreBlip, 0.85)
        end

        SetBlipDisplay(StoreBlip, 4)
        SetBlipAsShortRange(StoreBlip, true)
    

        BeginTextCommandSetBlipName("Black Market")
        EndTextCommandSetBlipName(StoreBlip)
    end
end)]]
