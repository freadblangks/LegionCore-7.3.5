-- Fix existing teleport locations
DELETE FROM `game_tele` WHERE `name` = 'Valormok';
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES
(1280, 3006.65, -4151.15, 101.810, 2.5073, 1, 'Valormok');