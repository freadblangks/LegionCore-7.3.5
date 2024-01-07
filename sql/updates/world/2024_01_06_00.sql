-- Fix loot chance for the following quest items

-- 54855 = Gargantapid's Poison Gland
-- 60851 = Side of Bear Meat

DELETE FROM `creature_loot_template` WHERE `item` IN (54855,60851);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`, `shared`) VALUES
(40581, 54855, -100, 0, 0, 1, 1, 0),
(44473, 60851, -40, 0, 0, 1, 1, 0);

-- Fix broken creatures

-- 44473 = Shaggy Black Bear (could not move, did not drop quest items, did not give XP)
-- 108815 = Anguished Spectre (bad min/max level)
-- 108830 = Risen Legionnaire (bad min/max level)
-- 108847 = Disturbed Resident (bad min/max level)


DELETE FROM `creature_template` WHERE `entry` IN (44473,108815,108830,108847);
INSERT INTO `creature_template` (`entry`, `gossip_menu_id`, `minlevel`, `maxlevel`, `SandboxScalingID`, `ScaleLevelMin`, `ScaleLevelMax`, `ScaleLevelDelta`, `ScaleLevelDuration`, `exp`, `faction`, `npcflag`, `npcflag2`, `speed_walk`, `speed_run`, `speed_fly`, `scale`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Mana_mod_extra`, `Armor_mod`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ControllerID`, `WorldEffects`, `PassiveSpells`, `StateWorldEffectID`, `SpellStateVisualID`, `SpellStateAnimID`, `SpellStateAnimKitID`, `IgnoreLos`, `AffixState`, `MaxVisible`, `ScriptName`) VALUES
(44473, 0, 35, 36, 27, 35, 60, 0, 0, 0, 44, 0, 0, 1, 1, 1.14286, 1, 95, 125.4, 0, 228, 1, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 64.6, 96.9, 16, 44473, 0, 44473, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 136, 136, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, ''),
(108815, 0, 35, 36, 0, 35, 60, 0, 100, 6, 14, 0, 0, 1, 1.14286, 1.14286, 1, 0, 0, 0, 0, 1, 2000, 2000, 8, 32768, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 108815, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 163, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, -1, '', '', 0, 0, 0, 0, 0, 0, 0, ''),
(108847, 0, 35, 36, 0, 35, 60, 0, 100, 6, 14, 0, 0, 1, 1.14286, 1.14286, 1, 0, 0, 0, 0, 1, 2000, 2000, 1, 32768, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 108847, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 163, '', 0, 3, 1, 1, 1, 1, 0, 0, -1, '', '', 0, 0, 0, 0, 0, 0, 0, ''),
(108830, 0, 35, 36, 0, 35, 60, 0, 100, 6, 14, 0, 0, 1, 1.14286, 1.14286, 1, 0, 0, 0, 0, 1, 2000, 2000, 1, 32768, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 108830, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 163, '', 0, 3, 1, 1, 1, 1, 0, 0, -1, '', '', 0, 0, 0, 0, 0, 0, 0, '');