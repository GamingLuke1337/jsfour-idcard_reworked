local ESX, QBCore, QBXCore, vRP, NDCore, OXCore

if Config.framework == 'esx' then
    if Config.NewESX then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
elseif Config.framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.framework == 'qbx_core' then
    QBXCore = exports['qb-core']:GetCoreObject()
elseif Config.framework == 'vrp' then
    vRP = Proxy.getInterface("vRP")
elseif Config.framework == 'nd' then
    local NDCore = require "@ND_Core/init.lua" 
elseif Config.framework == 'ox_core' then
        local Ox = require '@ox_core.lib.init'
    end

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
    local identifier, _source

    if Config.framework == 'esx' then
        identifier = ESX.GetPlayerFromId(ID).identifier
        _source = ESX.GetPlayerFromId(targetID).source
    elseif Config.framework == 'qbcore' then
        identifier = QBCore.Functions.GetPlayer(ID).PlayerData.citizenid
        _source = QBCore.Functions.GetPlayer(targetID).PlayerData.source
    elseif Config.framework == 'qbx_core' then
        identifier = QBXCore.Functions.GetPlayer(ID).PlayerData.citizenid
        _source = QBXCore.Functions.GetPlayer(targetID).PlayerData.source
    elseif Config.framework == 'vrp' then
        identifier = vRP.getUserId({ID})
        _source = vRP.getUserSource({targetID})
    elseif Config.framework == 'nd' then
        identifier = NDCore.Functions.GetPlayer(ID).citizenid
        _source = NDCore.Functions.GetPlayer(targetID).source
    elseif Config.framework == 'ox_core' then
        identifier = Ox.GetPlayer(ID).identifier
        _source = Ox.GetPlayer(targetID).source
    end

    if not identifier then return end

    -- Nutzerinformationen abrufen
    exports.oxmysql:execute('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = ?', 
    { identifier }, function(user)
        if user[1] then
            -- Lizenzen abrufen
            exports.oxmysql:execute('SELECT type FROM user_licenses WHERE owner = ?', 
            { identifier }, function(licenses)
                local show = false

                if type then
                    for _, license in ipairs(licenses) do
                        if type == 'driver' and (license.type == 'drive' or license.type == 'drive_bike' or license.type == 'drive_truck' or license.type == 'fly' or license.type == 'fly_jet' or license.type == 'fly_light') then
                            show = true
                            break
                        elseif type == 'weapon' and license.type == 'weapon' then
                            show = true
                            break
                        end
                    end
                else
                    show = true
                end

                if show then
                    TriggerClientEvent('jsfour-idcard:open', _source, { user = user, licenses = licenses }, type)
                else
                    SendNotify(_source, Config.NoLicenses or "Du hast keine Lizenzen.")
                end
            end)
        end
    end)
end)

-- Benachrichtigungssystem je nach Config nutzen
function SendNotify(source, message)
    if Config.NotifySystem == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif Config.NotifySystem == 'ox' then
        TriggerClientEvent('ox_lib:notify', source, { description = message, type = 'error' })
    elseif Config.NotifySystem == 'custom' then
        Config.CustomNotify(source, message)
    end
end
