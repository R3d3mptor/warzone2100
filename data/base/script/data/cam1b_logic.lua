-- Generated by wz2lua (implementation file)
version(0) --- version of the script API this script is written for
-- keep track of number of artifacts collected
numart = 0

-- structure limit stuff
-- public	STRUCTURESTAT		powerModuleHack;

-- Briefing stuff
-- , winMsg;

-- Base Under Attack Stuff
hitStruc = nil
attackerObj = nil
t = 0

-- Proximity: Resources

-- Proximity: Artifacts

-- public		INTMESSAGE	art1Msg;
-- Heavy Machine Gun
art1ID = nil

-- public		INTMESSAGE	art2Msg;
-- Power Module
art2ID = nil

-- added by Keith for Sensor Tower Artefact

-- public		INTMESSAGE	art3Msg;
-- Sensor Tower
art3ID = nil

-- public		INTMESSAGE	art4Msg;
-- Power Module
art4ID = nil

-- player Bonus Research topics given at end of mission
-- need to be declared with value >= numResP0, numResP1, etc.
count = 0

-- Proximity: Enemy


obj1Flag = false


-- Win or lose

-- Enemy Tactics


-- Events: Initialise

-- Events: Start

function startEvnt()
	centreViewPos(1728, 6720)
	-- set zoom Level 128x128
	setRadarZoom(0)
	-- stop player building on LZ
	setLandingZone(10, 51, 12, 53)
	-- allow to build stuff
	setStructureLimits(powerGen, numPow, 0)
	setStructureLimits(oilDerrick, numExt, 0)
	setStructureLimits(research, numRes, 0)
	setStructureLimits(factory, numFac, 0)
	setStructureLimits(command, 1, player)
	enableStructure(command, player)
	enableStructure(powerGen, 0)
	enableStructure(oilDerrick, 0)
	enableStructure(research, 0)
	enableStructure(factory, 0)
	
	-- set no time limits (can carry over from previous missions if not set!)
	setReinforcementTime(-1/10.0)
	-- set Mission time limit
	setMissionTime(timeLimit/10.0)
	
	-- Give blip at start
	addMessage(enm2Msg, PROX_MSG, player, false)
	-- give player briefing
	
	-- setEventTrigger(start2Evnt, vidEndTrig);	//flag next stuff after briefing over
	addMessage(MissionBrief, MISS_MSG, 0, true)
	
	deactivateEvent(startEvnt)
end
callbackEvent(startEvnt, CALL_GAMEINIT)

-- Events: Resources

-- Events: Artifacts
function art1TakeEvnt()
	numart = numart + 1
	-- playSound(art1Snd2, player);
	playSoundPos(art1Snd2, player, art1ID.x, art1ID.y, art1ID.z)
	destroyFeature(art1ID)
	-- removeMessage(art1Msg, PROX_MSG, player);
	enableResearch(art1Comp, player)
	deactivateEvent(art1TakeEvnt)
end

function art1PlaceEvnt()
	art1ID = addFeature(crate, art1X, art1Y)
	-- setEventTrigger(art1SeenEvnt, art1SeenTrig);
	conditionalEvent(art1TakeEvnt, "droidInRange(player, art1X, art1Y, 171)", 0.5)
	deactivateEvent(art1PlaceEvnt)
end
conditionalEvent(art1PlaceEvnt, "(destroyed(art1Get))", 0.5)

function art2TakeEvnt()
	numart = numart + 1
	-- playSound(art2Snd2, player);
	playSoundPos(art2Snd2, player, art2ID.x, art2ID.y, art2ID.z)
	destroyFeature(art2ID)
	-- removeMessage(art2Msg, PROX_MSG, player);
	enableResearch(art2Comp, player)
	deactivateEvent(art2TakeEvnt)
end

function art2PlaceEvnt()
	art2ID = addFeature(crate, art2X, art2Y)
	-- setEventTrigger(art2SeenEvnt, art2SeenTrig);
	conditionalEvent(art2TakeEvnt, "droidInRange(player, art2X, art2Y, 171)", 0.5)
	deactivateEvent(art2PlaceEvnt)
end
conditionalEvent(art2PlaceEvnt, "(destroyed(art2Get))", 0.5)

function art3TakeEvnt()
	numart = numart + 1
	destroyFeature(art3ID)
	-- playSound(art3Snd2, player);
	playSoundPos(art3Snd2, player, art3ID.x, art3ID.y, art3ID.z)
	-- removeMessage(art3Msg, PROX_MSG, player);
	enableResearch(art3Comp, player)
	deactivateEvent(art3TakeEvnt)
end

function art3PlaceEvnt()
	art3ID = addFeature(crate, art3X, art3Y)
	-- setEventTrigger(art3SeenEvnt, art3SeenTrig);
	conditionalEvent(art3TakeEvnt, "droidInRange(player, art3X, art3Y, 171)", 0.5)
	deactivateEvent(art3PlaceEvnt)
end
conditionalEvent(art3PlaceEvnt, "(destroyed(art3Get))", 0.5)

function art4TakeEvnt()
	numart = numart + 1
	destroyFeature(art4ID)
	-- playSound(art4Snd2, player);
	playSoundPos(art4Snd2, player, art4ID.x, art4ID.y, art4ID.z)
	-- removeMessage(art4Msg, PROX_MSG, player);
	enableResearch(art4Comp, player)
	deactivateEvent(art4TakeEvnt)
end

function art4PlaceEvnt()
	art4ID = addFeature(crate, art4X, art4Y)
	-- setEventTrigger(art4SeenEvnt, art4SeenTrig);
	conditionalEvent(art4TakeEvnt, "droidInRange(player, art4X, art4Y, 171)", 0.5)
	deactivateEvent(art4PlaceEvnt)
end
conditionalEvent(art4PlaceEvnt, "(destroyed(art4Get))", 0.5)

-- Events: Enemies
function enm0DeadEvnt()
	killStructsInArea(enemy2, REF_WALL, 704, 8896, 2496, 10688, true, true)
	-- remove corner walls in base
	killStructsInArea(enemy2, REF_WALLCORNER, 704, 8896, 2496, 10688, true, false)
	removeMessage(enm0Msg, PROX_MSG, player)
	-- playSound(enm0Snd2, player);
	playSoundPos(enm0Snd2, player, 2112, 9280, 0)
	deactivateEvent(enm0DeadEvnt)
end

function enm0SeenEvnt()
	addMessage(enm0Msg, PROX_MSG, player, false)
	-- playSound(enm0Snd1, player);
	playSoundPos(enm0Snd1, player, 2112, 9280, 0)
	conditionalEvent(enm0DeadEvnt, "(numStructsButNotWallsInArea(enemy2, 704, 8896, 2496, 10688) == 0)", 2.0)
	deactivateEvent(enm0SeenEvnt)
end
conditionalEvent(enm0SeenEvnt, "seenStructInArea(player, enemy2, false, 704, 8896, 2496, 10688)", 1.0)

function enm1DeadEvnt()
	killStructsInArea(enemy1, REF_WALL, 2112, 8768, 5696, 10560, true, true)
	-- remove corner walls in base
	killStructsInArea(enemy1, REF_WALLCORNER, 2112, 8768, 5696, 10560, true, false)
	removeMessage(enm1Msg, PROX_MSG, player)
	-- playSound(enm1Snd2, player);
	playSoundPos(enm1Snd1, player, 4370, 9872, 0)
	deactivateEvent(enm1DeadEvnt)
end

function enm1SeenEvnt()
	addMessage(enm1Msg, PROX_MSG, player, false)
	-- playSound(enm1Snd1, player);
	playSoundPos(enm1Snd1, player, 4370, 9872, 0)
	conditionalEvent(enm1DeadEvnt, "(numStructsButNotWallsInArea(enemy1, 2112, 8768, 5696, 10560) == 0)", 2.0)
	deactivateEvent(enm1SeenEvnt)
end
conditionalEvent(enm1SeenEvnt, "droidHasSeen(enm1, player)", 1.0)

function obj1DeadEvnt()
	removeMessage(obj1Msg, PROX_MSG, player)
	-- playSound(enm1Snd2, player);
	deactivateEvent(obj1DeadEvnt)
end

function obj1SeenEvnt()
	obj1Flag = true
	addMessage(obj1Msg, PROX_MSG, player, false)
	-- playSound(obj1Snd1, player);
	playSoundPos(obj1Snd1, player, 3776, 11328, 0)
	conditionalEvent(obj1DeadEvnt, "(numStructsButNotWallsInArea(enemy2, 2368, 10688, 4416, 12224) == 0)", 2.0)
	deactivateEvent(obj1SeenEvnt)
end
conditionalEvent(obj1SeenEvnt, "droidHasSeen(obj1, player)", 1.0)

function enm2DeadEvnt()
	killStructsInArea(enemy2, REF_WALL, 2240, 12864, 5312, 14400, true, true)
	-- remove corner walls in base
	killStructsInArea(enemy2, REF_WALLCORNER, 2240, 12864, 5312, 14400, true, false)
	removeMessage(enm2Msg, PROX_MSG, player)
	-- playSound(enm2Snd2, player);
	playSoundPos(enm2Snd2, player, 3193, 13806, 0)
	-- show radar tower if missed somehow!
	if not obj1Flag then
		obj1Flag = true
		addMessage(obj1Msg, PROX_MSG, player, false)
		-- playSound(obj1Snd1, player);
		playSoundPos(obj1Snd1, player, 3776, 11328, 0)
		conditionalEvent(obj1DeadEvnt, "(numStructsButNotWallsInArea(enemy1, 2112, 8768, 5696, 10560) == 0)", 2.0)
		deactivateEvent(obj1SeenEvnt)
	end
	deactivateEvent(enm2DeadEvnt)
end
conditionalEvent(enm2DeadEvnt, "(numStructsButNotWallsInArea(enemy2, 2240, 12864, 5312, 14400) == 0)", 2.0)


-- Events: Win or Lose

-- assumes victory already checked
function nextLevEvnt()
	pause(20/10.0)
	-- give bonus research (if req'd)
	count = 0
	while count < numResP0 do
		enableResearch(resP0[count], 0)
		count = count + 1
	end
	
	-- flag next part of map
	C.gameLevel = C.gameLevel + 1
	-- removeMessage(MissionBrief, MISS_MSG, player);
	startMission(BETWEEN, NextLev)
	
	-- End game here for now! (don't try next mission)
	-- gameOver(true);
	
	deactivateEvent(nextLevEvnt)
end

function gameLost()
	gameOverMessage(endMsg, MISS_MSG, 0, false)
	deactivateEvent(gameLost)
end

function lostYetEvnt()
	if not anyDroidsLeft(player) then
		if not anyStructButWallsLeft(player) then
			deactivateEvent(wonYetEvnt)
			-- waits 2 seconds before ending
			repeatingEvent(gameLost, 2.0)
			deactivateEvent(lostYetEvnt)
			deactivateEvent(timeUp)
		end
	end
end
repeatingEvent(lostYetEvnt, 0.5)


-- have all enemies lost yet?
function wonYetEvnt()
	if not anyDroidsLeft(enemy2) then
		if not anyStructButWallsLeft(enemy2) then
			if not anyDroidsLeft(enemy1) then
				if not anyStructButWallsLeft(enemy1) then
					if numart == 4 then
						deactivateEvent(lostYetEvnt)
						repeatingEvent(nextLevEvnt, 0.5)
						deactivateEvent(wonYetEvnt)
						deactivateEvent(timeUp)
					end
				end
			end
		end
	end
end
repeatingEvent(wonYetEvnt, 0.5)

-- cheat button ctrl M
function cheatEvnt()
	repeatingEvent(nextLevEvnt, 0.5)
	deactivateEvent(cheatEvnt)
end
callbackEvent(cheatEvnt, CALL_MISSION_START)

-- Base Under Attack
function baseHit(_hitStruc, _attackerObj)
	if _hitStruc.player ~= C.selectedPlayer then return end
	hitStruc, attackerObj = _hitStruc, _attackerObj -- wz2lua: probably these can be used as function arguments directly
	if t >= 20 then
		t = 0
		if hitStruc ~= nil then
			playSoundPos(attackSnd1, C.selectedPlayer, hitStruc.x, hitStruc.y, hitStruc.z)
		else
			playSound(attackSnd1, C.selectedPlayer)
		end
	end
end
callbackEvent(baseHit, CALL_STRUCT_ATTACKED)

function everySec()
	t = t + 1
end
repeatingEvent(everySec, 1.0)

function seeBaseHit()
	if hitStruc ~= nil then
		centreView(hitStruc)
		-- flag known about!
		t = 0
	end
end
callbackEvent(seeBaseHit, CALL_MISSION_END)

function timeUp()
	deactivateEvent(wonYetEvnt)
	deactivateEvent(lostYetEvnt)
	repeatingEvent(gameLost, 2.0)
	deactivateEvent(timeUp)
end
callbackEvent(timeUp, CALL_MISSION_TIME)


---------- stubs ----------

if gameOverMessage == nil then gameOverMessage = function() print("stub: gameOverMessage"); return 0 end end
if centreView == nil then centreView = function() print("stub: centreView"); return 0 end end
if anyStructButWallsLeft == nil then anyStructButWallsLeft = function() print("stub: anyStructButWallsLeft"); return 0 end end
if enableResearch == nil then enableResearch = function() print("stub: enableResearch"); return 0 end end
if setMissionTime == nil then setMissionTime = function() print("stub: setMissionTime"); return 0 end end
if addFeature == nil then addFeature = function() print("stub: addFeature"); return 0 end end
if anyDroidsLeft == nil then anyDroidsLeft = function() print("stub: anyDroidsLeft"); return 0 end end
if droidInRange == nil then droidInRange = function() print("stub: droidInRange"); return 0 end end
if pause == nil then pause = function() print("stub: pause"); return 0 end end
if removeMessage == nil then removeMessage = function() print("stub: removeMessage"); return 0 end end
if destroyFeature == nil then destroyFeature = function() print("stub: destroyFeature"); return 0 end end
if destroyed == nil then destroyed = function() print("stub: destroyed"); return 0 end end
if setReinforcementTime == nil then setReinforcementTime = function() print("stub: setReinforcementTime"); return 0 end end
if setStructureLimits == nil then setStructureLimits = function() print("stub: setStructureLimits"); return 0 end end
if setLandingZone == nil then setLandingZone = function() print("stub: setLandingZone"); return 0 end end
if playSoundPos == nil then playSoundPos = function() print("stub: playSoundPos"); return 0 end end
if killStructsInArea == nil then killStructsInArea = function() print("stub: killStructsInArea"); return 0 end end
if startMission == nil then startMission = function() print("stub: startMission"); return 0 end end
if setEventTrigger == nil then setEventTrigger = function() print("stub: setEventTrigger"); return 0 end end
if numStructsButNotWallsInArea == nil then numStructsButNotWallsInArea = function() print("stub: numStructsButNotWallsInArea"); return 0 end end
if playSound == nil then playSound = function() print("stub: playSound"); return 0 end end
if droidHasSeen == nil then droidHasSeen = function() print("stub: droidHasSeen"); return 0 end end
if seenStructInArea == nil then seenStructInArea = function() print("stub: seenStructInArea"); return 0 end end
if addMessage == nil then addMessage = function() print("stub: addMessage"); return 0 end end
if setRadarZoom == nil then setRadarZoom = function() print("stub: setRadarZoom"); return 0 end end
if enableStructure == nil then enableStructure = function() print("stub: enableStructure"); return 0 end end
if centreViewPos == nil then centreViewPos = function() print("stub: centreViewPos"); return 0 end end