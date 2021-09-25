#ifndef DEF_DEADMINES_H
#define DEF_DEADMINES_H

#define DMScriptName "instance_deadmines"

enum CannonState
{
    CANNON_NOT_USED,
    CANNON_BLAST_INITIATED,
    PIRATES_ATTACK,
    EVENT_DONE
};

enum NPCs
{
    NPC_HELIX_GEARBREAKER    = 47296,
    NPC_LUMBERING_OAF        = 47297,
    NPC_MINE_RAT             = 51462,
    NPC_FOE_REAPER_5000      = 43778,
    NPC_STICKY_BOMB          = 47314,
    NPC_ADMIRAL_RIPSNARL     = 47626,
    NPC_CAPTAIN_COOKIE       = 47739,
    NPC_VANESSA_VANCLEEF     = 49541,
    NPC_VANESSA_SITTING      = 49429,
    NPC_NOTE_FROM_VANESSA    = 49564,
    NPC_HELIX_CREW           = 49139,

    //glubtok
    NPC_GLUBTOK                     = 47162,
    NPC_GENERAL_PURPOSE_DUMMY_JMF   = 45979,
    NPC_GLUBTOK_FIREWALL_PLATTER    = 48974,
    NPC_FIREWALL_PLATTER_1A         = 48975,
    NPC_FIREWALL_PLATTER_1B         = 49039,
    NPC_FIREWALL_PLATTER_1C         = 49040,
    NPC_FIREWALL_PLATTER_2A         = 48976,
    NPC_FIREWALL_PLATTER_2B         = 49041,
    NPC_FIREWALL_PLATTER_2C         = 49042,
    NPC_GENERAL_PURPOSE_BUNNY_L2    = 47242,
    NPC_FIRE_BLOSSOM_BUNNY          = 47282,
    NPC_FROST_BLOSSOM_BUNNY         = 47284,

    // horde npc
    NPC_KAGTHA               = 46889,
    NPC_SLINKY_SHARPSHIV     = 46906,
    NPC_MISS_MAYHEM          = 46902,
    NPC_MAYHEM_REAPER        = 46903,
    NPC_HAND_ASSASIN         = 46890,
    // alliance npc
    NPC_HORATIO_LAINE        = 46612,
    NPC_INVESTIGATOR         = 46614,
    NPC_DEFENDER             = 50595,
    NPC_CRIME_SCENE_BOT      = 46613
};

enum Data
{
    DATA_GLUBTOK          = 0,
    DATA_HELIX            = 1,
    DATA_FOEREAPER        = 2,
    DATA_ADMIRAL          = 3,
    DATA_CAPTAIN          = 4,
    DATA_VANESSA          = 5,
    DATA_CANNON_EVENT     = 6,
    DATA_OAF              = 7,
    DATA_VANESSA_EVENT    = 8,
    DATA_TEAM_IN_INSTANCE = 9,
    DATA_CURRENT_BLOSSOM = 10
};

enum GameObjects
{
    GO_FOUNDRY_DOOR      = 16399,
    GO_FACTORY_DOOR      = 13965,
    GO_MAST_ROOM_DOOR    = 16400,
    GO_IRONCLAD_DOOR     = 16397,
    GO_DEFIAS_CANNON     = 16398,
    GO_DOOR_LEVER        = 101833,
    GO_HEAVY_DOOR        = 17153,
    GO_HEAVY_DOOR_2      = 17154,
    GO_GOBLIN_TELEPORTER = 208002
};

enum Sounds
{
    SOUND_CANNONFIRE  = 1400,
    SOUND_DESTROYDOOR = 3079
};

const Position centershipPos[1] = { {-63.167f, -819.315f, 41.27f, 6.25f} };
const Position notePos[1] = {{-74.3611f, -820.014f, 40.3714f, 4.01426f}};
const Position vanessaPos[1] = { {-75.5851f, -819.964f, 47.0673f, 6.17846f} };
#endif