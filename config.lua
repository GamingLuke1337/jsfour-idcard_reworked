Config = {}

Config.framework = 'esx' -- 'esx', 'qbcore', 'qbx_core', 'vrp', 'nd', 'ox_core'

Config.NewESX = true -- Set to true if you are using the new ESX (ESX Legacy) -- only for Config.framework = 'esx'

Config.NotifySystem = 'ox'  --  'esx', 'ox', 'custom'

Config.Update = 'true' -- Set to false if you dont want to use the update system

-- Translations
Config.NoLicenses = 'You have no licenses.'

-- if youre using a custom Notify
Config.CustomNotify = function(source, message)
    TriggerClientEvent('NOTIFY_NAME', source, message) -- Replace NOTIFY_NAME with your notification event
end
