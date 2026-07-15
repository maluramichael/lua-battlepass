-- ============================================================================
-- Battle Pass — vendor/gossip NPC (entry 90100, referenced by config npc_entry)
-- Added for the mod-playerbots build (DB: acore_world_pb). Clones a known-good
-- gossip NPC so the DisplayID exists in the client DBC.
-- ============================================================================
USE `acore_world_pb`;

DELETE FROM `creature_template` WHERE `entry` = 90100;
CREATE TEMPORARY TABLE `tmp_bp_npc` AS SELECT * FROM `creature_template` WHERE `entry` = 6929;
UPDATE `tmp_bp_npc`
   SET `entry` = 90100,
       `name` = 'Battle Pass Master',
       `subname` = 'Seasonal Rewards',
       `npcflag` = 1,
       `gossip_menu_id` = 0,
       `ScriptName` = '',
       `AIName` = '';
INSERT INTO `creature_template` SELECT * FROM `tmp_bp_npc`;
DROP TEMPORARY TABLE `tmp_bp_npc`;

DELETE FROM `creature_template_model` WHERE `CreatureID` = 90100;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`)
SELECT 90100, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model` WHERE `CreatureID` = 6929;

-- Spawn in Stormwind (Trade District), next to the Hardcore Master
DELETE FROM `creature` WHERE `id1` = 90100;
INSERT INTO `creature`
    (`id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,
     `position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,
     `wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`)
VALUES
    (90100, 0, 0, 0, 1, 1, 0, -8836.0, 625.0, 94.0, 3.6, 300, 0, 0, 1, 0, 0);
