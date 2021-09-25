/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_depths.h"

enum Spells
{
    SPELL_HEAL                                             = 15586,
    SPELL_RENEW                                            = 8362,
    SPELL_MINDBLAST                                        = 15587,
};

enum Events
{
    EVENT_HEAL = 1,
    EVENT_RENEW,
    EVENT_MINDBLAST,
};

class boss_moira_bronzebeard : public CreatureScript
{
public:
    boss_moira_bronzebeard() : CreatureScript("boss_moira_bronzebeard") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_moira_bronzebeardAI (creature);
    }

    struct boss_moira_bronzebeardAI : public BossAI
    {
        boss_moira_bronzebeardAI(Creature* creature) : BossAI(creature, DATA_MOIRA) {}

        void Reset()
        {
            _Reset();
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/) 
        {
            events.ScheduleEvent(EVENT_MINDBLAST, 16000); // Probably incorrect timing. Winged it
            events.ScheduleEvent(EVENT_HEAL, 12000);
            events.ScheduleEvent(EVENT_RENEW, 18000);
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;


            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_MINDBLAST:
                    DoCast(me->getVictim(), SPELL_MINDBLAST);
                    events.ScheduleEvent(EVENT_MINDBLAST, 14000);
                    //TC_LOG_ERROR(LOG_FILTER_TSCR, "moira EVENT_MINDBLAST");
                    break;
                case EVENT_HEAL:
                    if (Creature* dagran = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EMPEROR)))
                    {
                        DoCast(dagran, SPELL_HEAL);
                        events.ScheduleEvent(EVENT_HEAL, 12000);
                    }
                    //TC_LOG_ERROR(LOG_FILTER_TSCR, "moira EVENT_HEAL");
                    break;
                case EVENT_RENEW:
                    if (Creature* dagran = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EMPEROR)))
                    {
                        DoCast(dagran, SPELL_RENEW);
                        events.ScheduleEvent(EVENT_RENEW, 18000);
                    }
                    //TC_LOG_ERROR(LOG_FILTER_TSCR, "moira EVENT_RENEW");
                    break;
                }
            }
        }
    };
};

void AddSC_boss_moira_bronzebeard()
{
    new boss_moira_bronzebeard();
}
