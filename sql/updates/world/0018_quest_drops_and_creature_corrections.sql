-- Fix loot chance for the following quest items

-- Most of these should be 100%
-- 884 = Ghoul Rib
-- 981 = Bernice's Necklace
-- 1006 = Brass Collar
-- 1946 = Mary's Looking Glass
-- 1968 = Ogre's Monocle
-- 2713 = Ol' Sooty's Head
-- 3616 = Mind's Eye
-- 3876 = Fang of Bhag'thera
-- 3877 = Talon of Tethis
-- 3879 = Paw of Sin'Dall
-- 3880 = Head of Bangalash
-- 4106 = Tumbled Crystal
-- 22934 = Lasher Sample
-- 58179 = Gan'zulah's Body
-- 59522 = Key of Ilgalar
-- 60207 = Widow Venom Sac
-- 60213 = Crystal Spine Basilisk Blood
-- 60263 = Whispering Blue Stone
-- 60274 = Sea Salt
-- 60334 = Black Bear Brain
-- 60792 = Pristine Flight Feather (bump from 35% to 50%)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 884;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 60792;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` IN (4106, 60263, 60274);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -90 WHERE `item` IN (60213, 60334);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (981, 1006, 1946, 1968, 2713, 3616, 3876, 3877, 3879, 3880, 22934, 58179, 59522, 60207);

-- Fix broken "Rescue the Survivors!" quest (can't heal the Draenei Survivor, wrong faction and NPC flag)
UPDATE `creature_template` SET `faction` = 1638, `npcflag` = 0 WHERE `entry` = 16483;

-- Fix broken "Thistle While You Work" quest (can't loot the seeds)
DELETE FROM `conditions` WHERE `SourceEntry` = 60737;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 205089, 60737, 0, 0, 9, 0, 27025, 0, 0, 0, 0, '', '');

UPDATE `gameobject_template` SET `type` = 3, `castBarCaption` = 'Collecting', `Data8` = 27025, `Data14` = 19676, `VerifiedBuild` = 26124 WHERE `entry` = 205089;

-- Fix bad quest POI point

-- Mistmantle's Revenge
-- Adjusted this one (OLD: 26674, 1, 0, -10512, -1301, 22908)
UPDATE `quest_poi_points` SET `X` = -10382, `Y` = -1246, `VerifiedBuild` = 26124 WHERE `QuestID` = 26674 AND `Idx1` = 1;

-- Fix creatures in Stranglethorn, previously wrong level and did not attack

-- 52224 = Jungle Serpent
-- 52604 = Digsite Zombie

UPDATE `creature_template` SET `minlevel` = 24, `maxlevel` = 25, `ScaleLevelMin` = 25, `ScaleLevelMax` = 60, `faction` = 16, `unit_flags` = 0 WHERE `entry` = 52224;
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 32, `ScaleLevelMin` = 30, `ScaleLevelMax` = 60, `faction` = 16, `unit_flags` = 0 WHERE `entry` = 52604;

-- Fix loot chance for the following quest items

-- 3897 = Dizzy's Eye
-- 3910 = Snuff
-- 3919 = Mistvale Giblets
-- 3932 = Smotts' Chest
-- 4016 = Zanzil's Mixture
-- 4029 = Akiris Reed
-- 58225 = Braddok's Big Brain
-- 58812 = Supple Tigress Fur
-- 58813 = Velvety Panther Fur
-- 58901 = Zanzil's Formulation
-- 60380 = Ironjaw Humour

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -10 WHERE `item` = 3897;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 3897 AND `entry` = 2551;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (3932, 58225, 58812, 58813, 60380);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -33 WHERE `item` = 4016;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 3919;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 58901;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -60 WHERE `item` = 4029;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` = 3910;

DELETE FROM `creature_loot_template` WHERE `item` = 3897 AND `entry` IN (2547, 43152);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`, `shared`) VALUES
(2547, 3897, -10, 0, 0, 1, 1, 0),
(43152, 3897, -10, 0, 0, 1, 1, 0);

-- Fix loot chance for the following quest items

-- 46692 = Elune's Torch

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 46692;

-- Fix loot chance for the following quest items

-- 23677 = Moongraze Buck Hide

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` = 23677;

-- Fix "Stranglethorn Fever" quest, it should NOT be repeatable!

UPDATE `quest_template_addon` SET `SpecialFlags` = 0 WHERE `id` = 26597;

-- Fix creature in Stranglethorn, previously wrong level and did not attack

-- 53011 = Hideaway Zombie

UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 32, `ScaleLevelMin` = 30, `ScaleLevelMax` = 60, `faction` = 16 WHERE `entry` = 53011;

-- Fix loot chance for the following quest items

-- 54855 = Gargantapid's Poison Gland
-- 60851 = Side of Bear Meat

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 60851;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 54855;

-- Fix broken creatures

-- 1783 = Skeletal Flayer (scale min/max not set)
-- 1784 = Skeletal Sorcerer (scale min/max not set)
-- 1847 = Foulmane (scale min/max not set)
-- 44473 = Shaggy Black Bear (could not move, did not drop quest items, did not give XP)
-- 108815 = Anguished Spectre (bad min/max level)
-- 108830 = Risen Legionnaire (bad min/max level)
-- 108847 = Disturbed Resident (bad min/max level)

UPDATE `creature_template` SET `minlevel` = 35, `maxlevel` = 36, `mingold` = 163, `maxgold` = 163 WHERE `entry` IN (108815, 108830, 108847);
UPDATE `creature_template` SET `ScaleLevelMin` = 35, `ScaleLevelMax` = 60 WHERE `entry` IN (1783, 1784, 1847, 108815, 108830, 108847);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 44473;

-- Remove deprecated quest

-- 24527 = Your Path Begins Here (Removed in 7.0.3 per Wowpedia)

DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` = 24527;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 24527, 0, '', '', 'Deprecated quest: Your Path Begins Here');

-- Fix loot chance for the following quest items

-- 9371 = Gordunni Orb
-- 9530 = Horn of Hatetalon (supposed to drop from more things AND be quest only!)
-- 13157 = Fetid Skull
-- 15785 = Zaeldarr's Head
-- 18961 = Zukk'ash Carapace
-- 53136 = Soul Essence
-- 54856 = Duneclaw Stinger
-- 60983 = Crypt Bile
-- 60987 = Joseph's Hunting Blade
-- 62028 = Browman's Wrappings

DELETE FROM `creature_loot_template` WHERE `item` = 9530;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`, `shared`) VALUES
(5362, 9530, -100, 0, 0, 1, 1, 0),
(5363, 9530, -100, 0, 0, 1, 1, 0),
(5364, 9530, -100, 0, 0, 1, 1, 0),
(5366, 9530, -100, 0, 0, 1, 1, 0);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -60 WHERE `item` = 53136;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` = 13157;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -85 WHERE `item` = 60983;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -90 WHERE `item` = 54856;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (9371, 15785, 18961, 60987, 62028);

-- Fix quests that should NOT be repeatable!
-- 27388 = Heroes of Darrowshire
-- 28755 = Annals of the Silver Hand

UPDATE `quest_template_addon` SET `SpecialFlags` = 0 WHERE `id` IN (27388, 28755);

-- Fix loot chance for the following quest items

-- 33085 = Bloodfen Feather
-- 59057 = Poobah's Tiara
-- 59058 = Poobah's Scepter
-- 59059 = Poobah's Slippers
-- 59060 = Poobah's Diary

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -33 WHERE `item` = 33085 AND `entry` IN (4356, 4357);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -25 WHERE `item` = 33085 AND `entry` = 23873;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` IN (59057, 59058, 59059, 59060);

-- Fix quests that should NOT be repeatable!

-- 2438 = The Emerald Dreamcatcher

UPDATE `quest_template` SET `Flags` = 8, `VerifiedBuild` = 26124 WHERE `id` = 2438;
UPDATE `quest_template_addon` SET `SpecialFlags` = 0 WHERE `id` = 2438;

-- Fix broken "Counter-Plague Research" quest (can't loot the rotberries, missing entry)
DELETE FROM `conditions` WHERE `SourceEntry` = 61364;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 205559, 61364, 0, 0, 9, 0, 27531, 0, 0, 0, 0, '', '');

UPDATE `gameobject_template` SET `type` = 3, `VerifiedBuild` = 26124 WHERE `entry` = 205559;

-- Fix broken "Greasing the Wheel" quest (can't loot the banshee's bells, missing entry)
DELETE FROM `conditions` WHERE `SourceEntry` = 60984;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 205423, 60984, 0, 0, 9, 0, 27369, 0, 0, 0, 0, '', '');

UPDATE `gameobject_template` SET `type` = 3, `VerifiedBuild` = 26124 WHERE `entry` = 205423;

-- Fix duplicated NPCs

-- 2502 = "Shaky" Phillipe
-- 44100 = Goris
-- 44391 = Innkeeper Shyria

DELETE FROM `creature` WHERE `guid` IN (360237, 360149, 167921);
UPDATE `creature` SET `position_x` = -14297.87, `position_y` = 508.75, `position_z` = 8.9645, `orientation` = 2.2568 WHERE `guid` = 4219;
UPDATE `creature` SET `position_x` = -13616.18, `position_y` = -61.9, `position_z` = 35.239, `orientation` = 6.0715 WHERE `guid` = 3364;

-- Fix battle pets that cannot be fought

-- 61459 = Little Black Ram
-- 62257 = Sand Kitten

UPDATE `creature_template` SET `faction` = 188 WHERE `entry` IN (61459, 62257);

-- Fix battle pets that cannot be fought

-- The following cast recall spells when you try to fight them...

-- 7555 = Hawk Owl
-- 61757 = Red-Tailed Chipmunk
-- 62178 = Elfin Rabbit
-- 69352 = Vampiric Cave Bat
-- 99394 = Fetid Waveling

UPDATE `creature_template` SET `faction` = 188, `unit_flags` = 0, `unit_flags2` = 0 WHERE `entry` IN (61757, 62178);
DELETE FROM `npc_spellclick_spells` WHERE spell_id IN (1, 3) AND `npc_entry` IN (7555, 61757, 62178, 69352, 99394);

-- Fix loot chance for the following quest items

-- 3514 = Mor'Ladim's Skull
-- 4103 = Shackle Key
-- 9237 = Woodpaw Gnoll Mane
-- 62510 = Shadowstout

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -65 WHERE `item` = 62510;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` = 9237;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (3514, 4103);

-- Fix loot chance for the following quest items

-- 61313 = Mossflayer Eye
-- 62390 = Scalding Whelp Corpse

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -85 WHERE `item` = 61313;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -45 WHERE `item` = 61313 AND `entry` = 10822;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 62390;

-- Fix loot chance for the following quest items

-- 11114 = Dinosaur Bone
-- 11477 = White Ravasaur Claw
-- 11478 = Un'Goro Gorilla Pelt
-- 11479 = Un'Goro Stomper Pelt
-- 11480 = Un'Goro Thunderer Pelt
-- 11509 = Ravasaur Pheromone Gland
-- 11831 = Webbed Pterrordax Scale
-- 50371 = Silithid Leg (supposed to be guaranteed and negative chance)
-- 51778 = Hyena Chunk
-- 52281 = Meatface's Locked Chest
-- 52282 = Turtle-Digested Key

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -25 WHERE `item` = 52282;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -30 WHERE `item` = 11114;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -35 WHERE `item` IN (11478, 11479, 11480);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 11831;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` = 51778;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (11477, 11509, 50371, 52281);

-- Fix loot chance for the following quest items

-- 11510 = Lar'korwi's Head
-- 50410 = Durrin's Archaeological Findings (should be negative)
-- 63135 = Razor-Sharp Scorpid Barb
-- 63136 = Ember Worg Hide

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 63135;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (11510, 50410, 63136);

-- Fix battle pets that should not be green to you

-- 61317 = Long-tailed Mole
-- 62256 = Stinkbug
-- 62258 = Silithid Hatchling
-- 62364 = Ash Lizard
-- 62370 = Spotted Bell Frog

UPDATE `creature_template` SET `faction` = 188 WHERE `entry` IN (61317, 62256, 62258, 62364, 62370);

-- Disable deprecated quests

-- 24752 = "The Arts of a Mage" (Horde)
-- 26198 = "The Arts of a Mage" (Alliance)

DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` IN (24752, 26198);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 24752, 0, '', '', 'Deprecated quest: The Arts of a Mage (Horde)'),
(1, 26198, 0, '', '', 'Deprecated quest: The Arts of a Mage (Alliance)');

-- Fix loot chance for the following quest items

-- 2676 = Shimmerweed
-- 3084 = Gyromechanic Gear
-- 3627 = Fang of Vagash
-- 10005 = Margol's Gigantic Horn
-- 23217 = Ravager Egg
-- 23218 = Condensed Voidwalker Essence
-- 23239 = Plump Buzzard Wing
-- 23270 = Tainted Helboar Meat
-- 30157 = Cursed Talisman
-- 56264 = Dark Iron Attack Plans
-- 58202 = Stolen Powder Keg
-- 60496 = Tender Boar Ribs
-- 62805 = Tempered Flywheel
-- 62807 = Dark Iron Memo
-- 62809 = Glassweb Venom
-- 62914 = Fire-Gizzard
-- 62916 = Dark Iron Bullet
-- 63028 = Rasha'krak's Bracers of Binding
-- 63421 = Obsidian Ashes

DELETE FROM `creature_loot_template` WHERE `item` = 23270 AND `entry` IN (16844, 16857);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -1 WHERE `item` = 23217 AND `entry` = 16932;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -4 WHERE `item` = 23217 AND `entry` = 19189;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -10 WHERE `item` = 23270 AND `entry` IN (16844, 16857);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -15 WHERE `item` = 30157 AND `entry` IN (16879, 19423, 19457, 19458, 19459);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -15 WHERE `item` = 30157 AND `entry` = 19442;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -22 WHERE `item` = 23217 AND `entry` = 16933;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 2676;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 23239;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 30157 AND `entry` IN (16871, 16873, 16907, 19422, 19424);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` = 23218;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -85 WHERE `item` = 62914;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 23270 AND `entry` IN (16863, 16879, 16880);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (3084, 3627, 10005, 56264, 58202, 60496, 62805, 62807, 62809, 62916, 63028, 63421);

-- Fix battle pets that should not be green to you

-- 61370 = Swamp Moth
-- 61372 = Moccasin

UPDATE `creature_template` SET `faction` = 188 WHERE `entry` IN (61370, 61372);

-- Fix loot chance for the following quest items

-- 2636 = Carved Stone Idol
-- 55232 = Threshadon Chunk
-- 57131 = Intact Crocolisk Jaw
-- 60402 = Mosshide Ear
-- 60404 = Foreman Sharpsneer's Head
-- 60497 = Bear Rump
-- 60511 = Murloc Scent Gland
-- 60754 = Glassy Hornet Wing
-- 60755 = Fluffy Fox Tail

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -65 WHERE `item` IN (57131, 60511, 60754);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` = 2636;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -90 WHERE `item` = 60497;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (55232, 60402, 60404, 60755);

-- Fix loot chance for the following quest items

-- 2629 = Intrepid Strongbox Key
-- 3183 = Mangy Claw
-- 3618 = Gobbler's Head
-- 4503 = Witherbark Tusk
-- 4515 = Marez's Head
-- 4516 = Otto's Head
-- 4517 = Falconcrest's Head
-- 4522 = Witherbark Medicine Pouch
-- 23687 = Blacktalon's Claws
-- 28513 = Demonic Rune Stone (should be negative)
-- 29795 = Burning Legion Gate Key
-- 30158 = Morkh's Shattered Armor
-- 31347 = Bleeding Hollow Torch (drops when it should not, loot chance was all over with one negative and rest positive)
-- 52305 = Humming Electrogizard
-- 55234 = Dumpy Level
-- 55988 = Glowerglare's Beard
-- 56013 = Meaty Crawler Claw
-- 56083 = Fossilized Bone
-- 56087 = Marshy Crocolisk Hide
-- 56088 = Ironforge Ingot
-- 56089 = Horrorjaw's Hide
-- 58779 = Shell of Shadra
-- 60737 = Stabthistle Seed

DELETE FROM `creature_loot_template` WHERE `item` = 28513 AND `entry` IN (18679, 18977, 19335);
DELETE FROM `creature_loot_template` WHERE `item` = 30158 AND `entry` IN (16907, 19422, 19424);
DELETE FROM `creature_loot_template` WHERE `item` = 31347 AND `entry` IN (16871, 16873, 16879, 16964, 19422, 19424);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -25 WHERE `item` = 28513 AND `entry` = 19282;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -60 WHERE `item` = 28513 AND `entry` IN (16950, 18981);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -85 WHERE `item` = 28513 AND `entry` IN (18975, 19190);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` IN (4503, 4522);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 4503 AND `entry` = 2605;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (2629, 3183, 3618, 4515, 4516, 4517, 23687, 30158, 56083, 56087, 56089, 58779, 55988);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -2 WHERE `item` = 60737;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -15 WHERE `item` = 55234;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -25 WHERE `item` = 52305;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 56013;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` IN (31347, 56088);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -0.1699 WHERE `item` = 29795 AND `entry` = 16946;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -0.0916 WHERE `item` = 29795 AND `entry` = 16947;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -0.0267 WHERE `item` = 29795 AND `entry` = 16954;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -0.0187 WHERE `item` = 29795 AND `entry` = 16960;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29795 AND `entry` = 19298;

-- Fix "Young Murk Thresher" drop table (which will fix the "Thresher Oil" quest drop)

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -60 WHERE `entry` = 4388 AND `item` = 33126;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 10 WHERE `entry` = 4388 AND `item` = 2608;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 22 WHERE `entry` = 4388 AND `item` = 5516;

-- Fix loot chance for the following quest items

-- 46768 = Sploder's Head
-- 55239 = Cragjaw's Huge Tooth
-- 55280 = Deepmoss Venom Sac

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (46768, 55239, 55280);

-- Fix loot chance for the following quest items

-- 6245 = Karnitol's Satchel
-- 23588 = Kaliri Feather
-- 23589 = Mag'har Ancestral Beads
-- 56040 = Ram Haunch
-- 56042 = Boulderslide Cheese
-- 56187 = Sentinel's Glaive
-- 56223 = Black Dragon Whelp Filet
-- 56224 = Blazing Heart of Fire

DELETE FROM `creature_loot_template` WHERE `item` = 23588 AND `entry` IN (16966, 16967, 17084);
DELETE FROM `creature_loot_template` WHERE `item` = 23589 AND `entry` IN (16911, 16912);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -35 WHERE `item` = 23588 AND `entry` IN (17035, 17039, 17053);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` IN (6245, 56042, 56223);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -55 WHERE `item` = 23588 AND `entry` = 17034;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` IN (23589, 56040, 56224);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 56187;

-- Fix loot chance for the following quest items

-- 24280 = Naga Claws
-- 24372 = Diaphanous Wing
-- 25448 = Blacksting's Stinger
-- 29480 = Parched Hydra Sample
-- 29481 = Withered Bog Lord Sample
-- 44863 = Corrupted Tide Crawler Flesh
-- 58236 = Umboda's Head
-- Tablet of Shadra

DELETE FROM `creature_loot_template` WHERE `item` = 24280 AND `entry` IN (18122, 18123, 18132, 18154, 18213, 20079, 20090);
DELETE FROM `creature_loot_template` WHERE `item` = 24372 AND `entry` IN (18086, 18122, 18134, 18135);
DELETE FROM `creature_loot_template` WHERE `item` = 25448 AND `entry` = 20270;
DELETE FROM `creature_loot_template` WHERE `item` = 29480 AND `entry` IN (18124, 19402);
DELETE FROM `creature_loot_template` WHERE `item` = 29481 AND `entry` IN (18124, 20324);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (24280, 25448, 58236);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 24372;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 29480;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 29481;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -45 WHERE `item` = 44863;

-- Fix loot chance for the following quest items

-- 12829 = Winterfall Crate
-- 12842 = Crudely-Written Log
-- 20385 = Deathclasp's Pincer
-- 20394 = Twilight Lexicon - Chapter 1
-- 20395 = Twilight Lexicon - Chapter 2
-- 20396 = Twilight Lexicon - Chapter 3
-- 24238 = Mushroom Sample
-- 51793 = Ocular Crystal
-- 62918 = Cursed Ooze
-- 63088 = Corrupted Pelt
-- 63279 = Kitty's Eartag
-- 63522 = Entropic Essence
-- 63687 = Kroshius' Infernal Core
-- 63695 = Drizle's Key
-- 64441 = Memory of Zin-Malor
-- 64449 = Suspicious Green Sludge
-- 64463 = Shard of the Spiritspeaker
-- 64465 = Rimepelt's Heart
-- 64586 = Prime Rubble Chunk
-- 64587 = Fresh-Cut Frostwood
-- 64664 = Icewhomp's Pristine Horns
-- 65903 = Winterwater
-- 66052 = Mana-Addled Brain
-- 74615 = Paint Soaked Brush

DELETE FROM `creature_loot_template` WHERE `item` = 74615 AND NOT `entry` = 55601;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (12829, 20385, 20394, 20395, 20396, 62918, 63088, 63279, 63522, 63687, 63695, 64441, 64463, 64465, 64586, 64587, 64664, 74615);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 24238 AND `entry` = 18159;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` IN (51793, 64449, 66052);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -75 WHERE `item` = 65903 AND `entry` = 50251;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 24238 AND `entry` IN (18117, 18118, 20443);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 65903 AND `entry` = 50250;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` = 12842;

-- Fix loot chance for the following game objects

-- 20378 = Twilight Tablet Fragment

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 20378;

-- Fix missing quest starter

-- 28782 = A Bird of Legend (Winterspring)

DELETE FROM `creature_queststarter` WHERE `quest` = 28782;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(49537,28782);


-- Fix Fel Reaver not pathing correctly in Hellfire Peninsula

UPDATE `creature` SET `equipment_id` = 1, `spawndist` = 0, `MovementType` = 2 WHERE `id` = 18733;
UPDATE `creature` SET `position_x` = 509.511, `position_y` = 3036.76, `position_z` = 14.8954, `orientation` = 0.689235 WHERE `guid` = 20744;
UPDATE `creature` SET `position_x` = -732.521, `position_y` = 2967.13, `position_z` = 21.6502, `orientation` = 4.7173 WHERE `guid` = 133539;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18733;

DELETE FROM `creature_addon` WHERE `guid` IN (20744, 133539);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(20744, 207440, 0, 0, 1, 0, ''),
(133539, 1335390, 0, 0, 1, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18733;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18733,0,0,0,11,0,100,512,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fel Reaver - On Respawn - Set Active On'),
(18733,0,1,0,0,0,100,0,12000,25000,12000,25000,11,36835,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fel Reaver - In Combat - Cast ''War Stomp'''),
(18733,0,2,0,11,0,100,0,0,0,0,0,11,34623,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fel Reaver - On Respawn - Cast Fel Reaver Warning Aura'),
(18733,0,3,0,11,0,100,0,0,0,0,0,11,19818,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fel Reaver - On Respawn - Cast Double Attack');

DELETE FROM `waypoint_data` WHERE `id` IN (207440, 1335390);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `delay_chance`, `move_flag`, `speed`, `action`, `action_chance`, `entry`, `wpguid`) VALUES
(207440,1,509.511,3036.76,14.8954,0,0,0,0,0,0,100,0,0),
(207440,2,468.111,3044.12,17.1177,0,0,0,0,0,0,100,0,0),
(207440,3,435.457,3053.02,15.3178,0,0,0,0,0,0,100,0,0),
(207440,4,398.9,3055.89,15.3652,0,0,0,0,0,0,100,0,0),
(207440,5,366.186,3053.95,19.5121,0,0,0,0,0,0,100,0,0),
(207440,6,333.3,3061.4,24.1609,0,0,0,0,0,0,100,0,0),
(207440,7,301.011,3066.45,24.5162,0,0,0,0,0,0,100,0,0),
(207440,8,268.367,3085.14,24.1494,0,0,0,0,0,0,100,0,0),
(207440,9,234.287,3111.5,27.4512,0,0,0,0,0,0,100,0,0),
(207440,10,199.141,3119.61,27.3165,0,0,0,0,0,0,100,0,0),
(207440,11,168.31,3120.54,24.0803,0,0,0,0,0,0,100,0,0),
(207440,12,134.764,3124.98,21.341,0,0,0,0,0,0,100,0,0),
(207440,13,97.2362,3156.74,21.0718,0,0,0,0,0,0,100,0,0),
(207440,14,67.2988,3145.46,13.7389,0,0,0,0,0,0,100,0,0),
(207440,15,32.68,3143.96,2.6598,0,0,0,0,0,0,100,0,0),
(207440,16,-0.276367,3146.73,-1.13905,0,0,0,0,0,0,100,0,0),
(207440,17,-33.7507,3153.48,-1.4247,0,0,0,0,0,0,100,0,0),
(207440,18,-49.5957,3167.35,-2.1486,0,0,0,0,0,0,100,0,0),
(207440,19,-57.8723,3199.41,3.82308,0,0,0,0,0,0,100,0,0),
(207440,20,-76.417,3232.38,11.4572,0,0,0,0,0,0,100,0,0),
(207440,21,-93.1454,3265.91,16.2309,0,0,0,0,0,0,100,0,0),
(207440,22,-91.1508,3298.84,25.3296,0,0,0,0,0,0,100,0,0),
(207440,23,-92.2129,3330.81,33.6334,0,0,0,0,0,0,100,0,0),
(207440,24,-72.0116,3365.6,48.7388,0,0,0,0,0,0,100,0,0),
(207440,25,-40.614,3398.47,60.584,0,0,0,0,0,0,100,0,0),
(207440,26,-13.7357,3434.71,66.1294,0,0,0,0,0,0,100,0,0),
(207440,27,0.283963,3467.11,64.0203,0,0,0,0,0,0,100,0,0),
(207440,28,-15.1254,3501.03,62.2086,0,0,0,0,0,0,100,0,0),
(207440,29,-21.5059,3533.42,63.1487,0,0,0,0,0,0,100,0,0),
(207440,30,-26.714,3566.52,70.8811,0,0,0,0,0,0,100,0,0),
(207440,31,-45.7444,3599.06,74.0089,0,0,0,0,0,0,100,0,0),
(207440,32,-70.5209,3632.55,69.0837,0,0,0,0,0,0,100,0,0),
(207440,33,-100.295,3660.26,63.4818,0,0,0,0,0,0,100,0,0),
(207440,34,-133.336,3689.05,57.4929,0,0,0,0,0,0,100,0,0),
(207440,35,-140.103,3732.41,63.8843,0,0,0,0,0,0,100,0,0),
(207440,36,-124.016,3766.16,70.7898,0,0,0,0,0,0,100,0,0),
(207440,37,-118.531,3799.95,77.0677,0,0,0,0,0,0,100,0,0),
(207440,38,-86.1423,3832.69,80.5277,0,0,0,0,0,0,100,0,0),
(207440,39,-73.0625,3867.3,86.832,0,0,0,0,0,0,100,0,0),
(207440,40,-46.7582,3898.51,90.7201,0,0,0,0,0,0,100,0,0),
(207440,41,-1.55914,3919.69,87.3096,0,0,0,0,0,0,100,0,0),
(207440,42,33.1158,3945.06,84.5701,0,0,0,0,0,0,100,0,0),
(207440,43,67.2801,3958.62,78.4276,0,0,0,0,0,0,100,0,0),
(207440,44,105.522,3967.61,75.1717,0,0,0,0,0,0,100,0,0),
(207440,45,124.133,3999.05,74.097,0,0,0,0,0,0,100,0,0),
(207440,46,118.048,4033.41,72.3944,0,0,0,0,0,0,100,0,0),
(207440,47,113.803,4066.55,66.9174,0,0,0,0,0,0,100,0,0),
(207440,48,109.234,4099.74,63.3308,0,0,0,0,0,0,100,0,0),
(207440,49,85.4328,4132.02,64.2376,0,0,0,0,0,0,100,0,0),
(207440,50,45.6713,4135.7,68.5212,0,0,0,0,0,0,100,0,0),
(207440,51,2.12999,4137.95,80.4278,0,0,0,0,0,0,100,0,0),
(207440,52,-23.3349,4101.4,80.0859,0,0,0,0,0,0,100,0,0),
(207440,53,-66.1777,4079.74,91.4475,0,0,0,0,0,0,100,0,0),
(207440,54,-100.548,4054.84,97.91,0,0,0,0,0,0,100,0,0),
(207440,55,-98.9026,4033.89,99.071,0,0,0,0,0,0,100,0,0),
(207440,56,-120.57,4000.12,99.9497,0,0,0,0,0,0,100,0,0),
(207440,57,-147.196,3966,102.895,0,0,0,0,0,0,100,0,0),
(207440,58,-176.817,3933.93,95.9551,0,0,0,0,0,0,100,0,0),
(207440,59,-218.794,3912.22,89.495,0,0,0,0,0,0,100,0,0),
(207440,60,-258.878,3923.02,86.5352,0,0,0,0,0,0,100,0,0),
(207440,61,-281.065,3966.37,90.6101,0,0,0,0,0,0,100,0,0),
(207440,62,-284.821,3999.43,95.6608,0,0,0,0,0,0,100,0,0),
(207440,63,-280.555,4032.91,99.6772,0,0,0,0,0,0,100,0,0),
(207440,64,-268.089,4066.42,99.8858,0,0,0,0,0,0,100,0,0),
(207440,65,-234.175,4100.88,98.1129,0,0,0,0,0,0,100,0,0),
(207440,66,-201.889,4134.47,96.5774,0,0,0,0,0,0,100,0,0),
(207440,67,-177.99,4166.21,93.6494,0,0,0,0,0,0,100,0,0),
(207440,68,-162.809,4199.44,90.6338,0,0,0,0,0,0,100,0,0),
(207440,69,-148.851,4232.51,91.2716,0,0,0,0,0,0,100,0,0),
(207440,70,-152.312,4268.78,85.5575,0,0,0,0,0,0,100,0,0),
(207440,71,-152.977,4302.78,81.3509,0,0,0,0,0,0,100,0,0),
(207440,72,-154.714,4334.83,74.365,0,0,0,0,0,0,100,0,0),
(207440,73,-158.442,4368.46,64.9498,0,0,0,0,0,0,100,0,0),
(207440,74,-163.181,4399.01,56.4079,0,0,0,0,0,0,100,0,0),
(207440,75,-155.772,4434.49,49.3343,0,0,0,0,0,0,100,0,0),
(207440,76,-136.282,4466.99,49.9481,0,0,0,0,0,0,100,0,0),
(207440,77,-99.5126,4498.7,56.1267,0,0,0,0,0,0,100,0,0),
(207440,78,-82.4961,4530.44,51.5326,0,0,0,0,0,0,100,0,0),
(207440,79,-75.0497,4562.87,45.3859,0,0,0,0,0,0,100,0,0),
(207440,80,-36.3085,4585.75,44.7704,0,0,0,0,0,0,100,0,0),
(207440,81,-0.46951,4614.63,51.3763,0,0,0,0,0,0,100,0,0),
(207440,82,-2.57292,4647.69,43.62,0,0,0,0,0,0,100,0,0),
(207440,83,-34.8304,4681.64,37.9052,0,0,0,0,0,0,100,0,0),
(207440,84,-67.4076,4710.77,30.0692,0,0,0,0,0,0,100,0,0),
(207440,85,-107.191,4732.78,29.807,0,0,0,0,0,0,100,0,0),
(207440,86,-154.248,4726.24,21.9866,0,0,0,0,0,0,100,0,0),
(207440,87,-191.269,4722.75,16.2274,0,0,0,0,0,0,100,0,0),
(207440,88,-221.055,4699.67,10.5983,0,0,0,0,0,0,100,0,0),
(207440,89,-239.877,4665.91,13.3524,0,0,0,0,0,0,100,0,0),
(207440,90,-267.39,4641.45,21.8357,0,0,0,0,0,0,100,0,0),
(207440,91,-300.929,4633.15,25.2724,0,0,0,0,0,0,100,0,0),
(207440,92,-334.852,4623.55,29.2234,0,0,0,0,0,0,100,0,0),
(207440,93,-366.625,4612.06,33.1131,0,0,0,0,0,0,100,0,0),
(207440,94,-399.533,4596.57,35.9587,0,0,0,0,0,0,100,0,0),
(207440,95,-434.477,4569.99,41.5734,0,0,0,0,0,0,100,0,0),
(207440,96,-458.814,4532.94,42.7947,0,0,0,0,0,0,100,0,0),
(207440,97,-459.201,4499.94,43.5241,0,0,0,0,0,0,100,0,0),
(207440,98,-436.701,4466.9,48.1491,0,0,0,0,0,0,100,0,0),
(207440,99,-404.347,4450.62,50.7948,0,0,0,0,0,0,100,0,0),
(207440,100,-369.726,4440.14,53.6683,0,0,0,0,0,0,100,0,0),
(207440,101,-350.131,4400.74,54.9511,0,0,0,0,0,0,100,0,0),
(207440,102,-368.37,4365.98,54.7398,0,0,0,0,0,0,100,0,0),
(207440,103,-399.652,4354.84,55.5756,0,0,0,0,0,0,100,0,0),
(207440,104,-434.103,4346.85,51.4056,0,0,0,0,0,0,100,0,0),
(207440,105,-461.217,4352.53,45.5626,0,0,0,0,0,0,100,0,0),
(207440,106,-500.059,4340.42,44.298,0,0,0,0,0,0,100,0,0),
(207440,107,-533.084,4334.37,46.3151,0,0,0,0,0,0,100,0,0),
(207440,108,-566.285,4333.22,48.8021,0,0,0,0,0,0,100,0,0),
(207440,109,-599.451,4323.44,51.2819,0,0,0,0,0,0,100,0,0),
(207440,110,-632.495,4319.49,53.1237,0,0,0,0,0,0,100,0,0),
(207440,111,-665.078,4315.03,52.7626,0,0,0,0,0,0,100,0,0),
(207440,112,-697.137,4300.47,50.6427,0,0,0,0,0,0,100,0,0),
(207440,113,-733.118,4277.9,49.285,0,0,0,0,0,0,100,0,0),
(207440,114,-767.801,4255.56,47.3728,0,0,0,0,0,0,100,0,0),
(207440,115,-733.118,4277.9,49.285,0,0,0,0,0,0,100,0,0),
(207440,116,-697.137,4300.47,50.6427,0,0,0,0,0,0,100,0,0),
(207440,117,-665.078,4315.03,52.7626,0,0,0,0,0,0,100,0,0),
(207440,118,-632.495,4319.49,53.1237,0,0,0,0,0,0,100,0,0),
(207440,119,-599.451,4323.44,51.2819,0,0,0,0,0,0,100,0,0),
(207440,120,-566.285,4333.22,48.8021,0,0,0,0,0,0,100,0,0),
(207440,121,-533.084,4334.37,46.3151,0,0,0,0,0,0,100,0,0),
(207440,122,-500.059,4340.42,44.298,0,0,0,0,0,0,100,0,0),
(207440,123,-461.217,4352.53,45.5626,0,0,0,0,0,0,100,0,0),
(207440,124,-434.103,4346.85,51.4056,0,0,0,0,0,0,100,0,0),
(207440,125,-399.652,4354.84,55.5756,0,0,0,0,0,0,100,0,0),
(207440,126,-368.37,4365.98,54.7398,0,0,0,0,0,0,100,0,0),
(207440,127,-350.122,4400.75,54.924,0,0,0,0,0,0,100,0,0),
(207440,128,-369.715,4440.15,53.664,0,0,0,0,0,0,100,0,0),
(207440,129,-404.347,4450.62,50.7948,0,0,0,0,0,0,100,0,0),
(207440,130,-436.659,4466.83,48.2739,0,0,0,0,0,0,100,0,0),
(207440,131,-459.207,4499.93,43.6103,0,0,0,0,0,0,100,0,0),
(207440,132,-458.82,4532.93,42.7657,0,0,0,0,0,0,100,0,0),
(207440,133,-434.477,4569.99,41.5734,0,0,0,0,0,0,100,0,0),
(207440,134,-399.533,4596.57,35.9587,0,0,0,0,0,0,100,0,0),
(207440,135,-366.625,4612.06,33.1131,0,0,0,0,0,0,100,0,0),
(207440,136,-334.852,4623.55,29.2234,0,0,0,0,0,0,100,0,0),
(207440,137,-300.929,4633.15,25.2724,0,0,0,0,0,0,100,0,0),
(207440,138,-267.39,4641.45,21.8357,0,0,0,0,0,0,100,0,0),
(207440,139,-239.877,4665.91,13.3524,0,0,0,0,0,0,100,0,0),
(207440,140,-221.055,4699.67,10.5983,0,0,0,0,0,0,100,0,0),
(207440,141,-191.269,4722.75,16.2274,0,0,0,0,0,0,100,0,0),
(207440,142,-154.248,4726.24,21.9866,0,0,0,0,0,0,100,0,0),
(207440,143,-107.191,4732.78,29.807,0,0,0,0,0,0,100,0,0),
(207440,144,-67.4076,4710.77,30.0692,0,0,0,0,0,0,100,0,0),
(207440,145,-34.8304,4681.64,37.9052,0,0,0,0,0,0,100,0,0),
(207440,146,-2.57292,4647.69,43.62,0,0,0,0,0,0,100,0,0),
(207440,147,-0.46951,4614.63,51.3763,0,0,0,0,0,0,100,0,0),
(207440,148,-36.3085,4585.75,44.7704,0,0,0,0,0,0,100,0,0),
(207440,149,-75.0497,4562.87,45.3859,0,0,0,0,0,0,100,0,0),
(207440,150,-82.4793,4530.54,51.6583,0,0,0,0,0,0,100,0,0),
(207440,151,-99.5126,4498.7,56.1267,0,0,0,0,0,0,100,0,0),
(207440,152,-136.282,4466.99,49.9481,0,0,0,0,0,0,100,0,0),
(207440,153,-155.772,4434.49,49.3343,0,0,0,0,0,0,100,0,0),
(207440,154,-163.181,4399.01,56.4079,0,0,0,0,0,0,100,0,0),
(207440,155,-158.442,4368.46,64.9498,0,0,0,0,0,0,100,0,0),
(207440,156,-154.714,4334.83,74.365,0,0,0,0,0,0,100,0,0),
(207440,157,-152.965,4302.89,81.3509,0,0,0,0,0,0,100,0,0),
(207440,158,-152.312,4268.78,85.5575,0,0,0,0,0,0,100,0,0),
(207440,159,-148.851,4232.51,91.2716,0,0,0,0,0,0,100,0,0),
(207440,160,-162.809,4199.44,90.6338,0,0,0,0,0,0,100,0,0),
(207440,161,-177.99,4166.21,93.6494,0,0,0,0,0,0,100,0,0),
(207440,162,-201.889,4134.47,96.5774,0,0,0,0,0,0,100,0,0),
(207440,163,-234.175,4100.88,98.1129,0,0,0,0,0,0,100,0,0),
(207440,164,-268.089,4066.42,99.8858,0,0,0,0,0,0,100,0,0),
(207440,165,-280.555,4032.91,99.6772,0,0,0,0,0,0,100,0,0),
(207440,166,-284.821,3999.43,95.6608,0,0,0,0,0,0,100,0,0),
(207440,167,-280.555,4032.91,99.6772,0,0,0,0,0,0,100,0,0),
(207440,168,-284.821,3999.43,95.6608,0,0,0,0,0,0,100,0,0),
(207440,169,-281.065,3966.37,90.6101,0,0,0,0,0,0,100,0,0),
(207440,170,-258.878,3923.02,86.5352,0,0,0,0,0,0,100,0,0),
(207440,171,-218.794,3912.22,89.495,0,0,0,0,0,0,100,0,0),
(207440,172,-176.817,3933.93,95.9551,0,0,0,0,0,0,100,0,0),
(207440,173,-147.196,3966,102.895,0,0,0,0,0,0,100,0,0),
(207440,174,-120.57,4000.12,99.9497,0,0,0,0,0,0,100,0,0),
(207440,175,-98.9026,4033.89,99.071,0,0,0,0,0,0,100,0,0),
(207440,176,-100.548,4054.84,97.91,0,0,0,0,0,0,100,0,0),
(207440,177,-66.31,4079.69,91.5263,0,0,0,0,0,0,100,0,0),
(207440,178,-23.3349,4101.4,80.0859,0,0,0,0,0,0,100,0,0),
(207440,179,2.12999,4137.95,80.4278,0,0,0,0,0,0,100,0,0),
(207440,180,45.6713,4135.7,68.5212,0,0,0,0,0,0,100,0,0),
(207440,181,85.4328,4132.02,64.2376,0,0,0,0,0,0,100,0,0),
(207440,182,109.234,4099.74,63.3308,0,0,0,0,0,0,100,0,0),
(207440,183,113.803,4066.55,66.9174,0,0,0,0,0,0,100,0,0),
(207440,184,118.048,4033.41,72.3944,0,0,0,0,0,0,100,0,0),
(207440,185,124.133,3999.05,74.097,0,0,0,0,0,0,100,0,0),
(207440,186,105.522,3967.61,75.1717,0,0,0,0,0,0,100,0,0),
(207440,187,67.2801,3958.62,78.4276,0,0,0,0,0,0,100,0,0),
(207440,188,33.1158,3945.06,84.5701,0,0,0,0,0,0,100,0,0),
(207440,189,-1.55914,3919.69,87.3096,0,0,0,0,0,0,100,0,0),
(207440,190,-46.7582,3898.51,90.7201,0,0,0,0,0,0,100,0,0),
(207440,191,-72.9999,3867.36,86.8742,0,0,0,0,0,0,100,0,0),
(207440,192,-86.0801,3832.75,80.5333,0,0,0,0,0,0,100,0,0),
(207440,193,-118.531,3799.95,77.0677,0,0,0,0,0,0,100,0,0),
(207440,194,-124.016,3766.16,70.7898,0,0,0,0,0,0,100,0,0),
(207440,195,-140.103,3732.41,63.8843,0,0,0,0,0,0,100,0,0),
(207440,196,-133.336,3689.05,57.4929,0,0,0,0,0,0,100,0,0),
(207440,197,-100.295,3660.26,63.4818,0,0,0,0,0,0,100,0,0),
(207440,198,-70.5209,3632.55,69.0837,0,0,0,0,0,0,100,0,0),
(207440,199,-45.7444,3599.06,74.0089,0,0,0,0,0,0,100,0,0),
(207440,200,-26.714,3566.52,70.8811,0,0,0,0,0,0,100,0,0),
(207440,201,-21.4935,3533.51,63.0324,0,0,0,0,0,0,100,0,0),
(207440,202,-15.1254,3501.03,62.2086,0,0,0,0,0,0,100,0,0),
(207440,203,0.283963,3467.11,64.0203,0,0,0,0,0,0,100,0,0),
(207440,204,-13.7357,3434.71,66.1294,0,0,0,0,0,0,100,0,0),
(207440,205,-40.614,3398.47,60.584,0,0,0,0,0,0,100,0,0),
(207440,206,-72.0116,3365.6,48.7388,0,0,0,0,0,0,100,0,0),
(207440,207,-92.168,3331.03,33.6334,0,0,0,0,0,0,100,0,0),
(207440,208,-91.1508,3298.84,25.3296,0,0,0,0,0,0,100,0,0),
(207440,209,-93.1454,3265.91,16.2309,0,0,0,0,0,0,100,0,0),
(207440,210,-76.417,3232.38,11.4572,0,0,0,0,0,0,100,0,0),
(207440,211,-57.8723,3199.41,3.82308,0,0,0,0,0,0,100,0,0),
(207440,212,-49.5957,3167.35,-2.1486,0,0,0,0,0,0,100,0,0),
(207440,213,-33.8047,3153.53,-1.4247,0,0,0,0,0,0,100,0,0),
(207440,214,-0.276367,3146.73,-1.13905,0,0,0,0,0,0,100,0,0),
(207440,215,32.5957,3143.96,2.77748,0,0,0,0,0,0,100,0,0),
(207440,216,67.2601,3145.43,13.887,0,0,0,0,0,0,100,0,0),
(207440,217,97.2362,3156.74,21.0718,0,0,0,0,0,0,100,0,0),
(207440,218,134.764,3124.98,21.341,0,0,0,0,0,0,100,0,0),
(207440,219,168.31,3120.54,24.0803,0,0,0,0,0,0,100,0,0),
(207440,220,199.141,3119.61,27.3165,0,0,0,0,0,0,100,0,0),
(207440,221,234.287,3111.5,27.4512,0,0,0,0,0,0,100,0,0),
(207440,222,268.301,3085.21,24.0903,0,0,0,0,0,0,100,0,0),
(207440,223,301.011,3066.45,24.5162,0,0,0,0,0,0,100,0,0),
(207440,224,333.3,3061.4,24.1609,0,0,0,0,0,0,100,0,0),
(207440,225,366.186,3053.95,19.5121,0,0,0,0,0,0,100,0,0),
(207440,226,398.9,3055.89,15.3652,0,0,0,0,0,0,100,0,0),
(207440,227,435.457,3053.02,15.3178,0,0,0,0,0,0,100,0,0),
(207440,228,468.111,3044.12,17.1177,0,0,0,0,0,0,100,0,0),
(1335390,1,-732.521,2967.13,21.6502,0,0,0,0,0,0,100,0,0),
(1335390,2,-766.563,2949.09,17.1086,0,0,0,0,0,0,100,0,0),
(1335390,3,-798.149,2944.98,13.1871,0,0,0,0,0,0,100,0,0),
(1335390,4,-834.777,2934.65,9.85154,0,0,0,0,0,0,100,0,0),
(1335390,5,-870.04,2939.39,7.7136,0,0,0,0,0,0,100,0,0),
(1335390,6,-900.704,2963.75,9.89994,0,0,0,0,0,0,100,0,0),
(1335390,7,-914.543,2998.09,12.2299,0,0,0,0,0,0,100,0,0),
(1335390,8,-913.788,3034.17,11.4389,0,0,0,0,0,0,100,0,0),
(1335390,9,-903.848,3067.35,14.9007,0,0,0,0,0,0,100,0,0),
(1335390,10,-907.572,3103.68,15.3813,0,0,0,0,0,0,100,0,0),
(1335390,11,-932.497,3117.87,18.8434,0,0,0,0,0,0,100,0,0),
(1335390,12,-966.535,3132.36,26.7815,0,0,0,0,0,0,100,0,0),
(1335390,13,-999.144,3127.2,29.5831,0,0,0,0,0,0,100,0,0),
(1335390,14,-1029.84,3092.15,26.9111,0,0,0,0,0,0,100,0,0),
(1335390,15,-1063.29,3069.25,23.2745,0,0,0,0,0,0,100,0,0),
(1335390,16,-1096.24,3065.61,23.2051,0,0,0,0,0,0,100,0,0),
(1335390,17,-1130.2,3067.4,25.5055,0,0,0,0,0,0,100,0,0),
(1335390,18,-1161.4,3056.22,24.1615,0,0,0,0,0,0,100,0,0),
(1335390,19,-1191.53,3054.65,23.472,0,0,0,0,0,0,100,0,0),
(1335390,20,-1223.27,3049.02,23.4648,0,0,0,0,0,0,100,0,0),
(1335390,21,-1260.76,3032.55,20.8215,0,0,0,0,0,0,100,0,0),
(1335390,22,-1280.69,2998.9,14.079,0,0,0,0,0,0,100,0,0),
(1335390,23,-1265.08,2969.53,9.71926,0,0,0,0,0,0,100,0,0),
(1335390,24,-1224.35,2945.39,3.43227,0,0,0,0,0,0,100,0,0),
(1335390,25,-1187.76,2933.76,1.5134,0,0,0,0,0,0,100,0,0),
(1335390,26,-1153.03,2915.35,-2.19043,0,0,0,0,0,0,100,0,0),
(1335390,27,-1124.94,2894.54,-4.56398,0,0,0,0,0,0,100,0,0),
(1335390,28,-1085.52,2886.75,-2.79943,0,0,0,0,0,0,100,0,0),
(1335390,29,-1048.08,2868.97,-3.48706,0,0,0,0,0,0,100,0,0),
(1335390,30,-1018.02,2856.44,-7.50401,0,0,0,0,0,0,100,0,0),
(1335390,31,-996.57,2833.21,-4.83355,0,0,0,0,0,0,100,0,0),
(1335390,32,-999.518,2800.76,-3.54437,0,0,0,0,0,0,100,0,0),
(1335390,33,-996.498,2765.78,1.23279,0,0,0,0,0,0,100,0,0),
(1335390,34,-991.26,2732.51,8.23124,0,0,0,0,0,0,100,0,0),
(1335390,35,-990.855,2697.28,10.9832,0,0,0,0,0,0,100,0,0),
(1335390,36,-980.114,2664.96,13.5454,0,0,0,0,0,0,100,0,0),
(1335390,37,-972.622,2631.13,11.6274,0,0,0,0,0,0,100,0,0),
(1335390,38,-972.299,2600.28,8.48388,0,0,0,0,0,0,100,0,0),
(1335390,39,-982.403,2558.57,2.91633,0,0,0,0,0,0,100,0,0),
(1335390,40,-1012.68,2533.63,8.0978,0,0,0,0,0,0,100,0,0),
(1335390,41,-1037.11,2523.45,12.1586,0,0,0,0,0,0,100,0,0),
(1335390,42,-1074.16,2498.22,18.3654,0,0,0,0,0,0,100,0,0),
(1335390,43,-1101.45,2462.78,26.3193,0,0,0,0,0,0,100,0,0),
(1335390,44,-1111.97,2432.59,29.7793,0,0,0,0,0,0,100,0,0),
(1335390,45,-1100.19,2392.05,22.6832,0,0,0,0,0,0,100,0,0),
(1335390,46,-1067.9,2382.87,18.7957,0,0,0,0,0,0,100,0,0),
(1335390,47,-1034.68,2363.56,13.371,0,0,0,0,0,0,100,0,0),
(1335390,48,-1000.88,2347.8,6.70033,0,0,0,0,0,0,100,0,0),
(1335390,49,-965.974,2330.7,0.460269,0,0,0,0,0,0,100,0,0),
(1335390,50,-927.816,2298.15,-1.1027,0,0,0,0,0,0,100,0,0),
(1335390,51,-917.94,2265.43,2.46791,0,0,0,0,0,0,100,0,0),
(1335390,52,-893.119,2232.19,7.74885,0,0,0,0,0,0,100,0,0),
(1335390,53,-861.357,2199.43,8.52931,0,0,0,0,0,0,100,0,0),
(1335390,54,-831.426,2173.86,10.3407,0,0,0,0,0,0,100,0,0),
(1335390,55,-800.596,2157.28,13.1139,0,0,0,0,0,0,100,0,0),
(1335390,56,-767.263,2144.27,18.5315,0,0,0,0,0,0,100,0,0),
(1335390,57,-723.516,2131.91,25.5801,0,0,0,0,0,0,100,0,0),
(1335390,58,-684.689,2130.01,35.9732,0,0,0,0,0,0,100,0,0),
(1335390,59,-658.025,2095.6,47.8372,0,0,0,0,0,0,100,0,0),
(1335390,60,-650.502,2060.37,55.2743,0,0,0,0,0,0,100,0,0),
(1335390,61,-652.909,2032.13,58.2534,0,0,0,0,0,0,100,0,0),
(1335390,62,-656.163,2001.09,59.1695,0,0,0,0,0,0,100,0,0),
(1335390,63,-661.998,1968.73,56.8962,0,0,0,0,0,0,100,0,0),
(1335390,64,-634.51,1955.99,68.9892,0,0,0,0,0,0,100,0,0),
(1335390,65,-600.355,1959.18,81.7968,0,0,0,0,0,0,100,0,0),
(1335390,66,-567.365,1961.81,83.2272,0,0,0,0,0,0,100,0,0),
(1335390,67,-533.417,1964.81,81.8031,0,0,0,0,0,0,100,0,0),
(1335390,68,-496.362,1975.11,85.6557,0,0,0,0,0,0,100,0,0),
(1335390,69,-464.185,2001.29,89.5226,0,0,0,0,0,0,100,0,0),
(1335390,70,-445.972,2035.4,92.1427,0,0,0,0,0,0,100,0,0),
(1335390,71,-429.907,2066.63,92.4416,0,0,0,0,0,0,100,0,0),
(1335390,72,-428.927,2098.56,89.4321,0,0,0,0,0,0,100,0,0),
(1335390,73,-433.845,2132.34,86.0786,0,0,0,0,0,0,100,0,0),
(1335390,74,-443.687,2168.23,78.5328,0,0,0,0,0,0,100,0,0),
(1335390,75,-448.92,2199.05,67.1812,0,0,0,0,0,0,100,0,0),
(1335390,76,-464.401,2225.98,60.135,0,0,0,0,0,0,100,0,0),
(1335390,77,-474.866,2266.15,49.0582,0,0,0,0,0,0,100,0,0),
(1335390,78,-460.553,2299.43,46.1543,0,0,0,0,0,0,100,0,0),
(1335390,79,-433.011,2332.24,42.078,0,0,0,0,0,0,100,0,0),
(1335390,80,-396.732,2353.48,42.8037,0,0,0,0,0,0,100,0,0),
(1335390,81,-364.287,2352.71,44.9563,0,0,0,0,0,0,100,0,0),
(1335390,82,-333.041,2331.04,50.2793,0,0,0,0,0,0,100,0,0),
(1335390,83,-300.742,2304.88,53.2914,0,0,0,0,0,0,100,0,0),
(1335390,84,-264.549,2295.51,59.5124,0,0,0,0,0,0,100,0,0),
(1335390,85,-236.38,2291.84,54.6061,0,0,0,0,0,0,100,0,0),
(1335390,86,-197.01,2279.36,62.0657,0,0,0,0,0,0,100,0,0),
(1335390,87,-168.441,2300.09,67.016,0,0,0,0,0,0,100,0,0),
(1335390,88,-137.249,2333.82,64.5669,0,0,0,0,0,0,100,0,0),
(1335390,89,-106.825,2366.73,58.6023,0,0,0,0,0,0,100,0,0),
(1335390,90,-68.1914,2391.66,54.53,0,0,0,0,0,0,100,0,0),
(1335390,91,-33.7658,2410.91,56.7162,0,0,0,0,0,0,100,0,0),
(1335390,92,-1.32129,2436.35,52.7468,0,0,0,0,0,0,100,0,0),
(1335390,93,35.6428,2450.32,52.1388,0,0,0,0,0,0,100,0,0),
(1335390,94,69.0965,2447.91,54.1903,0,0,0,0,0,0,100,0,0),
(1335390,95,101.983,2444.25,54.0684,0,0,0,0,0,0,100,0,0),
(1335390,96,134.159,2445.56,53.7802,0,0,0,0,0,0,100,0,0),
(1335390,97,165.08,2432.3,56.372,0,0,0,0,0,0,100,0,0),
(1335390,98,203.656,2408.95,54.8423,0,0,0,0,0,0,100,0,0),
(1335390,99,242.644,2383.21,62.6752,0,0,0,0,0,0,100,0,0),
(1335390,100,276.482,2374.36,71.0905,0,0,0,0,0,0,100,0,0),
(1335390,101,299.087,2355.43,73.8245,0,0,0,0,0,0,100,0,0),
(1335390,102,307.074,2322.83,70.3607,0,0,0,0,0,0,100,0,0),
(1335390,103,300.557,2283.77,66.7484,0,0,0,0,0,0,100,0,0),
(1335390,104,283.475,2246.74,60.1864,0,0,0,0,0,0,100,0,0),
(1335390,105,246.457,2215.66,49.9256,0,0,0,0,0,0,100,0,0),
(1335390,106,221.522,2207.65,44.0602,0,0,0,0,0,0,100,0,0),
(1335390,107,184.861,2186.64,51.0992,0,0,0,0,0,0,100,0,0),
(1335390,108,157.354,2158.1,67.8151,0,0,0,0,0,0,100,0,0),
(1335390,109,160.427,2127.58,64.0297,0,0,0,0,0,0,100,0,0),
(1335390,110,162.018,2093.28,57.3012,0,0,0,0,0,0,100,0,0),
(1335390,111,152.338,2052.43,51.2036,0,0,0,0,0,0,100,0,0),
(1335390,112,123.923,2027.7,50.1405,0,0,0,0,0,0,100,0,0),
(1335390,113,96.5347,2007.72,48.177,0,0,0,0,0,0,100,0,0),
(1335390,114,59.6804,2009.18,69.5647,0,0,0,0,0,0,100,0,0),
(1335390,115,23.393,2016.13,73.229,0,0,0,0,0,0,100,0,0),
(1335390,116,-8.93327,1981.9,74.6931,0,0,0,0,0,0,100,0,0),
(1335390,117,-40.392,1951.23,74.8118,0,0,0,0,0,0,100,0,0),
(1335390,118,-52.3153,1918.97,68.582,0,0,0,0,0,0,100,0,0),
(1335390,119,-50.9455,1885.91,67.1805,0,0,0,0,0,0,100,0,0),
(1335390,120,-34.8478,1851.8,60.2007,0,0,0,0,0,0,100,0,0),
(1335390,121,-50.9455,1885.91,67.1805,0,0,0,0,0,0,100,0,0),
(1335390,122,-52.2988,1918.87,68.6909,0,0,0,0,0,0,100,0,0),
(1335390,123,-40.392,1951.23,74.8118,0,0,0,0,0,0,100,0,0),
(1335390,124,-8.93327,1981.9,74.6931,0,0,0,0,0,0,100,0,0),
(1335390,125,23.393,2016.13,73.229,0,0,0,0,0,0,100,0,0),
(1335390,126,59.6804,2009.18,69.5647,0,0,0,0,0,0,100,0,0),
(1335390,127,96.5347,2007.72,48.177,0,0,0,0,0,0,100,0,0),
(1335390,128,123.923,2027.7,50.1405,0,0,0,0,0,0,100,0,0),
(1335390,129,152.276,2052.32,51.2525,0,0,0,0,0,0,100,0,0),
(1335390,130,161.955,2093.17,57.3068,0,0,0,0,0,0,100,0,0),
(1335390,131,160.427,2127.58,64.0297,0,0,0,0,0,0,100,0,0),
(1335390,132,157.354,2158.1,67.8151,0,0,0,0,0,0,100,0,0),
(1335390,133,184.861,2186.64,51.0992,0,0,0,0,0,0,100,0,0),
(1335390,134,221.522,2207.65,44.0602,0,0,0,0,0,0,100,0,0),
(1335390,135,246.457,2215.66,49.9256,0,0,0,0,0,0,100,0,0),
(1335390,136,283.475,2246.74,60.1864,0,0,0,0,0,0,100,0,0),
(1335390,137,300.557,2283.77,66.7484,0,0,0,0,0,0,100,0,0),
(1335390,138,307.074,2322.83,70.3607,0,0,0,0,0,0,100,0,0),
(1335390,139,299.087,2355.43,73.8245,0,0,0,0,0,0,100,0,0),
(1335390,140,276.553,2374.34,71.0536,0,0,0,0,0,0,100,0,0),
(1335390,141,242.644,2383.21,62.6752,0,0,0,0,0,0,100,0,0),
(1335390,142,203.656,2408.95,54.8423,0,0,0,0,0,0,100,0,0),
(1335390,143,165.16,2432.24,56.3749,0,0,0,0,0,0,100,0,0),
(1335390,144,134.159,2445.56,53.7802,0,0,0,0,0,0,100,0,0),
(1335390,145,101.983,2444.25,54.0684,0,0,0,0,0,0,100,0,0),
(1335390,146,69.0965,2447.91,54.1903,0,0,0,0,0,0,100,0,0),
(1335390,147,35.6428,2450.32,52.1388,0,0,0,0,0,0,100,0,0),
(1335390,148,-1.32129,2436.35,52.7468,0,0,0,0,0,0,100,0,0),
(1335390,149,-33.7658,2410.91,56.7162,0,0,0,0,0,0,100,0,0),
(1335390,150,-68.0807,2391.69,54.572,0,0,0,0,0,0,100,0,0),
(1335390,151,-106.825,2366.73,58.6023,0,0,0,0,0,0,100,0,0),
(1335390,152,-137.249,2333.82,64.5669,0,0,0,0,0,0,100,0,0),
(1335390,153,-168.441,2300.09,67.016,0,0,0,0,0,0,100,0,0),
(1335390,154,-197.01,2279.36,62.0657,0,0,0,0,0,0,100,0,0),
(1335390,155,-236.38,2291.84,54.6061,0,0,0,0,0,0,100,0,0),
(1335390,156,-264.549,2295.51,59.5124,0,0,0,0,0,0,100,0,0),
(1335390,157,-300.742,2304.88,53.2914,0,0,0,0,0,0,100,0,0),
(1335390,158,-332.955,2330.97,50.2507,0,0,0,0,0,0,100,0,0),
(1335390,159,-364.287,2352.71,44.9563,0,0,0,0,0,0,100,0,0),
(1335390,160,-396.732,2353.48,42.8037,0,0,0,0,0,0,100,0,0),
(1335390,161,-433.011,2332.24,42.078,0,0,0,0,0,0,100,0,0),
(1335390,162,-460.553,2299.43,46.1543,0,0,0,0,0,0,100,0,0),
(1335390,163,-474.866,2266.15,49.0582,0,0,0,0,0,0,100,0,0),
(1335390,164,-464.401,2225.98,60.135,0,0,0,0,0,0,100,0,0),
(1335390,165,-448.92,2199.05,67.1812,0,0,0,0,0,0,100,0,0),
(1335390,166,-443.687,2168.23,78.5328,0,0,0,0,0,0,100,0,0),
(1335390,167,-433.845,2132.34,86.0786,0,0,0,0,0,0,100,0,0),
(1335390,168,-428.927,2098.56,89.4321,0,0,0,0,0,0,100,0,0),
(1335390,169,-429.907,2066.63,92.4416,0,0,0,0,0,0,100,0,0),
(1335390,170,-445.972,2035.4,92.1427,0,0,0,0,0,0,100,0,0),
(1335390,171,-464.185,2001.29,89.5226,0,0,0,0,0,0,100,0,0),
(1335390,172,-496.362,1975.11,85.6557,0,0,0,0,0,0,100,0,0),
(1335390,173,-533.417,1964.81,81.8031,0,0,0,0,0,0,100,0,0),
(1335390,174,-567.365,1961.81,83.2272,0,0,0,0,0,0,100,0,0),
(1335390,175,-600.355,1959.18,81.7968,0,0,0,0,0,0,100,0,0),
(1335390,176,-634.51,1955.99,68.9892,0,0,0,0,0,0,100,0,0),
(1335390,177,-661.998,1968.73,56.8962,0,0,0,0,0,0,100,0,0),
(1335390,178,-656.163,2001.09,59.1695,0,0,0,0,0,0,100,0,0),
(1335390,179,-652.909,2032.13,58.2534,0,0,0,0,0,0,100,0,0),
(1335390,180,-650.52,2060.31,55.2255,0,0,0,0,0,0,100,0,0),
(1335390,181,-658.043,2095.54,47.9485,0,0,0,0,0,0,100,0,0),
(1335390,182,-684.689,2130.01,35.9732,0,0,0,0,0,0,100,0,0),
(1335390,183,-723.516,2131.91,25.5801,0,0,0,0,0,0,100,0,0),
(1335390,184,-767.263,2144.27,18.5315,0,0,0,0,0,0,100,0,0),
(1335390,185,-800.515,2157.22,13.0072,0,0,0,0,0,0,100,0,0),
(1335390,186,-831.426,2173.86,10.3407,0,0,0,0,0,0,100,0,0),
(1335390,187,-861.357,2199.43,8.52931,0,0,0,0,0,0,100,0,0),
(1335390,188,-893.119,2232.19,7.74885,0,0,0,0,0,0,100,0,0),
(1335390,189,-917.94,2265.43,2.46791,0,0,0,0,0,0,100,0,0),
(1335390,190,-927.816,2298.15,-1.1027,0,0,0,0,0,0,100,0,0),
(1335390,191,-965.974,2330.7,0.460269,0,0,0,0,0,0,100,0,0),
(1335390,192,-1000.88,2347.8,6.70033,0,0,0,0,0,0,100,0,0),
(1335390,193,-1034.68,2363.56,13.371,0,0,0,0,0,0,100,0,0),
(1335390,194,-1067.9,2382.87,18.7957,0,0,0,0,0,0,100,0,0),
(1335390,195,-1100.19,2392.05,22.6832,0,0,0,0,0,0,100,0,0),
(1335390,196,-1111.97,2432.59,29.7793,0,0,0,0,0,0,100,0,0),
(1335390,197,-1101.45,2462.78,26.3193,0,0,0,0,0,0,100,0,0),
(1335390,198,-1074.16,2498.22,18.3654,0,0,0,0,0,0,100,0,0),
(1335390,199,-1037.11,2523.45,12.1586,0,0,0,0,0,0,100,0,0),
(1335390,200,-1012.68,2533.63,8.0978,0,0,0,0,0,0,100,0,0),
(1335390,201,-982.403,2558.57,2.91633,0,0,0,0,0,0,100,0,0),
(1335390,202,-972.299,2600.28,8.48388,0,0,0,0,0,0,100,0,0),
(1335390,203,-972.622,2631.13,11.6274,0,0,0,0,0,0,100,0,0),
(1335390,204,-980.114,2664.96,13.5454,0,0,0,0,0,0,100,0,0),
(1335390,205,-990.871,2697.23,10.9134,0,0,0,0,0,0,100,0,0),
(1335390,206,-991.26,2732.51,8.23124,0,0,0,0,0,0,100,0,0),
(1335390,207,-996.498,2765.78,1.23279,0,0,0,0,0,0,100,0,0),
(1335390,208,-999.518,2800.76,-3.54437,0,0,0,0,0,0,100,0,0),
(1335390,209,-996.57,2833.21,-4.83355,0,0,0,0,0,0,100,0,0),
(1335390,210,-1018.02,2856.44,-7.50401,0,0,0,0,0,0,100,0,0),
(1335390,211,-1048.08,2868.97,-3.48706,0,0,0,0,0,0,100,0,0),
(1335390,212,-1085.52,2886.75,-2.79943,0,0,0,0,0,0,100,0,0),
(1335390,213,-1124.94,2894.54,-4.56398,0,0,0,0,0,0,100,0,0),
(1335390,214,-1153.03,2915.35,-2.19043,0,0,0,0,0,0,100,0,0),
(1335390,215,-1187.76,2933.76,1.5134,0,0,0,0,0,0,100,0,0),
(1335390,216,-1224.35,2945.39,3.43227,0,0,0,0,0,0,100,0,0),
(1335390,217,-1265.08,2969.53,9.71926,0,0,0,0,0,0,100,0,0),
(1335390,218,-1280.69,2998.9,14.079,0,0,0,0,0,0,100,0,0),
(1335390,219,-1260.76,3032.55,20.8215,0,0,0,0,0,0,100,0,0),
(1335390,220,-1223.27,3049.02,23.4648,0,0,0,0,0,0,100,0,0),
(1335390,221,-1191.53,3054.65,23.472,0,0,0,0,0,0,100,0,0),
(1335390,222,-1161.4,3056.22,24.1615,0,0,0,0,0,0,100,0,0),
(1335390,223,-1130.2,3067.4,25.5055,0,0,0,0,0,0,100,0,0),
(1335390,224,-1096.27,3065.61,23.0976,0,0,0,0,0,0,100,0,0),
(1335390,225,-1063.29,3069.25,23.2745,0,0,0,0,0,0,100,0,0),
(1335390,226,-1029.84,3092.15,26.9111,0,0,0,0,0,0,100,0,0),
(1335390,227,-999.144,3127.2,29.5831,0,0,0,0,0,0,100,0,0),
(1335390,228,-966.555,3132.36,26.7762,0,0,0,0,0,0,100,0,0),
(1335390,229,-932.497,3117.87,18.8434,0,0,0,0,0,0,100,0,0),
(1335390,230,-907.572,3103.68,15.3813,0,0,0,0,0,0,100,0,0),
(1335390,231,-903.848,3067.35,14.9007,0,0,0,0,0,0,100,0,0),
(1335390,232,-913.788,3034.17,11.4389,0,0,0,0,0,0,100,0,0),
(1335390,233,-914.561,2998.17,12.2134,0,0,0,0,0,0,100,0,0),
(1335390,234,-900.704,2963.75,9.89994,0,0,0,0,0,0,100,0,0),
(1335390,235,-870.04,2939.39,7.7136,0,0,0,0,0,0,100,0,0),
(1335390,236,-834.777,2934.65,9.85154,0,0,0,0,0,0,100,0,0),
(1335390,237,-798.149,2944.98,13.1871,0,0,0,0,0,0,100,0,0),
(1335390,238,-766.563,2949.09,17.1086,0,0,0,0,0,0,100,0,0);

-- Fix loot chance for the following quest items

-- 10754 = Amulet of Sevine
-- 10755 = Amulet of Allistarj
-- 23580 = Avruu's Orb
-- 25719 = Arakkoa Feather
-- 25807 = Timber Worg Tail
-- 25837 = Ironjaw's Pelt
-- 25891 = Pristine Shimmerscale Eel
-- 27861 = Lathrai's Stolen Goods
-- 29588 = Burning Legion Missive
-- 62919 = Claw of Tichondrius

DELETE FROM `creature_loot_template` WHERE `entry` = 18461 AND `item` = 25891;
DELETE FROM `creature_loot_template` WHERE `entry` = 18541 AND `item` = 27861;
DELETE FROM `creature_loot_template` WHERE `entry` IN (17035, 17053) AND `item` = 23580;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16772, 18453, 18463, 18464, 18466, 18595) AND `item` = 25807;
DELETE FROM `creature_loot_template` WHERE `entry` IN (18464, 18477) AND `item` = 25837;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16946, 16947, 16954, 16960) AND `item` = 29588;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` IN (23580, 29588);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (10754, 10755, 25837, 62919);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` = 25891;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 27861;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -25 WHERE `entry` IN (18476, 18477) AND `item` = 25807;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -10 WHERE `entry` = 18670 AND `item` = 25807;

-- Arakkoa Feather
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` = 25719;  -- Set all initially to 50%, specific entries follow
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `entry` = 18533 AND `item` = 25719;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -60 WHERE `entry` IN (18539, 18540, 18541, 18685) AND `item` = 25719;

-- Fix fishing dailies

-- "Stocking Up" fishing daily for Lake Whitefish (69912) in Darnassus has incorrect chance and extra record
-- "Bait Bandits" Blackfin Darter (34865) is incorrectly not marked as a quest item

DELETE FROM `fishing_loot_template` WHERE `entry` = 141 AND `item` = 69912;

UPDATE `fishing_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `entry` = 1657 AND `item` = 69912;
UPDATE `fishing_loot_template` SET `ChanceOrQuestChance` = -10 WHERE `entry` = 3519 AND `item` = 34865;

-- Fix game object chance

-- 938 = Muddy Journal Pages
-- 4483 = Burning Key
-- 4484 = Cresting Key
-- 4485 = Thundering Key
-- 25638 = Eye of Veil Reskk
-- 25642 = Eye of Veil Shienor
-- 25745 = Olemba Seed
-- 25841 = Draenei Vessel
-- 58205 = Mosh'Ogg Bounty
-- 58281 = Fang of Shadra
-- 59524 = Narkk's Handbombs
-- 60214 = Kurzen Compound Prison Records
-- 60215 = Kurzen Compound Officers' Dossier
-- 60295 = Bloodscalp Lore Tablet

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (938, 4483, 4484, 4485, 25638, 25642, 25745, 25841, 58205, 58281, 59524, 60214, 60215, 60295);

-- Remove duplicated quest

-- 26782 = The Mosh'Ogg Bounty

DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` = 26782;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 26782, 0, '', '', 'Duplicate quest: The Mosh''Ogg Bounty');

-- Fix loot chance for the following quest items

-- 3863 = Jungle Stalker Feather
-- 4469 = Rod of Order
-- 4473 = Eldritch Shackles
-- 4482 = Sealed Folder

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` IN (3863);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (4469, 4473, 4482);

-- Fix creatures in Arathi Highlands, incorrect min/max levels

-- 2557 = Witherbark Shadow Hunter
-- 2573 = Drywhisker Surveyor
-- 2574 = Drywhisker Digger
-- 2602 = Ruul Onestone (Rare)
-- 2605 = Zalas Witherbark (Rare)
-- 2611 = Fozruk
-- 2619 = Hammerfall Grunt
-- 5350 = Qirot
-- 5937 = Vile Sting
-- 14661 = Stinglasher
-- 51000 = Blackshell the Impenetrable

UPDATE `creature_template` SET `minlevel` = 27, `maxlevel` = 27, `ScaleLevelMin` = 25, `ScaleLevelMax` = 60 WHERE `entry` IN (2557, 2573, 2574, 2602, 2605, 2611, 2619);
UPDATE `creature_template` SET `minlevel` = 35, `maxlevel` = 35, `ScaleLevelMin` = 35, `ScaleLevelMax` = 60 WHERE `entry` IN (5350, 14661);
UPDATE `creature_template` SET `minlevel` = 40, `maxlevel` = 40, `ScaleLevelMin` = 40, `ScaleLevelMax` = 60 WHERE `entry` IN (5937, 51000);

-- Fix quest that is incorrectly marked as Alliance

-- 26023 = The Forsaken Trollbane

UPDATE `quest_template` SET `AllowableRaces` = 234881970 WHERE `ID` = 26023;