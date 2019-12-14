const defaultConfig = {
    serverPassword: "12345",
    serverName: "GTALife",
    serverWebsite: "https://www.gtaliferp.fr",
    serverLogo: "https://gtaliferp.fr/img/logo+hi.png",

    cardTitle: "Access denied. Please enter server's password",
    enterText: "Entrer",
    passwordPlaceholder: "Mot de passe",
    wrongPasswordMessage : "This is not the right password."
}

function LoadUserConfig() {
    try {
        const a = JSON.parse(LoadResourceFile(GetCurrentResourceName(), "config.json"))
        return a;
    }
    catch(e) {
        console.log("[pPassword] Configuration file not loaded.")
    }
}

const userConfig = LoadUserConfig() || defaultConfig;

// Generated using https://adaptivecards.io/designer/
const adaptiveCardTemplate = {
    "type": "AdaptiveCard",
    "body": [
        {
            "type": "TextBlock",
            "size": "Medium",
            "weight": "Bolder",
            "text": `${userConfig.cardTitle}`,
        },
        {
            "type": "ColumnSet",
            "columns": [
                {
                    "type": "Column",
                    "items": [
                        {
                            "type": "Image",
                            "url": `${userConfig.serverLogo}`,
                            "size": "Medium"
                        }
                    ],
                    "width": "auto"
                },
                {
                    "type": "Column",
                    "items": [
                        {
                            "type": "TextBlock",
                            "weight": "Bolder",
                            "text": `${userConfig.serverName}`,
                            "wrap": true
                        },
                        {
                            "type": "TextBlock",
                            "spacing": "None",
                            "text": `${userConfig.serverWebsite}`,
                            "url": "https://lafiverp.fr/",
                            "isSubtle": true,
                            "wrap": true,
                        },
                        {
                            "type": "TextBlock",
                            "spacing": "None",
                            "text": "Mot de passe disponible sur notre discord",
                            "isSubtle": true,
                            "wrap": true,
                        }
                    ],
                    "width": "stretch"
                }
            ]
        },
        {
            "type": "Input.Text",
            "placeholder": `${userConfig.passwordPlaceholder}`,
            "inlineAction": {
                "type": "Action.Submit",
                "id": "",
                "title": `${userConfig.enterText}`
            },
            "id": "password"
        }
    ],
    "actions": [
        {
            "type": "Action.OpenUrl",
            "title": "Discord",
            "url": "https://discord.gg/UjUrfnN"
        }
    ],
    "version": "1.0",
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json"
}

const Delay = (ms) => new Promise(res => setTimeout(res, ms));

async function showCard(d) {
    d.presentCard(JSON.stringify(adaptiveCardTemplate), async (data) => {
        if (data.password && data.password === userConfig.serverPassword) {
            d.done()
        } else {
            d.update(userConfig.wrongPasswordMessage)
            await Delay(2000)
            showCard(d)
        }
    })
}

onNet('playerConnecting', async (playerName, dropPlayer, d) => {
    d.defer()
    showCard(d)
})