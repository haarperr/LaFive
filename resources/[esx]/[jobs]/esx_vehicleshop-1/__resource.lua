resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
server_script '@mysql-async/lib/MySQL.lua'
client_script "client/NativeUI.lua"
client_script 'client/cl_vehshop.lua'
server_script 'server/sv_vehshop.lua'




client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}