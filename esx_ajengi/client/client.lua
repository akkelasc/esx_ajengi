local playerGang = nil

-- Bossmenu avaa valikon, jossa jengin pomo voi hallita jengiä
RegisterCommand('bossmenu', function()
    local xPlayer = PlayerPedId()

    if not playerGang then
        lib.notify({
            title = 'Virhe',
            description = 'Et ole jengin pomo.',
            type = 'error'
        })
        return
    end

    lib.registerContext({
        id = 'boss_menu',
        title = 'Jengin hallinta',
        options = {
            {
                title = 'Lisää jäsen',
                description = 'Lisää pelaaja jengiin',
                event = 'gang:addMember'
            },
            {
                title = 'Poista jäsen',
                description = 'Poista pelaaja jengistä',
                event = 'gang:removeMember'
            },
            {
                title = 'Aseta kaapin sijainti',
                description = 'Aseta kaapin sijainti kartalle',
                event = 'gang:setStash'
            },
            {
                title = 'Aseta asevaraston sijainti',
                description = 'Aseta asevaraston sijainti kartalle',
                event = 'gang:setWeaponShop'
            }
        }
    })

    lib.showContext('boss_menu')
end)

-- Komento kaapin ja asevaraston sijaintien asettamiseksi
RegisterNetEvent('gang:setStash', function()
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('gang:setStashLocation', coords)
end)

RegisterNetEvent('gang:setWeaponShop', function()
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('gang:setWeaponShopLocation', coords)
end)

-- Päivitetään pelaajan jengi client-puolella
RegisterNetEvent('gang:updateGang', function(gangName)
    playerGang = gangName
end)
