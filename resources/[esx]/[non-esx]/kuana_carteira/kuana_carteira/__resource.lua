resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/script.js",
	"nui/ui.js",
	"nui/style.css",
	"nui/img/logotrabalho.png",
	"nui/img/logocc.png",
	"nui/img/logovisa.png",
	"nui/img/logo.png",
	"nui/img/fundo.png",
	"nui/img/fundo1.png",
	"nui/img/fundo2.png",
	"nui/img/fundo3.png",
	"nui/img/card1.png",
	"nui/img/card2.png",
	"nui/img/card3.png",
	"nui/img/chip.png"
}

client_script {
	'click.lua',
	'client.lua',
}

server_script {
  '@mysql-async/lib/MySQL.lua',
  'server.lua'
}
