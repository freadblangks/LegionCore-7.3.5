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

-- 48691 = Tattered Dreadmist Robe

DELETE FROM `item_sparse` WHERE `ID` = 48691;

INSERT INTO `item_sparse` (`ID`, `AllowableRace`, `Display`, `Display1`, `Display2`, `Display3`, `Description`, `Flags1`, `Flags2`, `Flags3`, `Flags4`, `PriceRandomValue`, `PriceVariance`, `VendorStackCount`, `BuyPrice`, `SellPrice`, `RequiredAbility`, `MaxCount`, `Stackable`, `StatPercentEditor1`, `StatPercentEditor2`, `StatPercentEditor3`, `StatPercentEditor4`, `StatPercentEditor5`, `StatPercentEditor6`, `StatPercentEditor7`, `StatPercentEditor8`, `StatPercentEditor9`, `StatPercentEditor10`, `StatPercentageOfSocket1`, `StatPercentageOfSocket2`, `StatPercentageOfSocket3`, `StatPercentageOfSocket4`, `StatPercentageOfSocket5`, `StatPercentageOfSocket6`, `StatPercentageOfSocket7`, `StatPercentageOfSocket8`, `StatPercentageOfSocket9`, `StatPercentageOfSocket10`, `ItemRange`, `BagFamily`, `QualityModifier`, `DurationInInventory`, `DmgVariance`, `AllowableClass`, `ItemLevel`, `RequiredSkill`, `RequiredSkillRank`, `MinFactionID`, `ItemStatValue1`, `ItemStatValue2`, `ItemStatValue3`, `ItemStatValue4`, `ItemStatValue5`, `ItemStatValue6`, `ItemStatValue7`, `ItemStatValue8`, `ItemStatValue9`, `ItemStatValue10`, `ScalingStatDistributionID`, `ItemDelay`, `PageID`, `StartQuestID`, `LockID`, `RandomSelect`, `ItemRandomSuffixGroupID`, `ItemSet`, `ZoneBound`, `InstanceBound`, `TotemCategoryID`, `SocketMatch_enchantment_id`, `GemProperties`, `LimitCategory`, `RequiredHoliday`, `RequiredTransmogHoliday`, `ItemNameDescriptionID`, `OverallQualityID`, `InventoryType`, `RequiredLevel`, `RequiredPVPRank`, `RequiredPVPMedal`, `MinReputation`, `ContainerSlots`, `StatModifierBonusStat1`, `StatModifierBonusStat2`, `StatModifierBonusStat3`, `StatModifierBonusStat4`, `StatModifierBonusStat5`, `StatModifierBonusStat6`, `StatModifierBonusStat7`, `StatModifierBonusStat8`, `StatModifierBonusStat9`, `StatModifierBonusStat10`, `DamageDamageType`, `Bonding`, `LanguageID`, `PageMaterialID`, `Material`, `SheatheType`, `SocketType1`, `SocketType2`, `SocketType3`, `SpellWeightCategory`, `SpellWeight`, `ArtifactID`, `ExpansionID`, `VerifiedBuild`) VALUES
(48691, -1, 'Tattered Dreadmist Robe', '', '', '', '', 134221824, 155648, 8388608, 0, 1.0271, 0, 1, 10000000, 0, 0, 0, 1, 5259, 7889, 5259, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 336, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 20, 1, 0, 0, 0, 0, 5, 7, 32, 255, 255, 255, 255, 255, 255, 255, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 26365);