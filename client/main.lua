ESX = exports['es_extended']:getSharedObject()

local isplayerbleeding = false
local isplayerdead = false
local bleedouttimesecond = Config.bleedoutimesecond
local bleedouttimeminute = Config.bleedouttimeminute

function playerdead()
    isplayerbleeding = true
    SetNuiFocus(true,true)
    SendNUIMessage({
        value = true,
        type = 'UI',
       })
end

function displayint(number)
    local number = math.floor(number)
    if (number < 10) then
        number = "0" .. number;
    end
    return number;
end

function starttimer()
    while true do
print(bleedouttimeminute,bleedouttimesecond)
        if isplayerbleeding and bleedouttimesecond > 0 then
            bleedouttimesecond = bleedouttimesecond - 1
        end
    if bleedouttimeminute > 0 and bleedouttimesecond == 0 then
        bleedouttimeminute = bleedouttimeminute - 1
        bleedouttimesecond = 60
    end

    if bleedouttimeminute == 0 and bleedouttimesecond == 1 then
        isplayerdead = true
    end

        
        
SendNUIMessage({
    value = displayint(bleedouttimeminute)..":"..displayint(bleedouttimesecond),
    type = 'timer',
    bleedout = isplayerdead
})

        Wait(1000)
    end
end

function senddistress()
    PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
    if isplayerdead == false then
    ESX.ShowNotification("Your distress signal has been sended")
    TriggerServerEvent('esx_ambulancejob:onPlayerDistress')
    else
        isplayerdead = false
        openmenu()
        SendNUIMessage({
            type = 'respawnselector',
            value = true
        })

    end
end


RegisterNUICallback('emsbuttonpressed', function(data,cb)
cb({})
senddistress()
end)



AddEventHandler('esx:onPlayerDeath', function(data)
    ClearTimecycleModifier()
    SetTimecycleModifier("REDMIST_blend")
    SetTimecycleModifierStrength(0.7)
    SetExtraTimecycleModifier("fp_vig_red")
    SetExtraTimecycleModifierStrength(1.0)
    SetPedMotionBlur(PlayerPedId(), true)
    playerdead()
    starttimer()
  end)
  


  


function openmenu()
local option = {}
    for k,v in pairs(Config.hospital) do
        table.insert(option,v)
    end
SendNUIMessage({respawn = option})


--[[  lib.registerContext({
    id = 'respawnselector',
    title = 'Respawn Selector',
    options = option
})

lib.showContext('respawnselector')--]]
end

RegisterNUICallback('respawnbuttonpressed', function(data,cb)
if data.msg == 'respawn' then
    PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
    print(data.name)
    for i = 1, #Config.hospital do 
        if Config.hospital[i].name == data.name then
            local v = Config.hospital[i]
            respawn(v)
        end
        end
    
end  
end)


LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end

    return Dict
end
local ped = PlayerPedId()
FreezeEntityPosition(ped, false)
function respawn(v)
local data = v
    local ped = PlayerPedId()
    local animation = 'idle_c'
    local dict = 'timetable@tracy@sleep@'
    TriggerEvent('JG-Deathscreen:revive')
    DoScreenFadeOut(1000)
    Wait(1000)
    TriggerEvent("esx_ambulancejob:revive")
    SetEntityHeading(ped,data.heading)
    SetEntityCoordsNoOffset(ped, data.pos.x,data.pos.y,data.pos.z, false, false, false)
    FreezeEntityPosition(ped, true)
    Wait(200)
    TaskPlayAnim(ped, LoadDict(dict), animation, 2.0, 2.0, -1, 1, 0, false,false,false)
    DoScreenFadeIn(1000)
    --- Progress bar
    Wait(1000 * Config.timeonbed)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoordsNoOffset(ped, data.pos.x,data.pos.y,data.pos.z, false, false, false)
    Wait(1000)
    DoScreenFadeIn(1000)
    FreezeEntityPosition(ped, false)
end

RegisterNetEvent('JG-Deathscreen:revive', function()
    print('respawn')
    SetNuiFocus(false,false)
    isplayerbleeding = false
    isplayerdead = false
    bleedouttimesecond = Config.bleedoutimesecond
    bleedouttimeminute = Config.bleedouttimeminute
    SendNUIMessage({
    type = 'revived',
    value = true
    })
end)

