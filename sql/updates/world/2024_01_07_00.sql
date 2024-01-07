-- Remove deprecated quest

-- 24527 = Your Path Begins Here (Removed in 7.0.3 per Wowpedia)

DELETE FROM `quest_template` WHERE `ID` = 24527;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `QuestMaxScalingLevel`, `QuestPackageID`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoney`, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `RewardArtifactXP`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `StartItem`, `Flags`, `FlagsEx`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `FactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `FactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `FactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `FactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `FactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `QuestRewardID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `StartScript`, `CompleteScript`, `VerifiedBuild`) VALUES
(24527, 2, 3, -1, 0, 2, -82, 21, 0, 0, 3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 524288, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890, 878, 0, 0, 1028, 0, 0, '[DEPRECATED]Your Path Begins Here', 'Reach Level 3 to learn Primal Strike, and then use Primal Strike 2 times on a Training Dummy near the entrance of Anvilmar.', "Excellent!  Let us begin.$b$bAs you grow along your journey, you will unlocked the ancient secrets of shamans.\r\rPrimal Strike is the first such skill.  The primal spirits, when called upon, will strengthen your arm to deliver a mighty blow.$b$bHelpful, isn't it?", '', 'Return to Teo Hammerstorm in Anvilmar.', '', '', '', '', 0, 0, 19865);

DELETE FROM `quest_template_addon` WHERE `ID` = 24527;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RewardMailTitle`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(24527, 0, 64, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0);

-- Fix loot chance for the following quest items

-- 13157 = Fetid Skull
-- 15785 = Zaeldarr's Head
-- 60983 = Crypt Bile
-- 60987 = Joseph's Hunting Blade
-- 62028 = Browman's Wrappings

DELETE FROM `creature_loot_template` WHERE `item` IN (13157,15785,60983,60987,62028);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`, `shared`) VALUES
(8529, 13157, -80, 0, 0, 1, 1, 0),
(12250, 15785, -100, 0, 0, 1, 1, 0),

(8555, 60983, -85, 0, 0, 1, 1, 0),
(8556, 60983, -85, 0, 0, 1, 1, 0),
(8557, 60983, -85, 0, 0, 1, 1, 0),
(8558, 60983, -85, 0, 0, 1, 1, 0),

(45450, 60987, -100, 0, 0, 1, 1, 0),
(46167, 62028, -100, 0, 0, 1, 1, 0);

-- Fix quests that should NOT be repeatable!
-- 27388 = Heroes of Darrowshire
-- 28755 = Annals of the Silver Hand

DELETE FROM `quest_template_addon` WHERE `id` IN (27388,28755);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RewardMailTitle`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(28755, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0),
(27388, 0, 0, 0, 0, 27390, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0);