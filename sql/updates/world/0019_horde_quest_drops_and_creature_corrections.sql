-- Fix loot chance for the following quest items

-- 2858 = Darkhound Blood
-- 3905 = Nezzliok's Head
-- 4435 = Mote of Myzrael
-- 4450 = Sigil Fragment
-- 4512 = Highland Raptor Eye
-- 4751 = Windfury Talon
-- 4752 = Azure Feather
-- 4753 = Bronze Feather
-- 4758 = Prairie Wolf Paw
-- 4759 = Plainstrider Talon
-- 4769 = Trophy Swoop Quill
-- 4801 = Stalker Claws
-- 4802 = Cougar Claws
-- 4803 = Prairie Alpha Tooth
-- 4805 = Flatland Cougar Femur
-- 4819 = Fizsprocket's Clipboard (Supposed to be quest only)
-- 4871 = Searing Collar
-- 4888 = Crawler Mucus
-- 5087 = Plainstrider Beak
-- 5203 = Flatland Prowler Claw
-- 20482 = Arcane Sliver
-- 20483 = Tainted Arcane Sliver
-- 20760 = Chieftain Zul'Marosh's Head
-- 20764 = Prospector Anvilward's Head
-- 20772 = Springpaw Pelt
-- 20797 = Lynx Collar
-- 20799 = Felendren's Head
-- 21757 = Grimscale Murloc Head
-- 21771 = Captain Kelisendra's Cargo
-- 21776 = Captain Kelisendra's Lost Rutters
-- 21781 = Thaelis' Head
-- 21808 = Arcane Core
-- 22566 = Phantasmal Substance
-- 22567 = Gargoyle Fragment
-- 22570 = Plagued Blood Sample
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
-- 47038 = Slab of Venison
-- 47039 = Scout's Orders
-- 47819 = Crystal Pendant
-- 49204 = Secret Rocket Plans
-- 49208 = Mutilated Mistwing Carcass
-- 49535 = Stolen Rifle
-- 49540 = Grunwald's Head
-- 49674 = The Head of Jarrodenus
-- 50018 = Naj'tess' Orb of Corruption
-- 50222 = Wildmane Cat Pelt
-- 50473 = Mane of Thornmantle
-- 52080 = Fresh Crawler Meat
-- 52564 = Burning Blade Spellscroll
-- 57758 = Swine Belly
-- 57879 = Horde Infantry Rations
-- 60874 = Deathless Sinew
-- 60875 = Ghostly Essence
-- 60878 = Silverlaine's Enchanted Crystal
-- 60880 = Springvale's Sharpening Stone
-- 64386 = Yetimus' Twisted Horn
-- 72071 = Stolen Training Supplies
-- 82605 = Corrupted Insignia
-- 87267 = Codex of the Crusade

DELETE FROM `creature_loot_template` WHERE NOT `entry` = 2959 AND `item` = 4801;
DELETE FROM `creature_loot_template` WHERE NOT `entry` = 2960 AND `item` = 4803;
DELETE FROM `creature_loot_template` WHERE `entry` = 16346 AND `item` = 22677;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16348, 16469) AND `item` = 23165;
DELETE FROM `creature_loot_template` WHERE `entry` = 16345 AND `item` = 23166;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16344, 16348) AND `item` = 23167;
DELETE FROM `creature_loot_template` WHERE `entry` = 3117 AND `item` = 47039;
DELETE FROM `creature_loot_template` WHERE NOT `entry` IN (3195, 3196, 3197, 3198, 3199) AND `item` = 52564;

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (3905, 4769, 4801, 4802, 4805, 4819, 20483, 20760, 20764, 20797, 20799, 21781, 21808, 22566, 22640, 22653, 22893, 22894, 23707, 49204, 49535, 49540, 49674, 50018, 50222, 50473, 52080, 57758, 57879, 60878, 60880, 64386, 72071, 87267);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -90 WHERE `item` IN (4751, 4752, 4753);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `item` IN (4435, 4512, 4758, 4759, 4803, 4871, 4888, 5087, 5203, 22570, 22579, 22580, 22633, 22634, 22677, 23165, 23166, 23167, 49208, 52564, 82605);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -70 WHERE `item` IN (20482, 22567, 47038);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -50 WHERE `item` IN (20772, 21757, 21771, 22639, 60874, 60875);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -35 WHERE `item` IN (2858, 4450);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -20 WHERE `item` IN (23191, 47039, 47819);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` = 23249;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 10 WHERE `item` IN (21776, 22597);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 50 WHERE `entry` = 16301 AND `item` = 22641;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 70 WHERE `entry` = 16302 AND `item` = 22641;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 30 WHERE `entry` = 16303 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 70 WHERE `entry` = 16305 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 20 WHERE `entry` = 16307 AND `item` = 22642;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 40 WHERE `entry` = 16308 AND `item` = 22642;

-- Fix loot chance for the following game objects

-- 4863 = Gnomish Tools
-- 4918 = Sack of Supplies
-- 5012 = Fungal Spores
-- 12708 = Crossroads Supply Crate
-- 20743 = Unstable Mana Crystal
-- 20771 = Tainted Soil Sample
-- 22413 = Sin'dorei Armaments
-- 22414 = Antheol's Elemental Grimoire
-- 22583 = Rathis Tomber's Supplies
-- 22590 = Night Elf Plans: An'daroth
-- 22591 = Night Elf Plans: An'owyn
-- 22592 = Night Elf Plans: Scrying on the Sin'dorei
-- 22598 = Stone of Light
-- 22599 = Stone of Flame
-- 22674 = Wavefront Medallion
-- 45004 = Serviceable Arrow
-- 46742 = Stolen Grain
-- 48128 = Mountainfoot Iron
-- 48525 = Recovered Artifacts
-- 48921 = Sarcen Stone
-- 49062 = Goblin Mortar Shell
-- 49094 = Keystone Shard
-- 49207 = Azsharite Sample
-- 52558 = Kul Tiras Treasure
-- 60871 = Moontouched Wood
-- 60872 = Moonsteel Ingots
-- 69919 = Plump Cockroach
-- 69988 = Pine Nut

DELETE FROM `creature_loot_template` WHERE `item` = 48128;

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` IN (4863, 4918, 5012, 12708, 20743, 20771, 22413, 22414, 22583, 22590, 22591, 22592, 22598, 22599, 22674, 45004, 46742, 48128, 48525, 48921, 49062, 49094, 49207, 52558, 60871, 60872, 69919);
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = -100, `mincountOrRef` = 5, `maxcount` = 5 WHERE `item` = 69988;

-- Fix broken "Lily, Oh Lily" quest (can't loot the lillies)
DELETE FROM `conditions` WHERE `SourceEntry` = 69917;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 208833, 69917, 0, 0, 9, 0, 29332, 0, 0, 0, 0, '', '');

UPDATE `gameobject_template` SET `type` = 3 WHERE `entry` = 208833;