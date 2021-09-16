#include "deadmines.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "MoveSplineInit.h"
#include "Player.h"
#include "Vehicle.h"
#include "InstanceScript.h"
#include "ObjectAccessor.h"
#include "MotionMaster.h"

//todo: реализовать flame wall

enum ScriptTexts
{
    SAY_DEATH                   = 0,
    SAY_ARCANE_POWER            = 1,
    SAY_AGGRO                   = 2,
    SAY_KILL                    = 3,
    SAY_FISTS_OF_FLAME          = 4,
    SAY_PHASE_TWO_INTRO_1       = 5,
    SAY_FISTS_OF_FROST          = 6,
    SAY_PHASE_TWO_INTRO_2       = 7
};

enum Spells
{
    /*SPELL_ARCANE_POWER = 88009,
    SPELL_FIST_OF_FLAME     = 87859,
    SPELL_FIST_OF_FLAME_0   = 87896,
    SPELL_FIST_OF_FROST     = 87861,
    SPELL_FIST_OF_FROST_0   = 87901,
    SPELL_FIRE_BLOSSOM      = 88129,
    SPELL_FROST_BLOSSOM     = 88169,
    SPELL_FROST_BLOSSOM_0   = 88177,
    SPELL_BLINK             = 38932,*/

    // Glubtok
    SPELL_BLINK = 87925,
    SPELL_FISTS_OF_FROST = 87861,
    SPELL_FISTS_OF_FLAME = 87859,
    SPELL_TELEPORT = 88002,
    SPELL_EMOTE_TALK = 79506,
    SPELL_EMOTE_ROAR = 48350,
    SPELL_ARCANE_POWER = 88009,
    SPELL_ARCANE_FIRE_BEAM = 88072,
    SPELL_ARCANE_FROST_BEAM = 88093,
    SPELL_STUN_SELF = 88040,

    SPELL_BLOSSOM_TARGETING = 88140,
    SPELL_FROST_BLOSSOM = 88169,
    SPELL_FROST_BLOSSOM_VISUAL = 88165,
    SPELL_FROST_BLOSSOM_EFFECT = 88177,

    SPELL_FIRE_BLOSSOM = 88129,
    SPELL_FIRE_BLOSSOM_VISUAL = 88164,
    SPELL_FIRE_BLOSSOM_EFFECT = 88173,

    SPELL_ARCANE_OVERLOAD = 88183,
    SPELL_TRANSITION_INVISIBILITY = 90424,
    SPELL_ARCANE_OVERLOAD_INSTAKILL = 88185,

    // Fire Wall Platter
    SPELL_FIRE_WALL = 91398,

    // General Purpose Bunny JMF
    SPELL_ARCANE_OVERLOAD_EXPLOSION = 90520
};

enum Events
{
    /*EVENT_FIST_OF_FLAME = 1,
    EVENT_FIST_OF_FROST = 2,
    EVENT_BLINK         = 3,
    EVENT_BLOSSOM       = 4,
    EVENT_ARCANE_POWER1 = 5,
    EVENT_ARCANE_POWER2 = 6,
    EVENT_ARCANE_POWER3 = 7*/

    EVENT_BLINK = 1,
    EVENT_ELEMENTAL_FISTS,
    EVENT_PHASE_TWO_INTRO_1,
    EVENT_PHASE_TWO_INTRO_2,
    EVENT_ARCANE_POWER,
    EVENT_STUN_SELF,
    EVENT_ANNOUNCE_FIRE_WALL,
    EVENT_FIRE_WALL,
    EVENT_BLOSSOM_TARGETING,
    EVENT_KILL_SELF

};

enum Phases
{
    PHASE_1 = 1,
    PHASE_2 = 2,
};

enum Fists
{
    FISTS_OF_FLAME = 0,
    FISTS_OF_FROST = 1,
};

const Position arcanePowerPos[1] =
{
    {  -193.43f, -442.86f, 53.38f,4.88f  }
};

const Position leftSideDistanceCheck[1] = 
{ 
    {  -210.840f, -443.449f, 61.179f  }
};

const Position firewallPlatterSummonPos[1] = 
{ 
    { -193.4054f, -441.5011f, 54.57029f, 1.833041f } 
};

static constexpr uint32 const firewallPlatterCyclicPathSize = 9;

const Position firewallPlatterCyclicPath[firewallPlatterCyclicPathSize] =
{
    { -193.2778f, -442.0017f, 53.70924f },
    { -193.4514f, -441.0169f, 55.70924f },
    { -192.7042f, -441.1826f, 55.70924f },
    { -192.293f,  -441.8281f, 55.70924f },
    { -192.4586f, -442.5753f, 55.70924f },
    { -193.1041f, -442.9865f, 55.70924f },
    { -193.8514f, -442.8209f, 55.70924f },
    { -194.2626f, -442.1754f, 55.70924f },
    { -194.0969f, -441.4282f, 55.70924f }
};

enum Adds
{
    NPC_FIRE_BLOSSOM    = 48957,
    NPC_FROST_BLOSSOM   = 48958,
    NPC_FIREWALL_2A     = 48976,
    NPC_FIREWALL_1A     = 48975,
    NPC_FIREWALL_1B     = 49039,
    NPC_FIREWALL_2B     = 49041,
    NPC_FIREWALL_2C     = 49042
};

class boss_glubtok : public CreatureScript
{
    public:
        boss_glubtok() : CreatureScript("boss_glubtok") {}

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_glubtokAI (pCreature);
        }

        struct boss_glubtokAI : public BossAI
        {
            boss_glubtokAI(Creature* pCreature) : BossAI(pCreature, DATA_GLUBTOK),
                _defeated(false), _lastFists(FISTS_OF_FLAME), _nextBlossomBunny(NPC_FIRE_BLOSSOM_BUNNY)

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
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, true);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CONFUSE, true);
                me->setActive(true);
            }

            //uint8 stage; // junk phase setting

            bool _defeated;
            uint8 _lastFists;
            uint32 _nextBlossomBunny;
            GuidVector _firewallDummyGUIDs;

            void Reset() override
            {
                _Reset();
                me->SetCanDualWield(true);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void InitializeAI()
            {
                if (!instance || static_cast<InstanceMap*>(me->GetMap())->GetScriptId() != sObjectMgr->GetScriptId(DMScriptName))
                    me->IsAIEnabled = false;
                else if (!me->isDead())
                    Reset();
            }

            void EnterCombat(Unit* who) override
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
                instance->SetBossState(DATA_GLUBTOK, IN_PROGRESS);
                events.SetPhase(PHASE_1);

                events.ScheduleEvent(EVENT_BLINK, 16000, 0, PHASE_1);

                events.RescheduleEvent(EVENT_ELEMENTAL_FISTS, 6000);
                DoZoneInCombat();
            }

            void EnterEvadeMode() override
            {
                BossAI::EnterEvadeMode();
                summons.DespawnAll();
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                _DespawnAtEvade();
            }

            void KilledUnit(Unit* /*victim*/) override
            {
                Talk(SAY_KILL);
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                Talk(SAY_DEATH);
            }

            void JustSummoned(Creature* summon) override
            {
                switch (summon->GetEntry())
                {
                case NPC_FIREWALL_2A:
                case NPC_FIREWALL_2B:
                case NPC_FIREWALL_2C:
                    _firewallDummyGUIDs.push_back(summon->GetGUID());
                    break;
                default:
                    break;
                }
                summons.Summon(summon);
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /**/) override
            {
                if (me->HealthBelowPctDamaged(50, damage) && !events.IsInPhase(PHASE_2) && !_defeated)
                {
                    events.SetPhase(PHASE_2);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->InterruptNonMeleeSpells(true);
                    DoCast(me, SPELL_TELEPORT, true);
                    me->StopMoving();
                    me->NearTeleportTo(me->GetHomePosition());
                    events.ScheduleEvent(EVENT_PHASE_TWO_INTRO_1, 3000, 0, PHASE_2);
                }

                if (damage >= me->GetHealth())
                {
                    damage = me->GetHealth() - 1;
                    if (!_defeated)
                    {
                        _defeated = true;
                        Talk(SAY_DEATH);
                        events.Reset();
                        DoCast(me, SPELL_ARCANE_OVERLOAD);
                        events.ScheduleEvent(EVENT_KILL_SELF, 4000);

                        // We really need this here because there are more of those triggers in the instance...
                        std::list<Creature*> units;
                        GetCreatureListWithEntryInGrid(units, me, NPC_GENERAL_PURPOSE_BUNNY_L2, 30.0f);
                        if (!units.empty())
                        {
                            for (auto itr = units.begin(); itr != units.end(); ++itr)
                            {
                                if ((*itr)->GetHomePosition().GetExactDist(leftSideDistanceCheck) <= 20.0f)
                                    (*itr)->CastSpell((*itr), SPELL_ARCANE_FROST_BEAM);
                                else
                                    (*itr)->CastSpell((*itr), SPELL_ARCANE_FIRE_BEAM);
                            }
                        }

                    }
                }
            }

            uint32 GetData(uint32 type) const override
            {
                if (type == DATA_CURRENT_BLOSSOM)
                    return _nextBlossomBunny;
                return 0;
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                    case EVENT_BLINK:                      
                        if (auto target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        {
                            DoCast(target, SPELL_BLINK);
                            if (IsHeroic())
                                me->getThreatManager().resetAllAggro();

                            events.ScheduleEvent(EVENT_ELEMENTAL_FISTS, 80, 0, PHASE_1);
                            events.ScheduleEvent(EVENT_BLINK, 14000);
                        }
                        break;
                    case EVENT_ELEMENTAL_FISTS:
                        Talk(_lastFists == FISTS_OF_FLAME ? SAY_FISTS_OF_FROST : SAY_FISTS_OF_FLAME);
                        DoCast(me, _lastFists == FISTS_OF_FLAME ? SPELL_FISTS_OF_FROST : SPELL_FISTS_OF_FLAME);
                        _lastFists = _lastFists == FISTS_OF_FLAME ? FISTS_OF_FROST : FISTS_OF_FLAME;
                        break;
                    case EVENT_PHASE_TWO_INTRO_1:
                        Talk(SAY_PHASE_TWO_INTRO_1);
                        DoCast(me, SPELL_EMOTE_TALK, true);
                        events.ScheduleEvent(EVENT_PHASE_TWO_INTRO_2, 2000 + 400, 0, PHASE_2);
                        break;
                    case EVENT_PHASE_TWO_INTRO_2:
                        me->NearTeleportTo(arcanePowerPos[1].GetPositionX(), arcanePowerPos[1].GetPositionY(), arcanePowerPos[1].GetPositionZ(), true);
                        Talk(SAY_PHASE_TWO_INTRO_2);
                        DoCast(me, SPELL_EMOTE_ROAR, true);
                        //events.Reset();
                        events.ScheduleEvent(EVENT_ARCANE_POWER, 2000 + 400, 0, PHASE_2);
                        break;
                    case EVENT_ARCANE_POWER:
                    {
                        Talk(SAY_ARCANE_POWER);
                        DoCast(me, SPELL_ARCANE_POWER);
                        me->SetDisableGravity(true);

                        Movement::MoveSplineInit init(*me);
                        init.SetWalk(true);
                        init.SetVelocity(0.8f);
                        init.Launch();

                        // We really need this here because there are more of those triggers in other rooms...
                        std::list<Creature*> units;
                        GetCreatureListWithEntryInGrid(units, me, NPC_GENERAL_PURPOSE_BUNNY_L2, 30.0f);
                        if (!units.empty())
                        {
                            for (auto itr = units.begin(); itr != units.end(); ++itr)
                            {
                                if (Creature* bunny = me->FindNearestCreature(NPC_GENERAL_PURPOSE_DUMMY_JMF, 5.0f, true))
                                {
                                    if ((*itr)->GetHomePosition().GetExactDist(leftSideDistanceCheck) <= 20.0f)
                                        (*itr)->CastSpell(bunny, SPELL_ARCANE_FROST_BEAM);
                                    else
                                        (*itr)->CastSpell(bunny, SPELL_ARCANE_FIRE_BEAM);
                                }
                            }
                        }
                        events.ScheduleEvent(EVENT_STUN_SELF, 2000 + 200, 0, PHASE_2);
                        events.ScheduleEvent(EVENT_BLOSSOM_TARGETING, 6000, 0, PHASE_2);
                        break;
                    }
                    case EVENT_STUN_SELF:
                        DoCast(me, SPELL_STUN_SELF);
                        if (IsHeroic())
                            events.ScheduleEvent(EVENT_ANNOUNCE_FIRE_WALL, 1000 + 500, 0, PHASE_2);
                        break;
                    case EVENT_ANNOUNCE_FIRE_WALL:
                        events.ScheduleEvent(EVENT_FIRE_WALL, 1000 + 400, 0, PHASE_2);
                        break;
                    case EVENT_FIRE_WALL:
                        for (ObjectGuid guid : _firewallDummyGUIDs)
                        {
                            if (Creature* firewallDummy = ObjectAccessor::GetCreature(*me, guid))
                                firewallDummy->CastSpell(firewallDummy, SPELL_FIRE_WALL);
                        }
                        break;
                    case EVENT_BLOSSOM_TARGETING:
                        _nextBlossomBunny = _nextBlossomBunny == NPC_FIRE_BLOSSOM_BUNNY ? NPC_FROST_BLOSSOM_BUNNY : NPC_FIRE_BLOSSOM_BUNNY;
                        if (auto target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                            me->CastSpell(target, SPELL_BLOSSOM_TARGETING);
                        events.ScheduleEvent(EVENT_BLOSSOM_TARGETING, 2000 + 400);
                        //TC_LOG_ERROR(LOG_FILTER_TSCR, "glubtok EVENT_BLOSSOM_TARGETING");
                        break;
                    case EVENT_KILL_SELF:
                    {
                        me->Kill(me);
                        Creature* creature = me;
                        creature->CastSpell(creature, SPELL_TRANSITION_INVISIBILITY);
                        creature->CastSpell(creature, SPELL_ARCANE_OVERLOAD_INSTAKILL);
                        if (Creature* bunny = creature->FindNearestCreature(NPC_GENERAL_PURPOSE_DUMMY_JMF, 5.0f, true))
                            bunny->CastSpell(bunny, SPELL_ARCANE_OVERLOAD_EXPLOSION);
                        break;
                    }
                    default:
                        break;
                    }
                }
                DoMeleeAttackIfReady();
            }
            /*
            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->GetHealthPct() <= 50 && stage == 0)
                {
                    stage = 1;
                    events.Reset();
                    me->SetReactState(REACT_PASSIVE);
                    Talk(SAY_HEAD1);
                    events.RescheduleEvent(EVENT_ARCANE_POWER1, 1800);
                    return;
                }

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
                
                if (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                    case EVENT_ARCANE_POWER1:
                        Talk(SAY_HEAD2);
                        events.RescheduleEvent(EVENT_ARCANE_POWER2, 2200);
                        break;
                    case EVENT_ARCANE_POWER2:
                        me->NearTeleportTo(-193.43f,-437.86f,54.38f,4.88f,true);
                        SetCombatMovement(false);
                        me->AttackStop();
                        me->RemoveAllAuras();
                        events.RescheduleEvent(EVENT_ARCANE_POWER3, 1000);
                        break;
                    case EVENT_ARCANE_POWER3:
                        SetCombatMovement(false);
                        DoCast(me, SPELL_ARCANE_POWER, true);
                        Talk(SAY_ARCANE_POWER);
                        events.RescheduleEvent(EVENT_BLOSSOM, 5000);
                        break;
                    case EVENT_BLOSSOM:
                        if (auto target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                                DoCast(target, urand(0, 1) ? SPELL_FIRE_BLOSSOM : SPELL_FROST_BLOSSOM);
                        events.RescheduleEvent(EVENT_BLOSSOM, 5000);
                        break;
                    case EVENT_FIST_OF_FLAME:
                        DoCast(me, SPELL_FIST_OF_FLAME);
                        Talk(SAY_FIRE);
                        events.RescheduleEvent(EVENT_BLINK, 20000);
                        events.RescheduleEvent(EVENT_FIST_OF_FROST, 20500);
                        break;
                    case EVENT_FIST_OF_FROST:
                        DoCast(me, SPELL_FIST_OF_FROST);
                        Talk(SAY_FROST);
                        events.RescheduleEvent(EVENT_BLINK, 20000);
                        events.RescheduleEvent(EVENT_FIST_OF_FLAME, 20500);
                        break;
                    case EVENT_BLINK:
                        if (auto target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        {
                            DoCast(target, SPELL_BLINK);
                            if (IsHeroic())
                                DoResetThreat();
                        }
                        break;
                    }
                }
                DoMeleeAttackIfReady();
            }*/
        };
};

class spell_glubtok_blossom_targeting : public SpellScriptLoader
{
public:
    spell_glubtok_blossom_targeting() : SpellScriptLoader("spell_glubtok_blossom_targeting") {}

    class spell_glubtok_blossom_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_glubtok_blossom_targeting_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            if (Unit* caster = GetCaster())
            {
                if (Creature* creature = caster->ToCreature())
                {
                    if (creature->IsAIEnabled)
                    {
                        uint32 currentBlossomEntry = creature->AI()->GetData(DATA_CURRENT_BLOSSOM);
                        targets.remove_if([currentBlossomEntry](WorldObject const* obj)->bool
                            {
                                return obj->GetTypeId() != TYPEID_UNIT || obj->GetEntry() != currentBlossomEntry;
                            });
                    }
                }
            }

            if (targets.empty())
                return;

            Trinity::Containers::RandomResizeList(targets, 1);
        }

        void HandleBlossomEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* target = GetHitUnit();
            if (Unit* caster = GetCaster())
            {
                caster->CastSpell(target, target->GetEntry() == NPC_FIRE_BLOSSOM_BUNNY ? SPELL_FIRE_BLOSSOM : SPELL_FROST_BLOSSOM, true);
                target->CastSpell(target, target->GetEntry() == NPC_FIRE_BLOSSOM_BUNNY ? SPELL_FIRE_BLOSSOM_VISUAL : SPELL_FROST_BLOSSOM_VISUAL);
                target->CastSpellDelay(target, target->GetEntry() == NPC_FIRE_BLOSSOM_BUNNY ? SPELL_FIRE_BLOSSOM_EFFECT : SPELL_FROST_BLOSSOM_EFFECT, false, 2000);
            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_glubtok_blossom_targeting_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            OnEffectHitTarget += SpellEffectFn(spell_glubtok_blossom_targeting_SpellScript::HandleBlossomEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };
    SpellScript* GetSpellScript() const
    {
        return new spell_glubtok_blossom_targeting_SpellScript();
    }
};

void AddSC_boss_glubtok()
{
    new boss_glubtok();
    new spell_glubtok_blossom_targeting();
}