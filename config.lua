Config = {}

Config.NotifySystem = 'ox'  --  'esx', 'ox', 'custom'

-- if youre using a custom Notify
Config.CustomNotify = function(source, message)
    TriggerClientEvent('NOTIFY_NAME', source, message) -- Replace NOTIFY_NAME with your notification event
end

Config.Update = 'true' -- 'true', 'false' -- If you want to use the update system