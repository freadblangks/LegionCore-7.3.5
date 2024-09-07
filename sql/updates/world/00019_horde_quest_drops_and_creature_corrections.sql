-- Fix loot chance for the following quest items

-- 4819 = Fizsprocket's Clipboard (Supposed to be quest only)
-- 20760 = Chieftain Zul'Marosh's Head
-- 22566 = Phantasmal Substance
-- 22567 = Gargoyle Fragment
-- 22579 = Plagued Murloc Spine
-- 22580 = Crystallized Mana Essence
-- 22597 = The Lady's Necklace
-- 22633 = Troll Juju
-- 22634 = Underlight Ore
-- 22639 = Zeb'Sora Troll Ear
-- 22640 = Head of Kel'gash the Wicked
-- 22641 = Rotting Heart (Not supposed to be quest only, it is a repeatable quest)
-- 22642 = Spinal Dust (Not supposed to be quest only, it is a repeatable quest)
-- 22653 = Dar'Khan's Head
-- 22677 = Catlord Claws
-- 22893 = Luzran's Head
-- 22894 = Knucklerot's Head
-- 23165 = Headhunter Axe
-- 23166 = Hexxer Stave
-- 23167 = Shadowcaster Mace
-- 23191 = Crystal Controlling Orb
-- 23249 = Amani Invasion Plans
-- 23707 = Spindleweb Silk Gland
-- 49535 = Stolen Rifle
-- 50473 = Mane of Thornmantle
-- 60874 = Deathless Sinew
-- 60880 = Springvale's Sharpening Stone

DELETE FROM `creature_loot_template` WHERE `entry` = 16346 AND `item` = 22677;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16348, 16469) AND `item` = 23165;
DELETE FROM `creature_loot_template` WHERE `entry` = 16345 AND `item` = 23166;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16344, 16348) AND `item` = 23167;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (4819, 20760, 22566, 22640, 22653, 22893, 22894, 23707, 49535, 50473, 60880);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` IN (22579, 22580, 22633, 22634, 22677, 23165, 23166, 23167);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -70 WHERE `item` = 22567;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` IN (22639, 60874);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -20 WHERE `item` = 23191;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` = 23249;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 10 WHERE `item` = 22597;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 50 WHERE `entry` = 16301 AND `item` = 22641;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 70 WHERE `entry` = 16302 AND `item` = 22641;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 30 WHERE `entry` = 16303 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 70 WHERE `entry` = 16305 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 20 WHERE `entry` = 16307 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 40 WHERE `entry` = 16308 AND `item` = 22642;

-- Fix loot chance for the following game objects

-- 22583 = Rathis Tomber's Supplies
-- 22590 = Night Elf Plans: An'daroth
-- 22591 = Night Elf Plans: An'owyn
-- 22592 = Night Elf Plans: Scrying on the Sin'dorei
-- 22598 = Stone of Light
-- 22599 = Stone of Flame
-- 22674 = Wavefront Medallion
-- 60872 = Moonsteel Ingots

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (22583, 22590, 22591, 22592, 22598, 22599, 22674, 60872);