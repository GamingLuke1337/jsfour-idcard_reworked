fx_version 'adamant'
game 'gta5'
version '1.1.1'
lua54 'yes'

author 'Re-Remastered by Gamingluke1337'
description 'ID card system for FiveM'
repository 'https://github.com/GamingLuke1337/jsfour-idcard_reworked/'


ui_page 'html/index.html'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/update.lua',
	'server/main.lua'
}

client_script 'client/main.lua'

shared_scripts {
	'@ox_lib/init.lua',  -- uncomment if you dont want to use the update system (also set Config.Update to false in the config.lua)
	'config.lua'
}
files {
	'html/index.html',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png',
	'html/assets/images/*.jpg'
}

dependencies {
	'oxmysql',
	'ox_lib' -- uncomment if you dont want to use the update system
}
