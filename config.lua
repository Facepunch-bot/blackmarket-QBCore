Config = Config or {}
--ADD ITEMS FOR SALE HERE, JUST BE SURE TO UPDATE INDEX AND SLOT
Config.Products = {
    ["blackmarket1"] = {
        [1] = {
            name = "trojan_usb",
            price = 2000,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "security_card_01",
            price = 2000,
            amount = 1,
            info = {},
            type = "item",
            slot = 2,
        },
        [4] = {
            name = "laptop",
            price = 1800,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "tunerlaptop",
            price = 2000,
            amount = 1,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "weed_amnesia_seed",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "weed_og-kush_seed",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "weed_purple-haze_seed",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "painkillers",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "lockpick",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "weed_nutrition",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "empty_weed_bag",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "cocaleaf",
            price = 90,
            amount = 1,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "nitrous",
            price = 80,
            amount = 1,
            info = {},
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "screwdriverset",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 15,
        },
        [16] = {
            name = "lockpick",
            price = 120,
            amount = 1,
            info = {},
            type = "item",
            slot = 16,
        },
    },
}
Config.PurchaseItems = {
    ["smg_stock"] ={
        price = 120,
    },
    ["rifle_stock"] ={
        price = 120,
    },
    ["smg_stock_mold"] ={
        price = 120,
    },
}

--UPDATE THE NUMBER BELOW TO CHOOSE A LOCATION FROM THE LIST -- could always set this to a random number as well!
local setLocPick = 2

--UPDATE THIS TABLE TO CREATE NEW LOCATIONS
Config.LocationSets = {
    [1] = {
        ["x"] = 1333.06,
        ["y"] = 4326.86,
        ["z"] = 38.017,
        ["h"] = 347.83,
    },
    --vector3(-1053.13, -233.03, 44.02)
    [2] = {
        ["x"] = -1053.13,
        ["y"] = -233.03,
        ["z"] = 44.02,
        ["h"] = 136.87,
    },
} 

Config.Locations = {
    ["blackmarket1"] = {
        ["label"] = "Black Market",
        ["type"] = "BM",
        ["coords"] = {
            [1] = {
                ["x"] = tonumber(Config.LocationSets[setLocPick]["x"]),
                ["y"] = tonumber(Config.LocationSets[setLocPick]["y"]),
                ["z"] = tonumber(Config.LocationSets[setLocPick]["z"]),
                ["h"] = tonumber(Config.LocationSets[setLocPick]["h"]),
            },
        },
        ["products"] = Config.Products["blackmarket1"],
    },
}