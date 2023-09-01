--[[
    COPYRIGHT (C) 2023 Synthex Development. ALL RIGHTS RESERVED.
    DO NOT DISTRIBUTE WITHOUT PERMISSION.
    Email: hhype.vibez@gmail.com
]]

local prefix = "dvall | "

RegisterCommand('dvall', function(source, args, rawCommand)
    TriggerClientEvent("synthex:dvall", -1)
    Wait(1)
end, true)
