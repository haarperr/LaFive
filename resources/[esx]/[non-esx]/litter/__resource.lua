resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Litter by Harybo'

version '2.4'

server_scripts {
	'server/main.lua',
}

client_scripts {
	'@warmenu/warmenu.lua',
	'config.lua',
  	'client/main.lua'
}

dependencies {
	'essentialmode',
}