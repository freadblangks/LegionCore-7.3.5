#include "ScriptMgr.h"
#include "deadmines.h"
#include "InstanceScript.h"
#include "MotionMaster.h"
#include "MovementTypedefs.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellMgr.h"
#include "GridNotifiers.h"
#include "Map.h"

/*
Script ported from https://github.com/The-Cataclysm-Preservation-Project/TrinityCore/blob/master/src/server/scripts/EasternKingdoms/Deadmines/boss_helix_gearbreaker.cpp
Had to do major reworking as logic used there doesnt apply the same way in this core

TODO:
HEROIC:: Helix chest bomb should be applied after jumping on a player during oaf phase
HEROIC:: Helix crew should work UNTESTED
When helix has jumped on a player he faces the wrong way, I threw a bunch of face victim functions in
    but helix only faces the victim after the second tick of facetargetting 
Helix does not maintain aggro on the currently rode player and instead will target whoever has the most threat

Oaf knockback from the charge is not accurate at all, needs to be adjusted

TC_LOG_ERROR(LOG_FILTER_TSCR, "USED FOR DEBUGGING");
*/

enum ScriptTexts
{
    SAY_DEATH = 0,
    SAY_KILL = 1,
    SAY_OAF_DEAD = 2,
    SAY_STICKY_BOMB = 3,
    SAY_AGGRO = 5,
    SAY_THROW_HELIX = 4,

    SAY_OAF_SMASH_1 = 0,
    SAY_OAF_SMASH_2 = 1,
};

enum Spells
{
    //Helix
    SPELL_CHEST_BOMB                    = 88352, 
    SPELL_CHEST_BOMB_DMG                = 88250,
    SPELL_OAFGUARD                      = 90546,
    SPELL_ACHIEV_CREDIT                 = 88337,

    //Helix Ride
    SPELL_RIDE_FACE_TARGETING           = 88349,
    SPELL_RIDE_VEHICLE                  = 88360, // Helix rides player
    SPELL_HELIX_RIDE_FACE_TIMER_AURA    = 88351,
    SPELL_HELIX_RIDE                    = 88337, // Helix applies vehicleID aura to player
    SPELL_HELIX_CHEST_BOMB_EMOTE        = 91572,
    SPELL_EMOTE_TALK                    = 79506,
    SPELL_VEHICLE_SWITCH_TO_SEAT_3      = 84225,// Helix switches to oaf arm
    SPELL_RIDE_VEHICLE_OAF              = 46598,//52391, // Helix rides oaf
    SPELL_FORCECAST_EJECT_PASSENGER_1   = 88353,

    //Bomb
    SPELL_ARMED_STATE                   = 88319,
    SPELL_PERIODIC_TRIGGER              = 88329,
    SPELL_EXPLODE                       = 88974,
    SPELL_EXPLODE_H                     = 91566,
    SPELL_ARMING_VISUAL_YELLOW          = 88315,
    SPELL_ARMING_VISUAL_ORANGE          = 88316,
    SPELL_ARMING_VISUAL_RED             = 88317,
    SPELL_THROW_BOMB_TARGETING          = 88268,

    //Oaf
    SPELL_OAF_SMASH                     = 88300,
    SPELL_OAF_SMASH_H                   = 91568,
    SPELL_CHARGE                        = 88288,
    SPELL_OAF_GRAB_TARGETING            = 88289,
    SPELL_FORCE_PLAYER_RIDE_OAF         = 88278,
    SPELL_HOLD_THROWN                   = 88373,
    SPELL_ATTACK_THROWN                 = 88374,
    SPELL_RIDE_OAF                      = 88277, // Player rides oaf
};

uint32 const BombArmingVisualSpells[] =
{
    SPELL_ARMING_VISUAL_YELLOW,
    SPELL_ARMING_VISUAL_ORANGE,
    SPELL_ARMING_VISUAL_RED
};

enum Events
{
    //Helix n Crew
    EVENT_THROW_HELIX           = 1,
    EVENT_STICKY_BOMB,
    EVENT_HELIX_CREW,
    EVENT_CHEST_BOMB,
    EVENT_HELIX_RIDE,
    EVENT_RIDE_FACE,
    EVENT_REMOUNT_OAF,

    //Oaf
    EVENT_PREPARE_OAF_SMASH,
    EVENT_OAF_SMASH,
    EVENT_OAF_SMASH_CHARGE,
    EVENT_CHARGE_EXPLOSION,
    EVENT_PREP_THROW,

    //Sticky Bomb
    EVENT_BOMB_READY,
    EVENT_BOMB_EXPLODE,
    EVENT_BOMB_ARM,
    EVENT_BOMB_PERIODIC_TRIGGER,
    EVENT_BOMB_EXPLOSION_COUNTDOWN,
};

enum Points
{
    POINT_START = 1,
    POINT_END   = 2,
    POINT_CHARGE_PREP,
};

enum Actions
{
    ACTION_TALK_CREW = 1,
    ACTION_OAF_SMASH,

};

enum Phases
{
    PHASE_1 = 0,
    PHASE_2,
};

const Position lumberingoafPos[3] = 
{
    {-301.93f, -516.32f, 51.71f, 2.03f},
    {-289.98f, -528.06f, 49.75f, 1.59f},
    {-289.67f, -488.46f, 49.80f, 1.54f} 
};

const Position helixcrewPos[4] = 
{
    {-295.26f,-503.38f,60.16f, 0.0f},
    {-280.85f,-503.98f,60.16f, 0.0f},
    {-291.45f,-503.37f,60.16f, 0.0f},
    {-285.63f,-504.04f,60.16f, 0.0f}
};

const Position RatPos[8] = 
{
    {-290.90f, -486.49f, 49.88f},
    {-288.98f, -483.20f, 49.88f},
    {-293.78f, -483.81f, 49.15f},
    {-286.94f, -482.96f, 49.88f},
    {-288.16f, -484.81f, 49.88f},
    {-291.99f, -486.26f, 49.88f},
    {-289.67f, -487.22f, 49.88f},
    {-290.44f, -484.32f, 49.88f}
};

class boss_helix_gearbreaker : public CreatureScript
{
    public:
        boss_helix_gearbreaker() : CreatureScript("boss_helix_gearbreaker") {}

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_helix_gearbreakerAI (pCreature);
        }

        struct boss_helix_gearbreakerAI : public BossAI
        {
            boss_helix_gearbreakerAI(Creature* c) : BossAI(c, DATA_HELIX), firstStickyBomb(false){  }

            bool firstStickyBomb;

            void Reset() override
            {
                _Reset();
                me->ExitVehicle();
                me->SetReactState(REACT_AGGRESSIVE);
                DoCast(me, SPELL_OAFGUARD);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_RIDE_VEHICLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                summons.DespawnAll();
                SummonOaf();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 2);
                Talk(SAY_AGGRO);
                instance->SetBossState(DATA_HELIX, IN_PROGRESS);
                DoCastToAllHostilePlayers(SPELL_HELIX_RIDE, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE);
                events.SetPhase(PHASE_1);
                events.ScheduleEvent(EVENT_HELIX_RIDE, 1000);
                events.ScheduleEvent(EVENT_STICKY_BOMB, 6000, 0, PHASE_1);
                events.ScheduleEvent(EVENT_OAF_SMASH, 17000, 0, PHASE_1);
                events.ScheduleEvent(EVENT_PREP_THROW, 34000, 0, PHASE_1);
                events.ScheduleEvent(EVENT_HELIX_RIDE, 56000);
                if (IsHeroic())
                {
                    events.RescheduleEvent(EVENT_CHEST_BOMB, urand(8000, 12000));
                    events.RescheduleEvent(EVENT_HELIX_CREW, 5000);
                }
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
                Talk(SAY_DEATH);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_RIDE_VEHICLE);
                DoCastAOE(SPELL_FORCECAST_EJECT_PASSENGER_1, true);
                summons.DespawnAll();
            }

            void EnterEvadeMode() override
            {
                me->ExitVehicle();
                BossAI::EnterEvadeMode();
                me->SetReactState(REACT_AGGRESSIVE);
                DoCast(me, SPELL_OAFGUARD);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_RIDE_VEHICLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                summons.DespawnAll();
                SummonOaf();
            }

            void SummonOaf()
            {
                Creature* oaf = me->GetVehicleCreatureBase();
                if (!oaf)
                {
                    oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 30.0f);
                    if (oaf && oaf->isAlive())
                    {
                        me->CastSpell(oaf, SPELL_RIDE_VEHICLE_OAF);
                    }
                    else
                    {
                        oaf = me->SummonCreature(NPC_LUMBERING_OAF, me->GetHomePosition());

                        if (oaf && oaf->isAlive())
                        {
                            me->CastSpell(oaf, SPELL_RIDE_VEHICLE_OAF);
                        }
                    }
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
            {
                switch (summon->GetEntry())
                {
                case NPC_LUMBERING_OAF:
                    Talk(SAY_OAF_DEAD);
                    me->RemoveAurasDueToSpell(SPELL_OAFGUARD);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    events.SetPhase(PHASE_2);
                    if (IsHeroic()) {
                        events.ScheduleEvent(EVENT_HELIX_CREW, 3000, 0, PHASE_2);
                    }
                    events.ScheduleEvent(EVENT_RIDE_FACE, 2000, 0, PHASE_2);
                    events.ScheduleEvent(EVENT_STICKY_BOMB, 2000, 0, PHASE_2);
                    break;
                default:
                    break;
                }
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /**/)
            {
                if (damage >= me->GetHealth() && me->HasAura(SPELL_OAFGUARD))
                    damage = me->GetHealth() - 1;
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell) override
            {
                if (spell->Id == SPELL_RIDE_VEHICLE) {
                    me->ClearUnitState(UNIT_STATE_ONVEHICLE);
                    AttackStart(target);
                }
            }

            void KilledUnit(Unit* /*victim*/) override
            {
                Talk(SAY_KILL);
            }

            void UpdateAI(uint32 diff) override
            {

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
                if (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                    case EVENT_HELIX_CREW:
                        for (uint8 i = 0; i < 4; i++)
                        {
                            if (events.IsInPhase(PHASE_1))
                            {
                                if (auto crew = me->SummonCreature(NPC_HELIX_CREW, helixcrewPos[i], TEMPSUMMON_CORPSE_DESPAWN)) {
                                    if (!i && crew->IsAIEnabled)
                                        crew->AI()->DoAction(ACTION_TALK_CREW);
                                }
                            }
                            else
                            {
                                me->SummonCreature(NPC_HELIX_CREW, helixcrewPos[i], TEMPSUMMON_CORPSE_DESPAWN);
                            }
                        }
                        break;

                    case EVENT_HELIX_RIDE:
                        DoCastToAllHostilePlayers(SPELL_HELIX_RIDE, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE);
                        events.ScheduleEvent(EVENT_STICKY_BOMB, 8000);
                        events.ScheduleEvent(EVENT_HELIX_RIDE, 56000);
                        break;

                    case EVENT_STICKY_BOMB:
                        me->CastSpell(me->getVictim(), SPELL_THROW_BOMB_TARGETING, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE);
                        if (!firstStickyBomb) {
                            Talk(SAY_STICKY_BOMB);
                            firstStickyBomb = true;
                        }
                        summons.DoZoneInCombat();
                        events.ScheduleEvent(EVENT_STICKY_BOMB, 5000);
                        break;

                    case EVENT_OAF_SMASH:
                        if (auto oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 1000.0f))
                        {
                            if (oaf->ToUnit()->isAlive() && oaf == me->GetVehicleCreatureBase())
                            {
                                if (oaf->IsAIEnabled) {
                                    oaf->AI()->DoAction(ACTION_OAF_SMASH);
                                }
                            }
                        }
                        events.RescheduleEvent(EVENT_STICKY_BOMB, 11000, 0, PHASE_1);
                        events.ScheduleEvent(EVENT_OAF_SMASH, 52000);
                        break;

                    case EVENT_PREP_THROW:
                        if (auto oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 1000.0f))
                        {
                            if (oaf->ToUnit()->isAlive() && oaf == me->GetVehicleCreatureBase())
                            {
                                Talk(SAY_THROW_HELIX);
                                DoCast(me, SPELL_VEHICLE_SWITCH_TO_SEAT_3);
                                oaf->CastSpell(oaf, SPELL_HOLD_THROWN, true);
                                events.ScheduleEvent(EVENT_THROW_HELIX, 1000, 0, PHASE_1);
                                events.RescheduleEvent(EVENT_STICKY_BOMB, 22000, 0, PHASE_1);
                            }
                        }
                        break;

                    case EVENT_THROW_HELIX:
                        if (auto oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 1000.0f))
                        {
                            if (oaf->ToUnit()->isAlive() && oaf == me->GetVehicleCreatureBase())
                            {
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                oaf->RemoveAura(SPELL_HOLD_THROWN, oaf->GetGUID());
                                oaf->CastSpell(me, SPELL_ATTACK_THROWN, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE | TRIGGERED_IGNORE_CASTER_AURASTATE);
                                me->SetFacingTo(me->getVictim());
                                events.ScheduleEvent(EVENT_RIDE_FACE, 500, 0, PHASE_1);
                                events.RescheduleEvent(EVENT_STICKY_BOMB, 2000);
                            }
                        }
                        break;

                    case EVENT_RIDE_FACE:
                        me->ExitVehicle();
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        DoCastToAllHostilePlayers(SPELL_HELIX_RIDE, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE);
                        DoCast(me->getVictim(), SPELL_RIDE_FACE_TARGETING, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE | TRIGGERED_IGNORE_CASTER_AURASTATE);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->SetFacingTo(me->getVictim());

                        if (auto oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 1000.0f))
                        {
                            if (oaf->ToUnit()->isAlive() && oaf != me->GetVehicleCreatureBase())
                            {
                                me->ExitVehicle();
                                events.ScheduleEvent(EVENT_REMOUNT_OAF, 10000);
                            }
                        }
                        else
                        {

                            DoCastToAllHostilePlayers(SPELL_HELIX_RIDE, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE | TRIGGERED_IGNORE_CASTER_AURASTATE);
                            events.RepeatEvent(50000);
                            events.ScheduleEvent(EVENT_STICKY_BOMB, 2000);
                        }
                        break;


                    case EVENT_REMOUNT_OAF:
                        me->SetFacingTo(me->getVictim());

                        if (auto oaf = me->FindNearestCreature(NPC_LUMBERING_OAF, 1000.0f)) {
                            if (oaf->ToUnit()->isAlive() && oaf != me->GetVehicleCreatureBase())
                            {
                                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                me->RemoveAurasDueToSpell(SPELL_HELIX_RIDE_FACE_TIMER_AURA);
                                me->ExitVehicle();
                                me->EnterVehicle(oaf);
                                events.ScheduleEvent(EVENT_PREP_THROW, 52000);
                            }
                        }
                        break;
                    case EVENT_CHEST_BOMB:
                        if (auto target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        {
                            DoCast(target, SPELL_CHEST_BOMB);
                        }
                        events.RescheduleEvent(EVENT_CHEST_BOMB, urand(15000, 20000));
                        break;
                    default:
                        break;
                    }
                }
                if (!me->GetVehicleCreatureBase() || me->GetVehicleBase()->GetTypeId() == TYPEID_PLAYER)
                    DoMeleeAttackIfReady();
            }
        };
};



class npc_helix_sticky_bomb : public CreatureScript
{
public:
        npc_helix_sticky_bomb() : CreatureScript("npc_helix_sticky_bomb") {}
     
        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_sticky_bombAI (pCreature);
        }
     
        struct npc_sticky_bombAI : public NullCreatureAI
        {
            npc_sticky_bombAI(Creature* c) : NullCreatureAI(c), countdown(0)
            {
                instance = c->GetInstanceScript();
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            }
           
            InstanceScript* instance;
            EventMap events;
            uint8 countdown;

            void Reset() override
            {
                events.Reset();
                events.RescheduleEvent(EVENT_BOMB_ARM, 2000);
            }

            void EnterCombat(Unit* /*who*/) override
            {
                events.RescheduleEvent(EVENT_BOMB_ARM, 2000);
            }

            void JustDied(Unit* /*killer*/) override
            {
                me->DespawnOrUnsummon();
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                {
                    return;
                }
                events.Update(diff);

                if (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_BOMB_ARM:
                            if (countdown < 3)
                            {
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                me->CastSpell(me, BombArmingVisualSpells[countdown]);
                                events.ScheduleEvent(EVENT_BOMB_ARM, 1000);
                                countdown++;

                            }
                            else if (countdown >= 3)
                            {
                                DoCast(me, SPELL_ARMED_STATE);
                                events.ScheduleEvent(EVENT_BOMB_PERIODIC_TRIGGER, 1000);
                            }
                            break;
                        case EVENT_BOMB_PERIODIC_TRIGGER:
                            DoCast(me, SPELL_PERIODIC_TRIGGER, true);
                            events.ScheduleEvent(EVENT_BOMB_EXPLOSION_COUNTDOWN, 9000);
                            break;
                        case EVENT_BOMB_EXPLOSION_COUNTDOWN:
                            if (countdown >= 2)
                            {
                                DoCast(me, SPELL_ARMING_VISUAL_RED);
                                events.ScheduleEvent(EVENT_BOMB_EXPLOSION_COUNTDOWN, 1000);
                                countdown--;
                            }
                            else
                            {
                                DoCast(me, SPELL_EXPLODE);
                                events.ScheduleEvent(EVENT_BOMB_EXPLODE, 100);
                            }
                            break;
                        case EVENT_BOMB_EXPLODE:
                            me->DespawnOrUnsummon(400);
                            events.Reset();
                            break;
                    }
                }
            }
        };    
};

class npc_helix_lumbering_oaf : public CreatureScript
{
public:
    npc_helix_lumbering_oaf() : CreatureScript("npc_helix_lumbering_oaf") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_lumbering_oafAI(pCreature);
    }

    struct npc_lumbering_oafAI : public ScriptedAI
    {
        npc_lumbering_oafAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            instance = c->GetInstanceScript();
            me->setActive(true);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        InstanceScript* instance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            summons.DespawnAll();
            events.Reset();
            me->RemoveAurasDueToSpell(SPELL_RIDE_OAF);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void DoAction(const int32 action) override
        {
            switch (action)
            {
            case ACTION_OAF_SMASH:
                DoCast(me->getVictim(),SPELL_OAF_GRAB_TARGETING);
                break;
            default:
                break;
            }

        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
                return;

            switch (id)
            {
            case POINT_CHARGE_PREP:
                me->SetFacingTo(1.570796f);
                events.ScheduleEvent(EVENT_OAF_SMASH_CHARGE, 1000);
                break;
            default:
                break;
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 1);

            if (Creature* helix = instance->GetCreatureByEntry(NPC_HELIX_GEARBREAKER))
                if (helix->IsAIEnabled)
                    helix->AI()->DoZoneInCombat();
        }

        void EnterEvadeMode() override
        {
            summons.DespawnAll();
            me->DespawnOrUnsummon();
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType dmgType) override
        {
            if (me->GetHealth() <= damage)
                DoCastAOE(SPELL_FORCECAST_EJECT_PASSENGER_1, true);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->RemoveAurasDueToSpell(SPELL_RIDE_OAF);

            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->GetMotionMaster()->MoveRandom(10.0f);
        }

        void PassengerBoarded(Unit* passenger, int8 seatId, bool apply) override
        {
            if (!passenger)
                return;

            if (apply && passenger->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_OAF_SMASH_1);
                me->AttackStop();
                events.ScheduleEvent(EVENT_PREPARE_OAF_SMASH, 1000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_PREPARE_OAF_SMASH:
                    Talk(SAY_OAF_SMASH_2);
                    me->GetMotionMaster()->MovePoint(POINT_CHARGE_PREP, lumberingoafPos[1]);
                    break;

                case EVENT_OAF_SMASH_CHARGE:
                    me->GetMotionMaster()->MoveCharge(
                        lumberingoafPos[2].GetPositionX(),
                        lumberingoafPos[2].GetPositionY(),
                        lumberingoafPos[2].GetPositionZ(),
                        42.0f, POINT_END);
                    DoCastAOE(SPELL_CHARGE);
                    events.ScheduleEvent(EVENT_CHARGE_EXPLOSION, 1500);
                    break;

                case EVENT_CHARGE_EXPLOSION:
                    DoCast(SPELL_OAF_SMASH);
                    if (auto target = me->getVictim())
                    {
                        target->KnockbackFrom(15, -10, 10, 10);

                    }
                    if (me->getVictim())
                        me->GetMotionMaster()->MoveChase(me->getVictim());

                    me->RemoveAurasDueToSpell(SPELL_RIDE_OAF);
                    instance->DoCastSpellOnPlayers(SPELL_ACHIEV_CREDIT);
                    for (uint8 i = 0; i < 7; i++)
                        me->SummonCreature(NPC_MINE_RAT, RatPos[i], TEMPSUMMON_CORPSE_DESPAWN, 5000);
                    break;

                default:
                    break;

                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_helix_crew : public CreatureScript
{
    public:
        npc_helix_crew() : CreatureScript("npc_helix_crew") {}
     
        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_helix_crewAI (pCreature);
        }
     
        struct npc_helix_crewAI : public Scripted_NoMovementAI
        {
            npc_helix_crewAI(Creature *c) : Scripted_NoMovementAI(c), summons(me) 
            {
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, true);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, true);
                instance = c->GetInstanceScript();
            }

            InstanceScript* instance;
            EventMap events;
            SummonList summons;

            void Reset() override
            {
                if (!instance)
                    return;
                
                summons.DespawnAll();
                SetCombatMovement(false);
            }
            
            void EnterCombat(Unit* /*who*/) override
            {
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_STICKY_BOMB, 8000);
            }

            void JustSummoned(Creature* summon) override
            {
                if (!instance)
                    return;
                if (summon->GetEntry() == NPC_STICKY_BOMB)
                {
                    summon->SetAI(new npc_helix_sticky_bomb::npc_sticky_bombAI(summon));
                    summon->SetTarget(me->GetTargetGUID());
                    summon->AI()->DoZoneInCombat();
                }
                DoZoneInCombat();
            }

            void SummonedCreatureDespawn(Creature* summon) override
            {
                if (!instance)
                    return;

                summons.Despawn(summon);
            }

            void JustDied(Unit* /*killer*/) override
            {
                if (!instance)
                    return;

                summons.DespawnAll();
                me->DespawnOrUnsummon();
            }

            void UpdateAI(uint32 diff) override
            {
                if (!instance)
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                    case EVENT_STICKY_BOMB:
                        DoCast(SPELL_THROW_BOMB_TARGETING);
                        events.ScheduleEvent(EVENT_STICKY_BOMB, 8000);
                        break;
                    }
                }
                  
            }
        };
};

class spell_helix_throw_bomb_targeting : public SpellScriptLoader
{
public:
    spell_helix_throw_bomb_targeting() : SpellScriptLoader("spell_helix_throw_bomb_targeting") {}

    class spell_helix_throw_bomb_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_helix_throw_bomb_targeting_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            Trinity::Containers::RandomResizeList(targets, 1);
        }

        void HandleHit(SpellEffIndex effIndex)
        {
            if (Unit* caster = GetCaster())
            {
                caster->CastSpell(GetHitUnit(), GetSpellInfo()->Effects[effIndex]->BasePoints, true);

            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_helix_throw_bomb_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_helix_throw_bomb_targeting_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_helix_throw_bomb_targeting_SpellScript();
    }
};

class spell_helix_sticky_bomb_periodic_trigger : public SpellScriptLoader
{
public:
    spell_helix_sticky_bomb_periodic_trigger() : SpellScriptLoader("spell_helix_sticky_bomb_periodic_trigger") {}

    class spell_helix_sticky_bomb_periodic_trigger_AuraScript : public AuraScript
    {

        PrepareAuraScript(spell_helix_sticky_bomb_periodic_trigger_AuraScript);

        void HandleTick(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            Creature* target = GetTarget()->ToCreature();
            if (!target || !target->IsAIEnabled)
                return;

            SpellInfo const* spell = sSpellMgr->GetSpellInfo(GetSpellInfo()->Effects[EFFECT_0]->TriggerSpell);
            if (!spell)
                return;

            if (Player* player = target->SelectNearestPlayer(spell->Effects[EFFECT_0]->CalcRadius()))
            {
                if (!player->GetVehicleBase() && player->GetExactDist(target) <= 1.0f)
                {
                    target->CastSpell(target, spell->Id, true);
                }
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_helix_sticky_bomb_periodic_trigger_AuraScript::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };
    AuraScript* GetAuraScript() const
    {
        return new spell_helix_sticky_bomb_periodic_trigger_AuraScript();
    }
};

class spell_helix_chest_bomb : public SpellScriptLoader
{
    public:
        spell_helix_chest_bomb() : SpellScriptLoader("spell_helix_chest_bomb") {}


        class spell_helix_chest_bomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_helix_chest_bomb_AuraScript);

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (auto target = aurEff->GetBase()->GetUnitOwner())
                    target->CastSpell(target, SPELL_CHEST_BOMB_DMG, true);
            }

            void Register() override
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_helix_chest_bomb_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
             }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_helix_chest_bomb_AuraScript();
        }
};

class spell_helix_oaf_grab_targeting : public SpellScriptLoader
{
public:
    spell_helix_oaf_grab_targeting() : SpellScriptLoader("spell_helix_oaf_grab_targeting") {}

    class spell_helix_oaf_grab_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_helix_oaf_grab_targeting_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            Trinity::Containers::RandomResizeList(targets, 1);
        }

        void HandleHit(SpellEffIndex effIndex)
        {
            if (Unit* caster = GetCaster())
                caster->CastSpell(GetHitUnit(), GetSpellInfo()->Effects[effIndex]->BasePoints, true); // Casts 88288 charge on selected player
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_helix_oaf_grab_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_helix_oaf_grab_targeting_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_helix_oaf_grab_targeting_SpellScript();
    }
};

class spell_helix_force_player_to_ride_oaf : public SpellScriptLoader
{
    public:
        spell_helix_force_player_to_ride_oaf() : SpellScriptLoader("spell_helix_force_player_to_ride_oaf") {}


        class spell_helix_force_player_to_ride_oaf_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_helix_force_player_to_ride_oaf_SpellScript);


            void HandleScript(SpellEffIndex effIndex)
            {
                if (!GetCaster() || !GetHitUnit())
                    return;

                if (Unit* caster = GetCaster())
                {
                    GetHitUnit()->CastSpell(caster, GetSpellInfo()->Effects[effIndex]->BasePoints, true);
                    GetHitUnit()->ClearUnitState(UNIT_STATE_ONVEHICLE); // Vehicle flag removed from player otherwise fight ends if only 1 player and grabbed
                }
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_helix_force_player_to_ride_oaf_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_helix_force_player_to_ride_oaf_SpellScript();
        }
};

class spell_helix_oaf_smash : public SpellScriptLoader
{
public:
    spell_helix_oaf_smash() : SpellScriptLoader("spell_helix_oaf_smash") {}

    class spell_helix_oaf_smash_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_helix_oaf_smash_SpellScript);
        void HandleLaunch(SpellEffIndex effIndex)
        {
            // We do our own knockback here because the boss is immune to knockback effects
            // ... and because we have to use some additional spellinfo data
            if (Unit* caster = GetCaster())
            {
                float angle = caster->GetOrientation();
                float x = caster->GetPositionX() + cos(angle) * 1;
                float y = caster->GetPositionX() + sin(angle) * 1;
                float speedxy = float(GetSpellInfo()->Effects[effIndex]->MiscValue) * 0.1;
                float speedz = float(GetSpellInfo()->Effects[effIndex]->MiscValueB) * 0.1;
                caster->KnockbackFrom(x, y, speedxy, speedz);
                

                if (Creature* creature = caster->ToCreature())
                {
                    creature->SetReactState(REACT_AGGRESSIVE);
                    creature->setAttackTimer(BASE_ATTACK, creature->GetFloatValue(UNIT_FIELD_ATTACK_ROUND_BASE_TIME));
                }
            }
        }

        void Register()
        {
            OnEffectLaunch += SpellEffectFn(spell_helix_oaf_smash_SpellScript::HandleLaunch, EFFECT_0, SPELL_EFFECT_KNOCK_BACK);

        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_helix_oaf_smash_SpellScript();
    }
};

// SPELL FACE RIDING /////////////////////////////////////////////////////
class spell_helix_helix_ride : public SpellScriptLoader
{
public:
    spell_helix_helix_ride() : SpellScriptLoader("spell_helix_helix_ride") {}


    class spell_helix_helix_ride_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_helix_helix_ride_AuraScript);

        void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_PLAYER_VEHICLE);
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_helix_helix_ride_AuraScript::AfterApply, EFFECT_0, SPELL_AURA_SET_VEHICLE_ID, AURA_EFFECT_HANDLE_REAL);
        }
    };
    AuraScript* GetAuraScript() const
    {
        return new spell_helix_helix_ride_AuraScript();
    }
};

class spell_helix_ride_face_targeting : public SpellScriptLoader
{
public:
    spell_helix_ride_face_targeting() : SpellScriptLoader("spell_helix_ride_face_targeting") {}


    class spell_helix_ride_face_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_helix_ride_face_targeting_SpellScript);
        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo(
                {
                    SPELL_HELIX_RIDE,
                    SPELL_HELIX_RIDE_FACE_TIMER_AURA
                });
        }

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            targets.remove_if([](WorldObject const* obj)->bool
                {
                    Unit const* target = obj->ToUnit();
                    return !target || !target->HasAura(SPELL_HELIX_RIDE);
                });

            // Make sure that we will always leap to a different player if available
            if (targets.size() > 1)
            {
                targets.remove_if([](WorldObject const* obj)->bool
                    {
                        Unit const* target = obj->ToUnit();
                        return target->GetVehicleBase();
                    });
            }

            if (targets.empty())
                return;

            Trinity::Containers::RandomResizeList(targets, 1);
        }

        void HandleHit(SpellEffIndex effIndex)
        {
            Unit* caster = GetCaster();

            if (!caster)
                return;

            if (Unit* target = GetHitUnit())
            {
                caster->getThreatManager().resetAllAggro();
                caster->CastSpell(caster, SPELL_HELIX_RIDE_FACE_TIMER_AURA);
                caster->CastSpell(target, GetSpellInfo()->Effects[effIndex]->BasePoints, true); // Casts 88360, ride vehicle?
                caster->SetFacingTo(caster->getVictim());

            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_helix_ride_face_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_helix_ride_face_targeting_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_helix_ride_face_targeting_SpellScript();
    }
};

class spell_helix_helix_ride_face_timer_aura : public SpellScriptLoader
{
public:
    spell_helix_helix_ride_face_timer_aura() : SpellScriptLoader("spell_helix_helix_ride_face_timer_aura") {}


    class spell_helix_helix_ride_face_timer_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_helix_helix_ride_face_timer_aura_AuraScript);
        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo(
                {
                    SPELL_RIDE_VEHICLE_OAF,
                    SPELL_CHEST_BOMB,
                    SPELL_HELIX_CHEST_BOMB_EMOTE
                });
        }

        void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            InstanceScript* instance = target->GetInstanceScript();
            if (!instance)
                return;

            if (target->GetMap()->IsHeroic())
            {
                if (Unit* player = target->GetVehicleBase())
                {
                    target->CastSpell(player, SPELL_CHEST_BOMB);
                    target->CastSpell(player, SPELL_HELIX_CHEST_BOMB_EMOTE);
                }
            }

            Creature* oaf = instance->GetCreatureByEntry(NPC_LUMBERING_OAF);
            // Lumbering oaf is dead when the last face riding expires. Continue with phase two behaivior and leap straight up to the next player
            if (!oaf || oaf->isDead()) {
                target->CastSpell(target, SPELL_RIDE_FACE_TARGETING, true);
                target->SetFacingTo(target->getVictim());
            }
            else
                target->CastSpell(oaf, SPELL_RIDE_VEHICLE_OAF, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_helix_helix_ride_face_timer_aura_AuraScript::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };
    AuraScript* GetAuraScript() const
    {
        return new spell_helix_helix_ride_face_timer_aura_AuraScript();
    }
};

class spell_helix_chest_bomb_emote : public SpellScriptLoader
{
public:
    spell_helix_chest_bomb_emote() : SpellScriptLoader("spell_helix_chest_bomb_emote") {}


    class spell_helix_chest_bomb_emote_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_helix_chest_bomb_emote_SpellScript);
        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_helix_chest_bomb_emote_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_helix_chest_bomb_emote_SpellScript();
    }
};

class spell_helix_ride_vehicle : public SpellScriptLoader
{
public:
    spell_helix_ride_vehicle() : SpellScriptLoader("spell_helix_ride_vehicle") {}


    class spell_helix_ride_vehicle_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_helix_ride_vehicle_AuraScript);
        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster()) 
            {
                caster->ClearUnitState(UNIT_STATE_ONVEHICLE);
                caster->ClearUnitState(UNIT_STATE_CANNOT_TURN);
                caster->SetFacingTo(caster->getVictim());
            }
        }

        void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_PLAYER_VEHICLE);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_helix_ride_vehicle_AuraScript::OnApply, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_helix_ride_vehicle_AuraScript::AfterRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
        }
    };
    AuraScript* GetAuraScript() const
    {
        return new spell_helix_ride_vehicle_AuraScript();
    }
};



void AddSC_boss_helix_gearbreaker()
{
    new boss_helix_gearbreaker();
    new npc_helix_lumbering_oaf();
    new npc_helix_crew();
    new npc_helix_sticky_bomb();
    new spell_helix_throw_bomb_targeting();
    new spell_helix_sticky_bomb_periodic_trigger();
    new spell_helix_force_player_to_ride_oaf();
    new spell_helix_chest_bomb();
    new spell_helix_oaf_grab_targeting();
    new spell_helix_oaf_smash();
    new spell_helix_chest_bomb_emote();
    new spell_helix_helix_ride();
    new spell_helix_helix_ride_face_timer_aura();
    new spell_helix_ride_face_targeting();
    new spell_helix_ride_vehicle();
}