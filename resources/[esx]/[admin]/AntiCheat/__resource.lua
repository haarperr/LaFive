resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'cl_anticheat.lua',
	'cl_deleteVehModdeur.lua'
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'srv_anticheat.lua',
	'srv_init.lua'
}

dependencies {
	'essentialmode',
	'async'
}