Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(542171280183656458)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo_lafive')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        --SetDiscordRichPresenceAssetText('LaFive | Serveur Roleplay GTA V')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('discordicon')

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetSmallText("ID: "..id.." | "..name.." ")

        -- Nombre de joueurs  
  
        --No Need to mess with anything pass this point!
        name = GetPlayerName(PlayerId())
        id = GetPlayerServerId(PlayerId())
        SetDiscordRichPresenceAssetText('Redécouvrez le Roleplay sur discord.gg/UjUrfnN')

        --Texte perso
       --SetRichPresence('discord.gg/rk5MRWR')
        
        --It updates every one minute just in case.
		Citizen.Wait(60000)
    end
end)