Citizen.CreateThread(function ()
  TriggerEvent('chat:addSuggestion','/dvall','[STAFF ONLY] Delete all vehicles.',{
      {},
    })
end)

RegisterNetEvent("synthex:dvall")
AddEventHandler("synthex:dvall", function ()
  local totalvehc = 0
  local notdelvehc = 0

  for vehicle in EnumerateVehicles() do
      if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteVehicle(vehicle)
          if (DoesEntityExist(vehicle)) then DeleteVehicle(vehicle) end
          if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
      end
      totalvehc = totalvehc + 1 
  end
  local vehfrac = totalvehc - notdelvehc .. " / " .. totalvehc
  Citizen.Trace("You just deleted "..vehfrac.." vehicles in the server!")
end)


local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
