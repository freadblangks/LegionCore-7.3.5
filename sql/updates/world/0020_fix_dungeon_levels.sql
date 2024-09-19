-- Fix creature levels in Stormwind Stockade

-- 1708 = Defias Inmate
-- 1720 = Bruegal Ironknuckle
-- 46248 = Riverpaw Basher
-- 46249 = Riverpaw Slayer
-- 46250 = Riverpaw Poacher
-- 46251 = Riverpaw Looter
-- 46252 = Riverpaw Shaman
-- 46254 = Hogger
-- 46260 = Searing Destroyer
-- 46261 = Enraged Fire Elemental
-- 46262 = Rumbling Earth
-- 46263 = Slag Fury
-- 46264 = Lord Overheat
-- 46375 = Rowdy Troublemaker
-- 46379 = Vicious Thug
-- 46381 = Shifty Thief
-- 46382 = Petty Criminal
-- 46383 = Randolph Moloch

UPDATE `creature_template` SET `minlevel` = 20, `maxlevel` = 20, `ScaleLevelMin` = 20, `ScaleLevelMax` = 60 WHERE `entry` IN (1708, 1720, 46248, 46249, 46250, 46251, 46252, 46254, 46260, 46261, 46262, 46263, 46264, 46375, 46379, 46381, 46382, 46383);