fx_version 'cerulean'
game 'gta5'

author 'akke'
description 'jengijobi'

-- Tarvittavat tiedostot
client_scripts {
    'config/config.lua',
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Vain jos käytät oxmysql-tietokantaa
    'config/config.lua',
    'server/server.lua'
}

-- Varmista että ox_lib ladataan
dependencies {
    'ox_lib'
}

lua54 'yes'
