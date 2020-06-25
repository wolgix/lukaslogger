
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



AddEventHandler('onClientResourceStart', function()
    --print("Unser erstes Script wurde soeben clientseitig gestartet")
end)