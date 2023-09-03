local commandName = Config.commandName
local permissionsRequired = Config.permissionsRequired

RegisterCommand(commandName, function(source, argsa, rawCommand)
    local playerId = GetPlayerIdentifiers(source)[1]
    if IsPlayerAceAllowed(source, permissionsRequired) then
        TriggerEvent(commandName, source)
    else
        TriggerClientEvent("chatMessage", source, "^1Error: You have no permissions, to use this command") -- NOTE: You can remove this, and add your own notify event
    end
end, false)

AddEventHandler(commandName, function(source)
    local playerId = GetPlayerIdentifiers(source)[1]

    local totalVehicles = 0
    local notDeletedVehicles = 0

    for vehicle in EnumerateVehicles() do
        if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
            SetVehicleHasBeenOwnedByPlayer(vehicle, false)
            SetEntityAsMissionEntity(vehicle, false, false)
            DeletedVehicle(vehicle)
            
            if DoesEntityExist(vehicle) then
                DeletedVehicle(vehicle)
            end

            if DoesEntityExist(vehicle) then
                notDeletedVehicles = notDeletedVehicles + 1
            end
        end 

        totalVehilces = totalVehicles + 1
    end

    local deletedFraction = totalVehicles - notDeletedVehicles .. " / " .. totalVehicles
    print ("Player " .. playerId .. " deleted " .. deletedFraction .. " vehicles on the server!")
    TriggerClientEvent("synthex:dvall", source, deletedFraction)
    end)