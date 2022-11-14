local sleep = 5

local PedVivo = false
local PedEntity = false
local PedActivo = false

local iniciar = "~r~" .. Config.Locales[Config.Locale]['no']
local movimiento = "~g~" .. Config.Locales[Config.Locale]['yes']
local rodamientos = "~g~" .. Config.Locales[Config.Locale]['yes']

CreateThread(function() 
  while true do
    Wait(sleep)
    local _ped = PlayerPedId()
    local player = GetEntityCoords(_ped)
    local distance = #(Config.Coords)
    if (distance < Config.Distance) then
       text(Config.Coords.x, Config.Coords.y, Config.Coords.z, joaoConti.cord_.z+1, 0, 0.3, 0.3, 255, 255, 255, 255, "| ~y~Y~w~ | " .. Config.Locales[Config.Locale]['tochange'] .. " ~y~/~s~ " .. Config.Locales[Config.Locale]['start'] .. "~s~:" .. iniciar)
       text(Config.Coords.x, Config.Coords.y, Config.Coords.z, joaoConti.cord_.z+1, 0, 0.3, 0.3, 255, 255, 255, 255, "| ~y~E~w~ | " .. Config.Locales[Config.Locale]['tochange'] .. " ~y~/~s~ " .. Config.Locales[Config.Locale]['bearings'] .. "~s~:" .. rodamientos)
       text(Config.Coords.x, Config.Coords.y, Config.Coords.z, joaoConti.cord_.z+1, 0, 0.3, 0.3, 255, 255, 255, 255, "| ~y~Y~w~ | " .. Config.Locales[Config.Locale]['tochange'] .. " ~y~/~s~ " .. Config.Locales[Config.Locale]['movement'] .. "~s~:" .. movimiento)
       if (IsControlJustPressed(0, 246) then
            SetTimeout(500, function()
              if (iniciar == "~r~" .. Config.Locales[Config.Locale]['no']) then
                 iniciar = "~g~" .. Config.Locales[Config.Locale]['yes']
                 PedActivo = true
                 SpawnPed()
                 SpawnedPed()
              else
                  iniciar == "~r~" .. Config.Locales[Config.Locale]['no']
                  PedVivo = false
                  if DoesEntityExist(PedEntity) then
                    DeleteEntity(PedEntity)
                  end
                  PedActivo = false
                  PedEntity = false
              end
          end)
       elseif (IsControlJustPressed(0, 38) then
        if (rodamientos == "~g~" .. Config.Locales[Config.Locale]['yes']) then
          rodamientos = '~r~' .. Config.Locales[Config.Locale]['no']
        else
          rodamientos = '~g~' .. Config.Locales[Config.Locale]['yes']
        end
       elseif (IsControlJustPressed(0, 303) then
        if (movimiento == "~g~" .. Config.Locales[Config.Locale]['yes']) then
           movimiento = "~r~" .. Config.Locales[Config.Locale]['no']       
        else
          movimiento = "~g~" .. Config.Locales[Config.Locale]['yes']  
        end
       end
    end
  end
end)
      
SpawnedPed = function()
   CreateThread(function()
    while PedActivo do
      local PedHealth = GetEntityHealth(PedEntity)
      if (PedHealth == 0 and PedEntity) then
        PedVivo = false
        DeleteEntity(PedEntity)
        PedEntity = false
        SpawnPed()
      else
        SetEntityHealth(PedEntity, 200)
      end
      Wait(sleep)
    end
   end)
end

SpawnPed = function()
  local random = math.random(2)
  CreateThread(function()
    local spawn = PedSpawnCoords()
    local ma = math.random(#spawn)
    while not PedVivo do
       RequestModel(GetHashKey(Config.NPC))
       while not HasModelLoaded(GetHashKey(Config.NPC)) do
        Wait(100)      
       end
       ped = CreatePed(4,Config.NPCHash,spawn[ma].x,spawn[ma].y,spawn[ma].z-1,151.0,false,true)
       PedEntity = ped
       SetBlockingOfNonTemporaryEvents(ped, true)
       PedVivo = true
       if rolar == "~g~" .. Config.Locales[Config.Locale]['yes']   and movimentar == "~g~" .. Config.Locales[Config.Locale]['yes']   then
        Wait(1000)
        __anim(ped)
        elseif rolar == "~g~" .. Config.Locales[Config.Locale]['yes']   then
          Wait(1000)
          if randomizar == 1 then
            anim(ped,'move_strafe@roll_fps','combatroll_bwd_p1_-135',8.0,-8.0)
          else
            anim(ped,'move_strafe@roll_fps','combatroll_bwd_p1_135',8.0,-8.0)
          end
        elseif movimentar == "~g~" .. Config.Locales[Config.Locale]['yes']   then
          Wait(1000)
          _anim(ped)
        end
    end
  end)
end
