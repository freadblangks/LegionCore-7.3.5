-- First fix bad database structure
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat1` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat2` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat3` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat4` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat5` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat6` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat7` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat8` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat9` SMALLINT SIGNED NOT NULL default '0';
ALTER TABLE `item_sparse` MODIFY `StatModifierBonusStat10` SMALLINT SIGNED NOT NULL default '0';

-- Fix incorrect vendor prices
-- 122338 = Ancient Heirloom Armor Casing
-- 122339 = Ancient Heirloom Scabbard
-- 122340 = Timeworn Heirloom Armor Casing
-- 122341 = Timeworn Heirloom Scabbard
-- 122361 = Swift Hand of Justice
-- 122362 = Discerning Eye of the Beast
-- 122364 = Sharpened Scarlet Kris
-- 122365 = Reforged Truesilver Champion
-- 122366 = Upgraded Dwarven Hand Cannon
-- 122367 = The Blessed Hammer of Grace
-- 122368 = Grand Staff of Jordan
-- 122369 = Battleworn Thrash Blade
-- 122370 = Inherited Insignia of the Horde
-- 122372 = Strengthened Stockade Pauldrons
-- 122373 = Pristine Lightforge Spaulders
-- 122374 = Prized Beastmaster's Mantle
-- 122375 = Aged Pauldrons of The Five Thunders
-- 122376 = Exceptional Stormshroud Shoulders
-- 122377 = Lasting Feralheart Spaulders
-- 122378 = Exquisite Sunderseer Mantle
-- 122384 = Tattered Dreadmist Robe
-- 122390 = Musty Tome of the Lost
-- 122530 = Inherited Mark of Tyranny
-- 122662 = Eternal Talisman of Evasion
-- 122663 = Eternal Amulet of the Redeemed
-- 122664 = Eternal Horizon Choker
-- 122666 = Eternal Woven Ivy Necklace
-- 122667 = Eternal Emberfury Talisman
-- 122668 = Eternal Will of the Martyr
-- 150744 = Walking Kalimdor with the Earthmother
-- 150745 = The Azeroth Campaign
-- 151614 = Weathered Heirloom Armor Casing
-- 151615 = Weathered Heirloom Scabbard
DELETE FROM `item_sparse` WHERE `ID` IN (122338, 122339, 122340, 122341, 122361, 122362, 122364, 122365, 122366, 122367, 122368, 122369, 122370, 122372, 122373, 122374, 122375, 122376, 122377, 122378, 122384, 122390, 122530, 122662, 122663, 122664, 122666, 122667, 122668, 150744, 150745, 151614, 151615);
INSERT INTO `item_sparse` (`ID`, `AllowableRace`, `Display`, `Display1`, `Display2`, `Display3`, `Description`, `Flags1`, `Flags2`, `Flags3`, `Flags4`, `PriceRandomValue`, `PriceVariance`, `VendorStackCount`, `BuyPrice`, `SellPrice`, `RequiredAbility`, `MaxCount`, `Stackable`, `StatPercentEditor1`, `StatPercentEditor2`, `StatPercentEditor3`, `StatPercentEditor4`, `StatPercentEditor5`, `StatPercentEditor6`, `StatPercentEditor7`, `StatPercentEditor8`, `StatPercentEditor9`, `StatPercentEditor10`, `StatPercentageOfSocket1`, `StatPercentageOfSocket2`, `StatPercentageOfSocket3`, `StatPercentageOfSocket4`, `StatPercentageOfSocket5`, `StatPercentageOfSocket6`, `StatPercentageOfSocket7`, `StatPercentageOfSocket8`, `StatPercentageOfSocket9`, `StatPercentageOfSocket10`, `ItemRange`, `BagFamily`, `QualityModifier`, `DurationInInventory`, `DmgVariance`, `AllowableClass`, `ItemLevel`, `RequiredSkill`, `RequiredSkillRank`, `MinFactionID`, `ItemStatValue1`, `ItemStatValue2`, `ItemStatValue3`, `ItemStatValue4`, `ItemStatValue5`, `ItemStatValue6`, `ItemStatValue7`, `ItemStatValue8`, `ItemStatValue9`, `ItemStatValue10`, `ScalingStatDistributionID`, `ItemDelay`, `PageID`, `StartQuestID`, `LockID`, `RandomSelect`, `ItemRandomSuffixGroupID`, `ItemSet`, `ZoneBound`, `InstanceBound`, `TotemCategoryID`, `SocketMatch_enchantment_id`, `GemProperties`, `LimitCategory`, `RequiredHoliday`, `RequiredTransmogHoliday`, `ItemNameDescriptionID`, `OverallQualityID`, `InventoryType`, `RequiredLevel`, `RequiredPVPRank`, `RequiredPVPMedal`, `MinReputation`, `ContainerSlots`, `StatModifierBonusStat1`, `StatModifierBonusStat2`, `StatModifierBonusStat3`, `StatModifierBonusStat4`, `StatModifierBonusStat5`, `StatModifierBonusStat6`, `StatModifierBonusStat7`, `StatModifierBonusStat8`, `StatModifierBonusStat9`, `StatModifierBonusStat10`, `DamageDamageType`, `Bonding`, `LanguageID`, `PageMaterialID`, `Material`, `SheatheType`, `SocketType1`, `SocketType2`, `SocketType3`, `SpellWeightCategory`, `SpellWeight`, `ArtifactID`, `ExpansionID`, `VerifiedBuild`) VALUES
(122338, -1, 'Ancient Heirloom Armor Casing', '', '', '', '', 134221888, 155648, 512, 0, 0.9965, 0, 1, 10000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122339, -1, 'Ancient Heirloom Scabbard', '', '', '', '', 134221888, 155648, 512, 0, 1.0001, 0, 1, 12000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122340, -1, 'Timeworn Heirloom Armor Casing', '', '', '', '', 134221888, 155648, 512, 0, 1.0038, 0, 1, 20000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122341, -1, 'Timeworn Heirloom Scabbard', '', '', '', '', 134221888, 155648, 512, 0, 1.0075, 0, 1, 50000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122361, -1, 'Swift Hand of Justice', '', '', '', '', 134217728, 155648, 0, 0, 1.0074, 0, 1, 7000000, 0, 0, 0, 1, 6666, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 896, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 36, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122362, -1, 'Discerning Eye of the Beast', '', '', '', '', 134217728, 155648, 0, 0, 1.0375, 0, 1, 7000000, 0, 0, 0, 1, 6666, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 5, 7, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122364, -1, 'Sharpened Scarlet Kris', '', '', '', '', 134217728, 139264, 0, 0, 1.0449, 0, 1, 6500000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 899, 1800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 13, 0, 0, 0, 0, 0, 3, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 26365),
(122365, -1, 'Reforged Truesilver Champion', '', '', '', '', 134217728, 139264, 0, 0, 1.0486, 0, 1, 7500000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 900, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 17, 0, 0, 0, 0, 0, 4, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122366, -1, 'Upgraded Dwarven Hand Cannon', '', '', '', '', 134217728, 139264, 0, 0, 0.9521, 0, 1, 7500000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0.6, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 901, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 26, 0, 0, 0, 0, 0, 3, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122367, -1, 'The Blessed Hammer of Grace', '', '', '', '', 134217728, 139776, 0, 0, 0.9558, 0, 1, 6500000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 66935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.25, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 902, 2600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 13, 0, 0, 0, 0, 0, 5, 7, 36, 255, 255, 5, 255, 255, 255, 255, 0, 1, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 26365),
(122368, -1, 'Grand Staff of Jordan', '', '', '', '', 134217728, 139776, 0, 0, 0.9595, 0, 1, 7500000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 28689, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.3, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 903, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 17, 0, 0, 0, 0, 0, 5, 7, 36, 255, 255, 5, 255, 255, 255, 255, 0, 1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 26365),
(122369, -1, 'Battleworn Thrash Blade', '', '', '', '', 134742016, 139264, 0, 0, 0.9631, 0, 1, 6500000, 0, 0, 0, 1, 7889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 904, 2600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 13, 0, 0, 0, 0, 0, 7, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 26365),
(122370, 234881970, 'Inherited Insignia of the Horde', '', '', '', '', 134217728, 155648, 0, 0, 0.9668, 0, 1, 7000000, 0, 0, 1, 1, 7889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 905, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 7, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122372, -1, 'Strengthened Stockade Pauldrons', '', '', '', '', 134217728, 139264, 0, 0, 0.9742, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 907, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 74, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122373, -1, 'Pristine Lightforge Spaulders', '', '', '', '', 134217728, 139264, 0, 0, 0.9778, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 3506, 3506, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 908, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 74, 7, 32, 36, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122374, -1, 'Prized Beastmaster''s Mantle', '', '', '', '', 134217728, 139264, 0, 0, 0.9815, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 909, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 73, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122375, -1, 'Aged Pauldrons of The Five Thunders', '', '', '', '', 134217728, 139264, 0, 0, 0.9852, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 910, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 73, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122376, -1, 'Exceptional Stormshroud Shoulders', '', '', '', '', 134217728, 139264, 0, 0, 0.9889, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 73, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122377, -1, 'Lasting Feralheart Spaulders', '', '', '', '', 134217728, 139264, 0, 0, 0.9925, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 73, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122378, -1, 'Exquisite Sunderseer Mantle', '', '', '', '', 134217728, 139264, 0, 0, 1.0227, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 913, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 0, 0, 0, 0, 0, 5, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122384, -1, 'Tattered Dreadmist Robe', '', '', '', '', 134217728, 155648, 0, 0, 1.0447, 0, 1, 10000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 919, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 20, 1, 0, 0, 0, 0, 5, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122390, -1, 'Musty Tome of the Lost', '', '', '', '', 134217728, 155648, 0, 0, 0.9667, 0, 1, 5000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 925, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 23, 1, 0, 0, 0, 0, 5, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122530, -1, 'Inherited Mark of Tyranny', '', '', '', '', 134217728, 155648, 0, 0, 1.0188, 0, 1, 7000000, 0, 0, 1, 1, 7889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 930, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 7, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(122662, -1, 'Eternal Talisman of Evasion', '', '', '', '', 134217728, 155648, 0, 0, 1.015, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 931, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 4, 7, 40, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122663, -1, 'Eternal Amulet of the Redeemed', '', '', '', '', 134217728, 155648, 0, 0, 1.0186, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 5, 7, 40, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122664, -1, 'Eternal Horizon Choker', '', '', '', '', 134217728, 155648, 0, 0, 1.0223, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 933, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 5, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122666, -1, 'Eternal Woven Ivy Necklace', '', '', '', '', 134217728, 155648, 0, 0, 1.0297, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 934, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 3, 7, 40, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122667, -1, 'Eternal Emberfury Talisman', '', '', '', '', 134217728, 155648, 0, 0, 0.9597, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 4, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(122668, -1, 'Eternal Will of the Martyr', '', '', '', '', 134217728, 155648, 0, 0, 0.9634, 1, 1, 7000000, 0, 0, 0, 1, 5259, 7889, 7012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32768, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0, 0, 0, 0, 0, 3, 7, 36, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 26365),
(150744, -1, 'Walking Kalimdor with the Earthmother', '', '', '', 'Mending the scars of the land left by the wicked, corrupt, and unnatural.', 134217728, 139265, 0, 0, 1.0188, 0, 1, 100000000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(150745, -1, 'The Azeroth Campaign', '', '', '', 'A comprehensive strategy to swiftly cripple Eastern Kingdoms forces of the Alliance in the event of the Fourth War.', 134217728, 139265, 0, 0, 1.0224, 0, 1, 100000000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(151614, -1, 'Weathered Heirloom Armor Casing', '', '', '', '', 134221888, 139264, 512, 0, 0.9675, 0, 1, 50000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(151615, -1, 'Weathered Heirloom Scabbard', '', '', '', '', 134221888, 139264, 512, 0, 0.9711, 0, 1, 75000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 26365);

-- Fix incorrect vendor item faction requirements
-- 67525 = Bilgewater Satchel (Horde)
-- 67526 = Darnassus Satchel (Alliance)
-- 67528 = Ironforge Satchel (Alliance)
-- 67529 = Undercity Satchel (Horde)
-- 67530 = Gnomeregan Satchel (Alliance)
-- 67531 = Stormwind Satchel (Alliance)
-- 67532 = Gilnean Satchel (Alliance)
-- 67533 = Orgrimmar Satchel (Horde)
-- 67535 = Silvermoon Satchel (Horde)
-- 67536 = Darkspear Satchel (Horde)
-- 92070 = Huojin Satchel (Horde)
-- 92071 = Tushui Satchel (Alliance)
DELETE FROM `item_sparse` WHERE `ID` IN (67525, 67526, 67528, 67529, 67530, 67531, 67532, 67533, 67535, 67536, 92070, 92071);
INSERT INTO `item_sparse` (`ID`, `AllowableRace`, `Display`, `Display1`, `Display2`, `Display3`, `Description`, `Flags1`, `Flags2`, `Flags3`, `Flags4`, `PriceRandomValue`, `PriceVariance`, `VendorStackCount`, `BuyPrice`, `SellPrice`, `RequiredAbility`, `MaxCount`, `Stackable`, `StatPercentEditor1`, `StatPercentEditor2`, `StatPercentEditor3`, `StatPercentEditor4`, `StatPercentEditor5`, `StatPercentEditor6`, `StatPercentEditor7`, `StatPercentEditor8`, `StatPercentEditor9`, `StatPercentEditor10`, `StatPercentageOfSocket1`, `StatPercentageOfSocket2`, `StatPercentageOfSocket3`, `StatPercentageOfSocket4`, `StatPercentageOfSocket5`, `StatPercentageOfSocket6`, `StatPercentageOfSocket7`, `StatPercentageOfSocket8`, `StatPercentageOfSocket9`, `StatPercentageOfSocket10`, `ItemRange`, `BagFamily`, `QualityModifier`, `DurationInInventory`, `DmgVariance`, `AllowableClass`, `ItemLevel`, `RequiredSkill`, `RequiredSkillRank`, `MinFactionID`, `ItemStatValue1`, `ItemStatValue2`, `ItemStatValue3`, `ItemStatValue4`, `ItemStatValue5`, `ItemStatValue6`, `ItemStatValue7`, `ItemStatValue8`, `ItemStatValue9`, `ItemStatValue10`, `ScalingStatDistributionID`, `ItemDelay`, `PageID`, `StartQuestID`, `LockID`, `RandomSelect`, `ItemRandomSuffixGroupID`, `ItemSet`, `ZoneBound`, `InstanceBound`, `TotemCategoryID`, `SocketMatch_enchantment_id`, `GemProperties`, `LimitCategory`, `RequiredHoliday`, `RequiredTransmogHoliday`, `ItemNameDescriptionID`, `OverallQualityID`, `InventoryType`, `RequiredLevel`, `RequiredPVPRank`, `RequiredPVPMedal`, `MinReputation`, `ContainerSlots`, `StatModifierBonusStat1`, `StatModifierBonusStat2`, `StatModifierBonusStat3`, `StatModifierBonusStat4`, `StatModifierBonusStat5`, `StatModifierBonusStat6`, `StatModifierBonusStat7`, `StatModifierBonusStat8`, `StatModifierBonusStat9`, `StatModifierBonusStat10`, `DamageDamageType`, `Bonding`, `LanguageID`, `PageMaterialID`, `Material`, `SheatheType`, `SocketType1`, `SocketType2`, `SocketType3`, `SpellWeightCategory`, `SpellWeight`, `ArtifactID`, `ExpansionID`, `VerifiedBuild`) VALUES
(67525, -1, 'Bilgewater Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9705, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 1133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67526, -1, 'Darnassus Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9742, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67528, -1, 'Ironforge Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9815, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67529, -1, 'Undercity Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9852, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67530, -1, 'Gnomeregan Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9889, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67531, -1, 'Stormwind Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9925, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67532, -1, 'Gilnean Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9962, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 1134, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67533, -1, 'Orgrimmar Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9999, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67535, -1, 'Silvermoon Satchel', '', '', '', '', 0, 8193, 0, 0, 1.0072, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(67536, -1, 'Darkspear Satchel', '', '', '', '', 0, 8193, 0, 0, 1.0109, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 530, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(92070, -1, 'Huojin Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9701, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 1352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365),
(92071, -1, 'Tushui Satchel', '', '', '', '', 0, 8193, 0, 0, 0.9738, 1, 1, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 63, 0, 0, 1353, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 18, 0, 0, 0, 6, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 26365);

-- Insert matching hotfix data
-- Reference for 'TableHash': https://github.com/TrinityCore/WowPacketParser/blob/master/WowPacketParser/Enums/DB2Hash.cs
DELETE FROM `hotfix_data` WHERE `Id` IN (67525, 67526, 67528, 67529, 67530, 67531, 67532, 67533, 67535, 67536, 92070, 92071, 122338, 122339, 122340, 122341, 122364, 122365, 122366, 122367, 122368, 122369, 122370, 122372, 122373, 122374, 122375, 122376, 122377, 122378, 122384, 122390, 122530, 122662, 122663, 122664, 122666, 122667, 122668, 150744, 150745, 151614, 151615);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(67525, 2442913102, 67525, 0, 0),
(67526, 2442913102, 67526, 0, 0),
(67528, 2442913102, 67528, 0, 0),
(67529, 2442913102, 67529, 0, 0),
(67530, 2442913102, 67530, 0, 0),
(67531, 2442913102, 67531, 0, 0),
(67532, 2442913102, 67532, 0, 0),
(67533, 2442913102, 67533, 0, 0),
(67535, 2442913102, 67535, 0, 0),
(67536, 2442913102, 67536, 0, 0),
(92070, 2442913102, 92070, 0, 0),
(92071, 2442913102, 92071, 0, 0),
(122338, 2442913102, 122338, 0, 0),
(122339, 2442913102, 122339, 0, 0),
(122340, 2442913102, 122340, 0, 0),
(122341, 2442913102, 122341, 0, 0),
(122361, 2442913102, 122361, 0, 0),
(122362, 2442913102, 122362, 0, 0),
(122364, 2442913102, 122364, 0, 0),
(122365, 2442913102, 122365, 0, 0),
(122366, 2442913102, 122366, 0, 0),
(122367, 2442913102, 122367, 0, 0),
(122368, 2442913102, 122368, 0, 0),
(122369, 2442913102, 122369, 0, 0),
(122370, 2442913102, 122370, 0, 0),
(122372, 2442913102, 122372, 0, 0),
(122373, 2442913102, 122373, 0, 0),
(122374, 2442913102, 122374, 0, 0),
(122375, 2442913102, 122375, 0, 0),
(122376, 2442913102, 122376, 0, 0),
(122377, 2442913102, 122377, 0, 0),
(122378, 2442913102, 122378, 0, 0),
(122384, 2442913102, 122384, 0, 0),
(122390, 2442913102, 122390, 0, 0),
(122530, 2442913102, 122530, 0, 0),
(122662, 2442913102, 122662, 0, 0),
(122663, 2442913102, 122663, 0, 0),
(122664, 2442913102, 122664, 0, 0),
(122666, 2442913102, 122666, 0, 0),
(122667, 2442913102, 122667, 0, 0),
(122668, 2442913102, 122668, 0, 0),
(150744, 2442913102, 150744, 0, 0),
(150745, 2442913102, 150745, 0, 0),
(151614, 2442913102, 151614, 0, 0),
(151615, 2442913102, 151615, 0, 0);