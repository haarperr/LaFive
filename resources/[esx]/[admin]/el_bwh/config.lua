Config = {}

Config.admin_groups = {"admin","superadmin"} -- groups that can use admin commands
Config.admin_level = 10 -- min admin level that can use admin commands
Config.banformat = "BANNED!\nRaison: %s\nExpire: %s\nBanni par: %s (Ban ID: #%s)" -- message shown when banned (1st %s = reason, 2nd %s = expire, 3rd %s = banner, 4th %s = ban id)
Config.popassistformat = "Le joueur %s demande de l\'aide\nWrite <span class='text-success'>/accassist %s</span> pour accepter ou <span class='text-danger'>/decassist</span> pour refuser" -- popup assist message format
Config.chatassistformat = "Le joueur %s demande de l\'aide\nWrite ^2/accassist %s^7 pour accepter ou ^1/decassist^7 pour refuser \n^4Reason^7: %s" -- chat assist message format
Config.assist_keys = {accept=208,decline=207} -- keys for accepting/declining assist messages (default = page up, page down) - https://docs.fivem.net/game-references/controls/
-- Config.assist_keys = nil -- coment the line above and uncomment this one to disable assist keys
Config.warning_screentime = 7.5 * 1000 -- warning display length (in ms)