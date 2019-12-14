Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'fr' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {5000, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1164.94, -323.76, 68.2-0.98), heading = 100.0, money = {5000, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7500, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(372.85, 328.10, 102.56-0.98), heading = 266.0, money = {7500, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.24, -983.14, 45.41-0.98), heading = 266.0, money = {7500, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1221.40, -908.02, 11.32-0.98), heading = 40.0, money = {7500, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-47.39, -1758.72, 28.42-0.98), heading = 40.0, money = {7500, 16000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1728.62, 6416.81, 34.03-0.98), heading = 240.0, money = {3000, 6000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1959.16, 3741.52, 31.34-0.98), heading = 290.0, money = {3000, 6000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(1984.41, 3054.70, 46.21-0.98), heading = 290.0, money = {3000, 6000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false},
    {coords = vector3(-2966.37, 391.57, 15.04-0.98), heading = 100.0, money = {3000, 6000}, cops = 2, blip = false, name = 'Braquage', cooldown = {hour = 0, minute = 40, second = 0}, robbed = false}
}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'shopkeeper',
        ['robbed'] = "I was just robbed and ~r~don't ~w~have any money left!",
        ['cashrecieved'] = 'You got:',
        ['currency'] = '$',
        ['scared'] = 'Scared:',
        ['no_cops'] = 'There are ~r~not~w~ enough cops online!',
        ['cop_msg'] = 'We have sent a photo of the robber taken by the CCTV camera!',
        ['set_waypoint'] = 'Set waypoint to the store',
        ['hide_box'] = 'Close this box',
        ['robbery'] = 'Robbery in progress',
        ['walked_too_far'] = 'You walked too far away!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['fr'] = { -- edit this to your language
        ['shopkeeper'] = 'Vendeur',
        ['robbed'] = 'Je viens de me faire braquer et je n\'ai plus d\'argent restant',
        ['cashrecieved'] = 'Vous avez recu:',
        ['currency'] = '$',
        ['scared'] = 'Peur:',
        ['no_cops'] = 'Il n y\'a pas assez de policiers connectés',
        ['cop_msg'] = 'Une personne a braqué une superette! Appuyer sur ~g~E ~w~pour prendre l\'appel ou ~r~ESPACE ~w~pour refuser l\'appel',
        ['set_waypoint'] = 'Mettre un point vers le magasin',
        ['hide_box'] = 'Refuser l\'appel',
        ['robbery'] = 'Braquage en cours',
        ['walked_too_far'] = 'Vous etes partit trop loin du magasin'
    }
}