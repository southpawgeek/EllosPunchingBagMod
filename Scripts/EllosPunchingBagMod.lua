ModUtil.RegisterMod("EllosPunchingBagMod")

local nameLookup = {
	-- aphrodite
	AphroditeMaxSuperCharm = "Aphrodite's Aid (MAX)", --
	AreaWeakenAphrodite = "Wave of Despair",       --
	DeathAreaWeakenAphrodite = "Dying Lament",     --
	AphroditeSuperCharm = "Aphrodite's Aid",
	-- ares
	AresSurgeWeapon = "Ares' Aid",
	DelayedDamage = "Doom", --
	-- artemis
	ArtemisShoutWeapon = "Artemis' Aid",
	ArtemisMaxShoutWeapon = "Artemis' Aid (MAX)", --
	ArtemisLegendary = "Support Fire",         --
	ArtemisAmmoWeapon = "Exit Wounds",
	-- athena
	AthenaShout = "Athena's Aid",
	MagicShieldRetaliate = "Holy Shield",
	-- demeter
	DemeterSuper = "Demeter's Aid",
	DemeterMaxSuper = "Demeter's Aid (MAX)",
	DemeterMaxChill = "Arctic Blast",
	DemeterAmmoWind = "Snow Burst",
	DemeterWorldChill = "Decay",
	ChillRetaliate = "Frozen Touch",
	-- dionysus
	DionysusShout = "Dionysus' Aid",
	DamageOverTime = "Hangover",
	-- poseidon
	DamageOverDistance = "Rupture",
	PoseidonCollisionBlast = "Breaking Wave",
	PoseidonSurfWeapon = "Poseidon's Aid",
	-- zeus
	ZeusShout = "Zeus' Aid",
	LightningStrikeSecondary = "Thunder Flourish", --
	LightningStrikeImpact = "Sea Storm",
	ZeusLegendaryWeapon = "Splitting Bolt",
	LightningDash = "Thunder Dash",
	ZeusAttackBolt = "Jolted",
	ZeusDionysusCloudStrike = "Scintillating Feast",
	ZeusAmmoWeapon = "Lightning Rod",
	ChainLightning = "Chain Lightning",
	LightningPerfectDash = "Lightning Reflexes",
	LightningStrikeRetaliate = "Heaven's Vengeance",
	-- misc
	RangedWeapon = "Cast",
	BaseCollisionWeapon = "Collision",
	-- fist
	FistDetonationDamage = "Maim",
	FistSpecialVacuum = "Magnetic Cutter",
	FistWeaponSpecialDash = "Dash-Upper",
	FistWeaponLandAreaAttack = "Quake Cutter",
	-- rail
	GunBombImmolation = "Hellfire DoT",
	GunBombWeapon = "Hellfire Detonation",
	-- shield
	ShieldWeaponRush = "Bull Rush",
	-- bow
	DamageShare = "Shared Suffering",
	-- spear
	SpearWeaponSpin3 = "Spin (MAX)",
	SpearWeaponThrowReturn = "Recall",
	SpearRushWeapon = "Raging Rush",
	-- companions
	NPC_FurySister_01_Assist = "Megaera",
	NPC_Thanatos_01_Assist = "Thanatos",
	NPC_Sisyphus_01_Assist = "Sisyphus/Bouldy",
	NPC_Patroclus_01_Assist = "Achilles/Patroclus"
}

local damageBucket = {
	SwordWeapon = "Attack",
	SwordWeapon2 = "Attack",
	SwordWeapon3 = "Attack",
	SwordParry = "Special",
	SwordWeaponDash = "Dash-Strike",
	SpearWeapon = "Attack",
	SpearWeapon2 = "Attack",
	SpearWeapon3 = "Attack",
	SpearWeaponThrow = "Special",
	SpearWeaponDash = "Dash-Strike",
	SpearWeaponSpin = "Spin",
	SpearWeaponSpin2 = "Spin",
	BowWeapon = "Attack",
	BowSplitShot = "Special",
	BowWeaponDash = "Dash-Strike",
	FistWeapon = "Attack",
	FistWeapon2 = "Attack",
	FistWeapon3 = "Attack",
	FistWeapon4 = "Attack",
	FistWeapon5 = "Attack",
	FistWeaponSpecial = "Special",
	FistWeaponDash = "Dash-Strike",
	FistDetonationWeapon = "Special",
	ShieldWeapon = "Attack",
	ShieldThrow = "Special",
	ShieldWeaponDash = "Dash-Strike",
	GunWeapon = "Attack",
	ThanatosDeathCurseAoE = "Thanatos Rival",
	ThanatosCurse = "Thanatos Rival",
	RubbleFall = "Environmental",
	RubbleFallElysium = "Environmental",
	RubbleFallLarge = "Environmental",
	LavaTileWeapon = "Magma",
	LavaTileTriangle01Weapon = "Magma",
	LavaTileTriangle02Weapon = "Magma",
	LavaSplash = "Magma",
	BlastCubeExplosion = "Trap",
	BlastCubeExplosionElysium = "Trap",
	ArcherTrapWeapon = "Trap",
	AxeTrapWeapon = "Trap",
	SawTrapWeapon = "Trap",
	SpikeTrapWeapon = "Trap",
	PhalanxTrapWeapon = "Trap",
	DartTrapWeapon = "Trap"
}

local enemyBucket = {
	"LightRanged",
	"DisembodiedHand",
	"PunchingBag",
	"Wretch",
	"BloodMine",
	"Harpy",   -- sisters
	"FreezeShot", -- dusa stone
	"SpreadShotMiniboss",
	"Bloodless",
	"Hydra",
	"SplitShot",
	"ChariotRam",
	"Shade",
	"Crawler",
	"HadesBident",
	"HadesAmmo",
	"HadesGrasping",
	"HadesCast",
	"Swarmer",
	"StyxPoison"
}

local config = {
	DpsInterval = 99999999
}
EllosPunchingBagMod.config = config

--[[
Fixed Size List Implementation
TODO: Move to new file and import?
]]

EllosPunchingBagMod.List = {}
function EllosPunchingBagMod.List.new(maxSize)
	return { first = 0, last = -1, count = 0, max = maxSize }
end

function EllosPunchingBagMod.List.addValue(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
	list.count = list.count + 1
	if list.count > list.max then
		EllosPunchingBagMod.List.removeHead(list)
	end
end

function EllosPunchingBagMod.List.removeHead(list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil -- to allow garbage collection
	list.first = first + 1
	list.count = list.count - 1
	return value
end

function EllosPunchingBagMod.List.emptyList(list)
	while list.count > 0 do
		EllosPunchingBagMod.List.removeHead(list)
	end
end

EllosPunchingBagMod.DamageHistory = EllosPunchingBagMod.List.new(10000)    -- 100 * config.DpsInterval )
EllosPunchingBagMod.DpsUpdateThread = false
EllosPunchingBagMod.DpsBars = {}
EllosPunchingBagMod.LastDpsPosition = {}
EllosPunchingBagMod.LastDpsBackgroundPosition = {}

--[[
HELPER FUNCTIONS ------------------------------------------
]]
function calculateDps(list)
	-- Dum up damage dealt from each source
	local totalDamage = 0
	local earliestTimestamp = 999999;
	local latestTimestamp = 0;
	local totalDamageBySource = {}
	for i = list.first, list.last do
		local damageData = list[i]
		local time = GetTime({})
		if damageData.Timestamp > (time - config.DpsInterval) then
			totalDamage = totalDamage + damageData.Damage
			totalDamageBySource[damageData.Source] = (totalDamageBySource[damageData.Source] or 0) + damageData.Damage
			if damageData.Timestamp < earliestTimestamp then
				earliestTimestamp = damageData.Timestamp
			end
			if damageData.Timestamp > latestTimestamp then
				latestTimestamp = damageData.Timestamp
			end
		end
	end

	-- Sort sources from most damage to least
	local dps = round(totalDamage / (latestTimestamp - earliestTimestamp))
	sourcesSortedByDamage = {}
	for source in pairs(totalDamageBySource) do table.insert(sourcesSortedByDamage, source) end
	table.sort(sourcesSortedByDamage, function(a, b)
		return totalDamageBySource[a] < totalDamageBySource[b]
	end)
	local maxDamage = totalDamageBySource[sourcesSortedByDamage[#sourcesSortedByDamage]]

	-- UI constants to shift whole UI around
	local initialY = 890
	local xPos = 320   --ScreenCenterX - 550
	local yPos = initialY --ScreenCenterY - 200

	-- Delete any existing UI (e.g the bars from last update)
	-- TODO: Consider resizing / renaming bars instead of destroying and recreating (no performance issues so far though)
	for bar, component in pairs(EllosPunchingBagMod.DpsBars) do
		Destroy({ Id = component.Id })
		EllosPunchingBagMod.DpsBars[bar] = nil
	end

	-- Create UI to show DPS bars for each source
	for i, source in ipairs(sourcesSortedByDamage) do
		createDpsBar(source, totalDamageBySource[source], maxDamage, totalDamage, xPos, yPos)
		yPos = yPos - 20
	end

	-- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
	if #sourcesSortedByDamage > 0 then
		createDpsHeader("DpsMeter", totalDamage, dps, xPos, yPos - 5)
		local margin = 40
		local width = 500
		local height = (initialY - yPos + margin)
		createDpsOverlayBackground("DpsBackground", xPos + margin, yPos - 20 + height / 2, width, height)
	else
		Destroy({ Id = ScreenAnchors["DpsMeter"] })
		Destroy({ Id = ScreenAnchors["DpsBackground"] })
		ScreenAnchors["DpsMeter"] = nil
		ScreenAnchors["DpsBackground"] = nil
	end
end

-- Creates a transparent background behind the dps.  Resizes and moves the existing component if this is called with new height and position
function createDpsOverlayBackground(obstacleName, x, y, width, height)
	if ScreenAnchors[obstacleName] ~= nil then
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = EllosPunchingBagMod.LastDpsBackgroundPosition.y -
		y, Speed = 1000 })
	else
		ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "rectangle01", X = x, Y = y }) -- width 480, height 267
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		SetColor({ Id = ScreenAnchors[obstacleName], Color = { 0.090, 0.055, 0.157, 0.6 } })
	end
	EllosPunchingBagMod.LastDpsBackgroundPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function createDpsBar(label, damage, maxDamage, totalDamage, x, y, color)
	local portion = damage / totalDamage
	local scale = damage / maxDamage * .6
	local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })
	SetAnimation({ Name = "BarGraphBar", DestinationId = dpsBar.Id })
	EllosPunchingBagMod.DpsBars["DpsBar" .. label] = dpsBar

	-- Create source name label
	--if string.len(label) >= 18 then
	--label = string.sub(label, 1, 15) .. "..."
	--end
	CreateTextBox({
		Id = dpsBar.Id,
		Text = label,
		OffsetX = -30,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Right"
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

	-- Scale damage bar
	SetScaleX({ Id = dpsBar.Id, Fraction = scale, Duration = 0.0 })

	-- Create damage total label
	if scale > .06 then
		CreateTextBox({
			Id = dpsBar.Id,
			Text = damage,
			OffsetX = 320 * scale - 4,
			OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			FontSize = 10,
			Justification = "Right",
			Color = Color.Black
		})
		ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })
	end

	-- Create damage portion percentage label
	CreateTextBox({
		Id = dpsBar.Id,
		Text = "(" .. math.floor(portion * 100 + .5) .. "%)",
		OffsetX = 320 * scale + 20,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Left"
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })
end

-- Create a header that shows overall DPS and overall damage total
function createDpsHeader(obstacleName, totalDamage, dps, x, y)
	fontSize = 14
	color = Color.White
	local text = dps .. " DPS  |  Total Damage: " .. totalDamage

	if ScreenAnchors[obstacleName] ~= nil then
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], Text = text })
		Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = EllosPunchingBagMod.LastDpsPosition.y - y, Speed = 1000 })
	else
		ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "BlankObstacle", X = x, Y = y })
		CreateTextBox({
			Id = ScreenAnchors[obstacleName],
			Text = text,
			OffsetX = 0,
			OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			FontSize = 14,
			Justification = "Left"
		})
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], FadeTarget = 1, FadeDuration = 0.0 })
	end

	EllosPunchingBagMod.LastDpsPosition.y = y
end

function checkEnemyBucket(source)
	for k, v in pairs(enemyBucket) do
		if string.find(source, v, 1) then
			return true
		end
	end
	return false
end

--[[
OVERRIDES ------------------------------------------
]]

-- After the damage enemy call, record the instance of damage
ModUtil.WrapBaseFunction("DamageEnemy", function(baseFunc, victim, triggerArgs)
	local preHitHealth = victim.Health
	baseFunc(victim, triggerArgs)
	--print(TableToJSONString(triggerArgs))
	if (triggerArgs.DamageAmount or 0) > 0 and victim.MaxHealth ~= nil and (triggerArgs.TriggeredByTable.GenusName == "NPC_Skelly_01" or (triggerArgs.TriggeredByTable.GeneratorData or {}).DifficultyRating ~= nil or triggerArgs.TriggeredByTable.CanBeAggroed or triggerArgs.TriggeredByTable.IsBoss) then
		local damageInstance = {}
		damageInstance.Damage = math.min(preHitHealth, triggerArgs.DamageAmount)
		damageInstance.Timestamp = GetTime({})

		-- Check damage source and set its name based on priority EffectName > SourceWeapon > triggerArgs.AttackerWeaponData.Name
		-- If still nil, if the attack was an obstacle, assume it was due to wall slam damage

		-- get an internal name from either SourceWeapon or EffectName
		local source
		if triggerArgs.SourceWeapon ~= nil then
			source = triggerArgs.SourceWeapon
		end
		if triggerArgs.EffectName ~= nil then
			source = triggerArgs.EffectName
		end
		-- check if it's a grouped value
		source = damageBucket[source] or source

		-- if enemy damage is showing up, you either deflected or charmed
		if source ~= nil then
			local isEnemy = checkEnemyBucket(source)
			if isEnemy == true then
				source = "Enemy Deflect/Charm"
			end
		end

		-- if no name and an obstacle is present, assume wall slam
		if source == nil and triggerArgs.AttackerIsObstacle then
			source = "Wall Slam"
		end

		-- if damage source is none of the above, just store it as Unknown
		if source == nil then
			source = "Unknown"
			--print(TableToJSONString(triggerArgs))
		end

		-- try and match with the name lookup table
		source = nameLookup[source] or source

		-- finally, put it in the table
		damageInstance.Source = source

		EllosPunchingBagMod.List.addValue(EllosPunchingBagMod.DamageHistory, damageInstance)
	end
end, EllosPunchingBagMod)

-- When room is unlocked, stop the DPS meter from updating and clear it to prep for next room
ModUtil.WrapBaseFunction("DoUnlockRoomExits", function(baseFunc, run, room)
	baseFunc(run, room)
	EllosPunchingBagMod.DpsUpdateThread = false
	calculateDps(EllosPunchingBagMod.DamageHistory)
	EllosPunchingBagMod.List.emptyList(EllosPunchingBagMod.DamageHistory)
end, EllosPunchingBagMod)

-- Set up a polling loop to update our dps calculation
OnAnyLoad { function()
	if EllosPunchingBagMod.DpsUpdateThread then return end
	EllosPunchingBagMod.DpsUpdateThread = true
	thread(function()
		while EllosPunchingBagMod.DpsUpdateThread do
			-- If in the courtyard, reset your DPS after 5 seconds with no damage dealt
			if ModUtil.PathGet("CurrentDeathAreaRoom") and EllosPunchingBagMod.DamageHistory[EllosPunchingBagMod.DamageHistory.last] ~= nil then
				if GetTime({}) - EllosPunchingBagMod.DamageHistory[EllosPunchingBagMod.DamageHistory.last].Timestamp > 5 then
					EllosPunchingBagMod.List.emptyList(EllosPunchingBagMod.DamageHistory)
				end
			end

			-- Otherwise continuously update
			calculateDps(EllosPunchingBagMod.DamageHistory)
			wait(.2)
		end
	end)
end }
