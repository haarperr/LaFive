var config = {
  'title': 'LaFive',
  'welcomeMessage': 'Bienvenue sur LaFive',
  // Add images for the loading screen background.
  images: [
  'https://i.imgur.com/aQj8lCV.png', 'https://img.skordy.com/j/nsQy5.jpeg', 'https://img.skordy.com/j/KNlLn.jpeg',
  ],
  // Turn on/off music
  enableMusic: true,
  // Music list. (Youtube video IDs). Last one should not have a comma at the end.
  music: [
    'CavBCtOnH0E', 'I6mHm7s2yuU', '5jw-A6fedV8', 'tgIqecROs5M'
  ],
  // Change music volume 0-100.
  musicVolume: 05,
  // Change Discord settings and link.
  'discord': {
    'show': true,
    'discordLink': 'http://discord.lafiverp.fr/',
  },
  // Change which key you have set in guidehud/client/client.lua
  'menuHotkey': 'F7',
  // Turn on/off rule tabs. true/false
  'rules': {
    'generalconduct': true,
    'roleplaying': true,
    'rdmvdm': false,
    'metagaming': false,
    'newlife': false,
    'abuse': false,
  },
}

// Home page annountments.
var announcements = [
  'Votez pour nous top-serveur et recevez 2000$ ainsi qu\'une chance de gagner un véhicule moddé! (Les streamers, ne changez pas de musique sous peine de vous faire strike)',
]


// Add/Modify rules below.
var guidelines = [
  "Le non-respect de l'une de ces règles peut entraîner des mesures administratives.",
  "Ne pas connaître les règles ne rend pas les joueurs exemptés.",
  "Si un autre joueur enfreint les règles, cela ne vous donne pas le droit d'enfreindre une règle vous-même",
  "Essayer de contourner une règle évidente peut entraîner une interdiction",
  "Le personnel se réserve le droit d'interdire aux joueurs qui, à leur avis, sont toxiques, perturbateurs ou ne jouent pas par l'esprit du mode de jeu.",
  "Toutes les règles ne peuvent pas être listées, alors faites preuve de bon sens lorsque vous jouez",
  "Les règles mineures peuvent être remplacées par un excellent jeu de rôle défini par le personnel.",
]

var generalconduct = [
  "Le racisme, le sectarisme, l'anti-antisémitisme et toute autre forme de harcèlement ne sont pas tolérés",
  "Les joueurs ne peuvent pas simuler d'agression sexuelle, de viol ou quoi que ce soit qui puisse être considéré comme un comportement intense et inapproprié.",
]

var roleplaying = [
  "Les joueurs doivent jouer le rôle de toutes les situations.",
  '- Exemple: "J\'ai utilisé le feu rouge à cause d\'un décalage du serveur" ou de situations similaires non autorisées.',
  '- Exception: les joueurs ne peuvent sortir du personnage que lorsqu\'un membre du personnel vous demande d\'expliquer une situation et / ou vous autorise à devenir OOC.',
  "Les joueurs doivent valoriser leur vie.",
  '- Exemple: si un joueur a une arme à feu à la tête, il doit agir en conséquence.',
  'Les joueurs ne peuvent pas décider de la citation.',
  "Les joueurs doivent jouer le rôle des blessures médicales correctement à tout moment.",
  'Les joueurs ne peuvent pas faire intentionnellement devant la police des actes qui ne seraient normalement pas accomplis. Ceci est connu comme "Cop Baiting". ',
  "Les joueurs ne peuvent pas voler de véhicules de police / infirmiers sans surveillance stationnés dans des postes de police ou des hôpitaux.",
  "Les joueurs ne peuvent pas entrer dans un appartement pour éviter les conséquences ou les jeux de rôle.",
  "Les joueurs ne peuvent pas intentionnellement réapparaître, se déconnecter, ni trouver un autre moyen d'éviter ou d'éviter un jeu de rôle potentiel.",
]

var rdmvdm = [
  'Players can not kill or attack other players without role-play.',
  'Players must have a reason or a benefit to their character when trying to kill or attack another player.',
  '- Example:  Yelling "hands up or die" without a reason is not valid role-play.',
  'Players may use vehicles as weapons as long as its within role-play and logical.',
  'Players can not intentionally use aerial vehicles to collide into other players or vehicles.',
]

var metagaming = [
  'Players can not use information gathered outside of role-play to influence their actions within the game.',
  'Players may remove another players communication devices in an role-play manner.',
  'Players with removed communication devices are expected to mute their third-party communication software.',
  'Players may only remove another players communication device when it is logical within role-play.',
  'Players can not use information gathered from outside the server (such as forums) while in-game.',
  'Knowledge and experiences should be learned and discovered by a players current character in-game.',
  'Players can not force another player into a situation that they cannot role-play out of. This is known as "Power-Gaming".',
  'Players must use common sense when encountering power-gaming potential situations.',
]

var newlife = [
  'Players that are downed but then stabilized should continue role-play accordingly.',
  'Players that are killed ("respawn" is prompted) must "forget" their previous situation in which they have died.',
  'Players that are killed may still proceed with their current character. (players may DOA their character and start a new character story).',
]

var abuse = [
  'Players can not abuse or exploit bugs.',
  'Players can not hack or script. (using third-party software, injectors, etc).',
  'Players who report an exploit using the proper procedures will be rewarded ingame.',
]

// Modify hotkeys below.
var generalhotkeys = [
  'Appuyer sur <kbd>F1</kbd> pour changer la portée de votre voix',
  'Appuyer sur <kbd>F10</kbd> pour voir votre ID et le nombre de joueurs connectés.',
  'Appuyer sur <kbd>F5</kbd> pour ouvrir votre menu personnel.',
]

var rphotkeys = [
  'Appuyer sur <kbd>X</kbd> pour annuler une animation.',
  'Appuyer sur <kbd>F3</kbd> pour sortir votre télephone.',
  'Appuyer sur <kbd>G</kbd> pour croiser vos bras.',
  'Appuyer sur <kbd>LEFT CTRL</kbd> pour vous accroupir.',
  'Appuyer sur <kbd>B</kbd> pour pointer du doigt.',
]

var vehiclehotkeys = [
  'Appuyer sur <kbd>U</kbd> pour (dé)verouiller votre véhicule.',
  'Appuyer sur <kbd>K</kbd> pour mettre votre ceinture.',
  'Appuyer sur <kbd>Q</kbd> pour mettre vos gyrophares. (EMS & Police)',
  'Appuyer sur <kbd>,</kbd> pour mettre vos sirenes. (EMS & Police)',
  'Appuyer sur <kbd>R</kbd> pour changer la tonalité de vos sirenes. (EMS & Police)',
  'Appuyer sur <kbd>L</kbd> pour voir l\'inventaire de votre véhicule',
]

var jobshotkeys = [
  'Appuyer sur <kbd>F6</kbd> pour ouvrir votre menu MÉTIER.',
  'Appuyer sur <kbd>F9</kbd> pour ouvrir votre menu ORGANISATION.',
]