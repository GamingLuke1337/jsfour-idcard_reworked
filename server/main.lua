local ESX = exports['es_extended']:getSharedObject()

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    local _source = ESX.GetPlayerFromId(targetID).source

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
                    SendNotify(_source, "Du hast keine Lizenzen.")
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
