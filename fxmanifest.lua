fx_version 'adamant'

game 'gta5'
lua54 'yes'

description 'Death screen script for ESX By JGUsman#5140'

shared_scripts{
    'shared.lua',
    '@ox_lib/init.lua'
}

client_scripts{
    'client/main.lua'
}

server_scripts{
    'server/main.lua'
}


ui_page 'web/index.html'

files{
    'web/style.css',
    'web/script.js',
    'web/index.html'
}