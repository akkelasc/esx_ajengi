local gangs = {}

-- Jengin luonti (vain adminit)
RegisterCommand('luojengi', function(source, args)
    local xPlayer = Ox.GetPlayer(source)
    if not isAdmin(xPlayer) then
        xPlayer:notify("Sinulla ei ole oikeuksia luoda jengiä.")
        return
    end

    local gangName = args[1]
    if not gangName then
        xPlayer:notify("Anna jengin nimi.")
        return
    end

    createGang(gangName, xPlayer.identifier)
    xPlayer:notify("Jengi "..gangName.." luotu!")
end)

-- Jäsenen lisääminen
RegisterNetEvent('gang:addMember', function(targetId)
    local xPlayer = Ox.GetPlayer(source)
    local targetPlayer = Ox.GetPlayer(targetId)

    if not isGangOwner(xPlayer) then
        xPlayer:notify("Et ole jengin pomo.")
        return
    end

    targetPlayer.gang = xPlayer.gang
    TriggerClientEvent('gang:updateGang', targetId, xPlayer.gang)
    xPlayer:notify("Pelaaja lisätty jengiin!")
    targetPlayer:notify("Sinut lisättiin jengiin "..xPlayer.gang)
end)

-- Jäsenen poistaminen
RegisterNetEvent('gang:removeMember', function(targetId)
    local xPlayer = Ox.GetPlayer(source)
    local targetPlayer = Ox.GetPlayer(targetId)

    if not isGangOwner(xPlayer) then
        xPlayer:notify("Et ole jengin pomo.")
        return
    end

    targetPlayer.gang = nil
    TriggerClientEvent('gang:updateGang', targetId, nil)
    xPlayer:notify("Pelaaja poistettu jengistä!")
    targetPlayer:notify("Sinut poistettiin jengistä "..xPlayer.gang)
end)

-- Kaapin sijainnin asettaminen
RegisterNetEvent('gang:setStashLocation', function(coords)
    local xPlayer = Ox.GetPlayer(source)

    if not isGangOwner(xPlayer) then
        xPlayer:notify("Et ole jengin pomo.")
        return
    end

    gangs[xPlayer.gang].stashLocation = coords
    xPlayer:notify("Kaapin sijainti asetettu!")
end)

-- Asevaraston sijainnin asettaminen
RegisterNetEvent('gang:setWeaponShopLocation', function(coords)
    local xPlayer = Ox.GetPlayer(source)

    if not isGangOwner(xPlayer) then
        xPlayer:notify("Et ole jengin pomo.")
        return
    end

    gangs[xPlayer.gang].weaponShopLocation = coords
    xPlayer:notify("Asevaraston sijainti asetettu!")
end)

-- Funktiot oikeuksien tarkistamiseen
function isAdmin(xPlayer)
    return Config.AdminGroups[xPlayer.group] ~= nil
end

function isGangOwner(xPlayer)
    return gangs[xPlayer.gang] and gangs[xPlayer.gang].owner == xPlayer.identifier
end

-- Funktio jengin luomiseen
function createGang(name, owner)
    gangs[name] = {
        owner = owner,
        stashLocation = nil,
        weaponShopLocation = nil
    }
end
