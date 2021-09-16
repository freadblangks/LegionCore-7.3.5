/*
 * Copyright (C) 2011-2021 Project SkyFire <https://www.projectskyfire.org/>
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2021 MaNGOS <https://www.getmangos.eu/>
 * Copyright (C) 2006-2014 ScriptDev2 <https://github.com/scriptdev2/scriptdev2/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
This placeholder for the instance is needed for dungeon finding to be able
to give credit after the boss defined in lastEncounterDungeon is killed.
Without it, the party doing random dungeon won't get satchel of spoils and
gets instead the deserter debuff.
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "ragefire_chasm.h"

#define MAX_ENCOUNTER 4

ObjectData const creatureData[] =
{
    {NPC_BOSS_ADAROGG,          DATA_ADAROGG},
    {NPC_BOSS_KORANTHAL,        DATA_KORANTHAL},
    {NPC_BOSS_GORDOTH,          DATA_GORDOTH},
    {NPC_BOSS_SLAGMAW,          DATA_SLAGMAW},
    {0,                         0}
};

class instance_ragefire_chasm : public InstanceMapScript
{
public:
    instance_ragefire_chasm() : InstanceMapScript("instance_ragefire_chasm", 389) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_ragefire_chasm_InstanceMapScript(map);
    }

    struct instance_ragefire_chasm_InstanceMapScript : public InstanceScript
    {
        instance_ragefire_chasm_InstanceMapScript(Map* map) : InstanceScript(map) 
        {
            SetBossNumber(MAX_ENCOUNTER);

            uiAdaroggGUID.Clear();
            uiKoranthalGUID.Clear();
            uiGordothGUID.Clear();
            uiSlagmawGUID.Clear();

            TeamInInstance = 0;
        }

        void OnPlayerEnter(Player* player)
        {
            if (!TeamInInstance)
                TeamInInstance = player->GetTeam();
        }

        void Initialize()
        {

        }

        void OnCreatureCreate(Creature* pCreature)
        {
            if (!TeamInInstance)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.isEmpty())
                    if (Player* player = players.begin()->getSource())
                        TeamInInstance = player->GetTeam();
            }
            switch (pCreature->GetEntry())
            {
            case NPC_BOSS_ADAROGG:
                uiAdaroggGUID = pCreature->GetGUID();
                break;
            case NPC_BOSS_KORANTHAL:
                uiKoranthalGUID = pCreature->GetGUID();
                break;
            case NPC_BOSS_GORDOTH:
                uiGordothGUID = pCreature->GetGUID();
                break;
            case NPC_BOSS_SLAGMAW:
                uiSlagmawGUID = pCreature->GetGUID();
                break;
                //case NPC_HORDE SPECIFIC MOBS on alliance team
                //setphasemask to 2
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {

        }

        uint32 GetData(uint32 type) const override
        {
            if (type = DATA_TEAM_IN_INSTANCE)
                return TeamInInstance;
            return 0;
        }

        ObjectGuid GetGuidData(uint32 data) const
        {
            switch (data)
            {
            case DATA_ADAROGG:
                return uiAdaroggGUID;
            case DATA_KORANTHAL:
                return uiKoranthalGUID;
            case DATA_GORDOTH:
                return uiGordothGUID;
            case DATA_SLAGMAW:
                return uiSlagmawGUID;
            }
            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state)
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
            case DATA_ADAROGG:
                if (state == IN_PROGRESS)
                {

                }
                else if (state == DONE)
                {

                }
                break;
            }
            return true;
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'R' && dataHead2 == 'C')
            {

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }
            }
            else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {

            }
        }
        
        virtual void Update(uint32 diff)
        {
            
        }
    private:
        uint32 TeamInInstance;

        ObjectGuid uiAdaroggGUID;
        ObjectGuid uiKoranthalGUID;
        ObjectGuid uiGordothGUID;
        ObjectGuid uiSlagmawGUID;
    };
};

void AddSC_instance_ragefire_chasm()
{
    new instance_ragefire_chasm();
}