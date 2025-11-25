gg_trg_Melee_Initialization = nil
function InitGlobals()
end

function UnitMetaData(name, unitTypeId, dummyBuildingUnitTypeId, draftItemTypeId, draftAbilityId)
    return { name = name, unitTypeId = unitTypeId, dummyBuildingUnitTypeId = dummyBuildingUnitTypeId, draftItemTypeId = draftItemTypeId, draftAbilityId = draftAbilityId }
end

local draftableUnits = {
    akama = UnitMetaData('akama', FourCC('N009'), FourCC('h00S'), FourCC('I001'), FourCC('A01O')),
    alchemist = UnitMetaData('alchemist', FourCC('N000'), FourCC('h00O'), FourCC('I000'), FourCC('A01C')),
    archimonde = UnitMetaData('archimonde', FourCC('U005'), FourCC('h00N'), FourCC('I002'), FourCC('A01K')),
    archmange = UnitMetaData('archmange', FourCC('H002'), FourCC('h00C'), FourCC('I003'), FourCC('A011')),
    beastmaster = UnitMetaData('beastmaster', FourCC('N001'), FourCC('h00T'), FourCC('I004'), FourCC('A01F')),
    blademaster = UnitMetaData('blademaster', FourCC('O000'), FourCC('h00F'), FourCC('I005'), FourCC('A014')),
    bloodMage = UnitMetaData('bloodMage', FourCC('H004'), FourCC('h00E'), FourCC('I006'), FourCC('A013')),
    brewmaster = UnitMetaData('brewmaster', FourCC('N005'), FourCC('h00U'), FourCC('I007'), FourCC('A01G')),
    cryptLord = UnitMetaData('cryptLord', FourCC('U003'), FourCC('h00M'), FourCC('I008'), FourCC('A01B')),
    darkRanger = UnitMetaData('darkRanger', FourCC('N007'), FourCC('h00V'), FourCC('I009'), FourCC('A01H')),
    deathKnight = UnitMetaData('deathKnight', FourCC('U000'), FourCC('h00J'), FourCC('I00A'), FourCC('A018')),
    demonHunter = UnitMetaData('demonHunter', FourCC('E002'), FourCC('h007'), FourCC('I00B'), FourCC('A00X')),
    dreadlord = UnitMetaData('dreadlord', FourCC('U002'), FourCC('h00L'), FourCC('I00C'), FourCC('A01A')),
    farSeer = UnitMetaData('farSeer', FourCC('O001'), FourCC('h00G'), FourCC('I00D'), FourCC('A015')),
    firelord = UnitMetaData('firelord', FourCC('N004'), FourCC('h00W'), FourCC('I00E'), FourCC('A01I')),
    guldan = UnitMetaData('guldan', FourCC('O003'), FourCC('h00X'), FourCC('I00F'), FourCC('A01L')),
    jaina = UnitMetaData('jaina', FourCC('H009'), FourCC('h00Y'), FourCC('I00G'), FourCC('A01M')),
    keeperOfTheGrove = UnitMetaData('keeperOfTheGrove', FourCC('E000'), FourCC('h005'), FourCC('I00H'), FourCC('A00V')),
    lich = UnitMetaData('lich', FourCC('U001'), FourCC('h00K'), FourCC('I00I'), FourCC('A019')),
    mountainKing = UnitMetaData('mountainKing', FourCC('H003'), FourCC('h00D'), FourCC('I00J'), FourCC('A012')),
    murloc = UnitMetaData('murloc', FourCC('N008'), FourCC('h00P'), FourCC('I00K'), FourCC('A01N')),
    ogreMauler = UnitMetaData('ogreMauler', FourCC('E004'), FourCC('h008'), FourCC('I00L'), FourCC('A00Y')),
    paladin = UnitMetaData('paladin', FourCC('H001'), FourCC('h00B'), FourCC('I00M'), FourCC('A010')),
    pitLord = UnitMetaData('pitLord', FourCC('N006'), FourCC('h00Z'), FourCC('I00N'), FourCC('A01J')),
    priestessOfTheMoon = UnitMetaData('priestessOfTheMoon', FourCC('E001'), FourCC('h006'), FourCC('I00O'), FourCC('A00W')),
    seaWitch = UnitMetaData('seaWitch', FourCC('N002'), FourCC('h00Q'), FourCC('I00P'), FourCC('A01D')),
    shadowHunter = UnitMetaData('shadowHunter', FourCC('O004'), FourCC('h00I'), FourCC('I00Q'), FourCC('A017')),
    taurenChieftain = UnitMetaData('taurenChieftain', FourCC('O002'), FourCC('h00H'), FourCC('I00R'), FourCC('A016')),
    tinker = UnitMetaData('tinker', FourCC('N003'), FourCC('h00R'), FourCC('I00S'), FourCC('A01E')),
    warden = UnitMetaData('warden', FourCC('E003'), FourCC('h00A'), FourCC('I00T'), FourCC('A00Z'))
}

local GLOBAL_DRAFT_SETS = {
    unitTypeIds = {},
    dumyBuildingUnitTypeIds = {},
    draftItemTypeIds = {},
    draftAbilityIds = {}
}
for _, value in pairs(draftableUnits) do
    GLOBAL_DRAFT_SETS.unitTypeIds[value.unitTypeId] = value
    GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[value.dummyBuildingUnitTypeId] = value
    GLOBAL_DRAFT_SETS.draftItemTypeIds[value.draftItemTypeId] = value
    GLOBAL_DRAFT_SETS.draftAbilityIds[value.draftAbilityId] = value
end

local BUILDER_UNIT_TYPE_ID = FourCC('h000')
local ALTAR_UNIT_TYPE_ID = FourCC('h010')
local DRAFT_ABILITY_ID = FourCC('A000')
local CANCEL_ABILITY_ID = FourCC('A001')
local INVULNERABLE_ABILITY_ID = FourCC('Avul') --note: used to hide health bars (also requires ObjectEditor IsBuilding=true, but can still move)

local ORDER_IDs = {
    stop = 851972
}

local playerIdMapping_realToProxy = {}
for playerId = 0, 11 do
    playerIdMapping_realToProxy[playerId] = playerId + 12
end
local playerIdMapping_proxyToReal = {}
for playerId = 12, 23 do
    playerIdMapping_proxyToReal[playerId] = playerId - 12
end

function CalcUnitRotationAngle(unitLocationX, unitLocationY, lookAtX, lookAtY)
    local unitLocation = Location(unitLocationX, unitLocationY)
    local lookAtLocation = Location(lookAtX, lookAtY)
    local result = AngleBetweenPoints(unitLocation, lookAtLocation)
    RemoveLocation(unitLocation)
    RemoveLocation(lookAtLocation)
    return result
end

function GetSpawnOffset(playerId)
    local player = Player(playerId)
    local proxyPlayer = Player(playerIdMapping_realToProxy[playerId])
    local playerStart = { x = GetPlayerStartLocationX(player), y = GetPlayerStartLocationY(player) }
    local proxyStart = { x = GetPlayerStartLocationX(proxyPlayer), y = GetPlayerStartLocationY(proxyPlayer) }
    return { x = proxyStart.x - playerStart.x, y = proxyStart.y - playerStart.y }
end

function SpawnWaveForPlayer(playerId)
    local player = Player(playerId)
    local proxyPlayer = Player(playerIdMapping_realToProxy[playerId])
    local offset = GetSpawnOffset(playerId)

    local group = CreateGroup()
    GroupEnumUnitsOfPlayer(group, player, nil)
    
    ForGroup(group, function()
        local unit = GetEnumUnit()
        local unitType = GetUnitTypeId(unit)
        if GLOBAL_DRAFT_SETS.unitTypeIds[unitType] then
            local x = GetUnitX(unit)
            local y = GetUnitY(unit)            
            local clone = CreateUnit(proxyPlayer, unitType, x + offset.x, y + offset.y, CalcUnitRotationAngle(x, y, 0, 0))
            UnitRemoveAbility(clone, INVULNERABLE_ABILITY_ID)

            local heroLevel = GetHeroLevel(unit)
            if heroLevel > 0 then
                for i = 1, heroLevel - 1 do
                    SetHeroLevel(clone, heroLevel, false)
                end
            end

            local attackLoc = Location(0, 0)
            IssuePointOrderLoc(clone, "attack", attackLoc)
            RemoveLocation(attackLoc)
        end
    end)
    
    DestroyGroup(group)
end

function SpawnWaveAllPlayers()
    for playerId = 0, 11 do
        local player = Player(playerId)
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            SpawnWaveForPlayer(playerId)
        end
    end
end

local spawnTimer
local floatingTexts = {}
local spawnCountdown = 45

function RunDelayed(func, seconds)
    local myTimer = CreateTimer()
    TimerStart(myTimer, seconds, false, function()
        func()
        DestroyTimer(myTimer)
    end)
end

function CreateWaveSpawnLabels()
    for playerId = 0, 11 do
        local proxyPlayer = Player(playerIdMapping_realToProxy[playerId])
        local text = CreateTextTag()  
        SetTextTagText(text, "", 0.024)
        SetTextTagPos(text, GetPlayerStartLocationX(proxyPlayer), GetPlayerStartLocationY(proxyPlayer), 0)
        SetTextTagPermanent(text, true)
        floatingTexts[playerId] = text
    end
end

function CreateSpawnTimer()
    spawnTimer = CreateTimer()
    TimerStart(spawnTimer, 1.0, true, function()
        spawnCountdown = spawnCountdown - 1
        
        if spawnCountdown <= 0 then
            SpawnWaveAllPlayers()            
            spawnCountdown = 45
        end
        
        for playerId = 0, 11 do
            local player = Player(playerId)
            SetTextTagText(floatingTexts[playerId], tostring(spawnCountdown), 0.024)
            SetTextTagVisibility(floatingTexts[playerId], spawnCountdown <= 30 and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING)
        end

    end)
end

local playerBuilders = {
    primary = {},
    altar = {}
}
local playerDecks = {}

function get_table_keys(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

function CloneAndShuffleArray(arr)
    local shuffled = {}
    for i = 1, #arr do
        shuffled[i] = arr[i]
    end
    for i = #shuffled, 2, -1 do
        local j = math.random(1, i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    return shuffled
end

function InitPlayerDecks()
    for playerId = 0, 11 do
        playerDecks[playerId] = CloneAndShuffleArray(get_table_keys(GLOBAL_DRAFT_SETS.draftItemTypeIds))
    end
end

function InitPlayerBuilder(playerId)
    local player = Player(playerId)
    local proxyPlayer = Player(playerIdMapping_realToProxy[playerId])
    local lookAtLocation = CalcUnitRotationAngle(GetPlayerStartLocationX(player), GetPlayerStartLocationY(player), GetPlayerStartLocationX(proxyPlayer), GetPlayerStartLocationY(proxyPlayer))
    local builder = CreateUnit(player, BUILDER_UNIT_TYPE_ID, GetPlayerStartLocationX(player), GetPlayerStartLocationY(player), lookAtLocation)
    UnitRemoveAbility(builder, FourCC('Aatk'))
    UnitAddAbility(builder, INVULNERABLE_ABILITY_ID)

    local offset = GetSpawnOffset(playerId)
    local altar = CreateUnit(player, ALTAR_UNIT_TYPE_ID, GetPlayerStartLocationX(player) - offset.x / 4, GetPlayerStartLocationY(player) - offset.y / 4, lookAtLocation)
    UnitRemoveAbility(builder, FourCC('Aatk'))
    UnitAddAbility(builder, INVULNERABLE_ABILITY_ID)

    playerBuilders.primary[playerId] = builder
    playerBuilders.altar[playerId] = altar

    SelectUnitForPlayerSingle(builder, player)
    SetCameraPositionLocForPlayer(player, GetUnitLoc(builder))
end

function InitPlayerBuilders()
    for playerId = 0, 11 do
        local player = Player(playerId)
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            InitPlayerBuilder(playerId)
        end
    end
end

function DrawChoicesFromDeck(playerId)
    local list = playerDecks[playerId]
    local items = {}
    
    for i = 1, 3 do
        if #list > 0 then
            table.insert(items, table.remove(list, 1))
        end
    end
    
    return items
end

function AddDraftItemsToAltar(playerId)    
    if (GetPlayerState(Player(playerId), PLAYER_STATE_RESOURCE_FOOD_USED) >= GetPlayerState(Player(playerId), PLAYER_STATE_RESOURCE_FOOD_CAP)) then
        return
    end

    local altar = playerBuilders.altar[playerId]
    if not altar then
        return
    end
    
    local items = DrawChoicesFromDeck(playerId)
    for i = 1, #items do
        UnitAddItemById(altar, items[i])
    end
end

function OnConstructFinish()
    local unit = GetConstructedStructure()
    local unitType = GetUnitTypeId(unit)
    if GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[unitType] then
        OnUnitDrafted(unit)
    end
end

function OnSpellEffect()
    local abilityId = GetSpellAbilityId()
    local unit = GetSpellAbilityUnit()
    local player = GetOwningPlayer(unit)

    if abilityId == CANCEL_ABILITY_ID and GetUnitTypeId(unit) == ALTAR_UNIT_TYPE_ID then
        -- IssueImmediateOrder(unit, ORDER_IDs.stop)
        SelectUnitForPlayerSingle(playerBuilders.primary[GetPlayerId(player)], player)
        return
    end

    if abilityId == DRAFT_ABILITY_ID then
        -- IssueImmediateOrder(unit, ORDER_IDs.stop)
        SelectUnitForPlayerSingle(playerBuilders.altar[GetPlayerId(player)], player)
        return
    end

    --todo: create abilities in object editor
    if abilityId == FourCC('A014') then
        OnSoulSiphonEffect()
    elseif abilityId == FourCC('A015') then
        OnHealingWaveEffect()
    end
end

function UnitHasItems(unit)
    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(unit, slotIndex)
        if (item) then
            return true
        end
    end

    return false
end

function OnUnitDrafted(unit)
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player)
    local altar = playerBuilders.altar[playerId]

    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(altar, slotIndex)
        if (item) then
            RemoveItem(item)
        end
    end

    local circle
    local group = CreateGroup()
    local unitLocation = GetUnitLoc(unit)
    local unitX = GetLocationX(unitLocation)
    local unitY = GetLocationY(unitLocation)
    GroupEnumUnitsInRange(group, unitX, unitY, 25, nil)
    ForGroup(group, function()
        local enumUnit = GetEnumUnit()
        if GetUnitTypeId(enumUnit) == FourCC('n00A') then
            circle = enumUnit
            return
        end
    end)

    RemoveLocation(unitLocation)
    DestroyGroup(group)

    local dummyUnitTypeId = GetUnitTypeId(unit)
    local realUnitTypeId = GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[dummyUnitTypeId].unitTypeId

    local circleLocation = GetUnitLoc(circle)
    local circleX = GetLocationX(circleLocation)
    local circleY = GetLocationY(circleLocation)
    RemoveLocation(circleLocation)

    RemoveUnit(unit)
    RemoveUnit(circle)
    local realUnit = CreateUnit(player, realUnitTypeId, circleX, circleY, CalcUnitRotationAngle(circleX, circleY, 0, 0))
    UnitAddAbility(realUnit, INVULNERABLE_ABILITY_ID)
    UnitRemoveAbility(realUnit, FourCC('Aatk'))
    UnitRemoveAbility(realUnit, FourCC('Amov'))
    SelectUnitForPlayerSingle(playerBuilders.primary[playerId], player)
    
    --note: takes a second to update food cap, which we need to avoid drafting if maxed
    RunDelayed(function()
        AddDraftItemsToAltar(GetPlayerId(GetOwningPlayer(builder)))
    end, 1)

end

function OnSoulSiphonEffect()
    local caster = GetSpellAbilityUnit()
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
	local AOE_RADIUS = 175
    local casterOwner = GetOwningPlayer(caster)
    local group = CreateGroup()
    GroupEnumUnitsInRange(group, x, y, AOE_RADIUS, nil)
    
    ForGroup(g, function()
        local target = GetEnumUnit()
        if not IsUnitAlly(target, casterOwner) and GetUnitState(target, UNIT_STATE_LIFE) > 0 then
            local maxHP = GetUnitState(target, UNIT_STATE_MAX_LIFE)
            local currentHP = GetUnitState(target, UNIT_STATE_LIFE)
            local percentHP = 100 * currentHP / maxHP
            
            local executeChance = 26 - percentHP
            if executeChance < 0 then
                return
            end
            
            if math.random(1, 100) <= executeChance then
                KillUnit(target)
                AdjustPlayerStateBJ(1, casterOwner, PLAYER_STATE_RESOURCE_LUMBER)
                --AdjustPlayerStateBJ(5, casterOwner, PLAYER_STATE_RESOURCE_GOLD) -- should already be done by death event
            end
        end
    end)
    
    DestroyGroup(group)
end

function OnHealingWaveEffect()
    local caster = GetSpellAbilityUnit()
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
	local AOE_RADIUS = 350
    local casterOwner = GetOwningPlayer(caster)
    local group = CreateGroup()
    GroupEnumUnitsInRange(group, x, y, AOE_RADIUS, nil)
    
    ForGroup(g, function()
        local target = GetEnumUnit()        
        if IsUnitOwnedByPlayer(target, casterOwner) and GetUnitState(target, UNIT_STATE_LIFE) > 0 then
            local maxHP = GetUnitState(target, UNIT_STATE_MAX_LIFE)
            local currentHP = GetUnitState(target, UNIT_STATE_LIFE)
            local missingHP = maxHP - currentHP
            local percentHP = 100 * currentHP / maxHP
            
            local healAmount = (100 - percentHP) * maxHP / 4           
            SetUnitState(target, UNIT_STATE_LIFE, currentHP + healAmount)
        end
    end)
    
    DestroyGroup(group)
end

function OnUnitDeath()
    local dying = GetDyingUnit()
    local killer = GetKillingUnit()
    
    if killer then
        local killerOwner = GetOwningPlayer(killer)
        local killerIndex = GetPlayerId(killerOwner)
        
        local actualPlayer = Player(playerIdMapping_proxyToReal[killerIndex])
        if actualPlayer then
            AdjustPlayerStateBJ(1, actualPlayer, PLAYER_STATE_RESOURCE_GOLD)
        else
            AdjustPlayerStateBJ(1, killerOwner, PLAYER_STATE_RESOURCE_GOLD)
        end
    end
end

function GrantWoodPassive()
    local timer = CreateTimer()
    TimerStart(timer, 5.0, true, function()
        for playerId = 0, 11 do
            local player = Player(playerId)
            if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
                AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
            end
        end
    end)
end

function InitFoodCapTimer()
    local foodCapIncreaseMinutes = {
        0, 1, 2, 3, 5, 8, 12, 17, 23
    }
    
    for foodCap = 1, #foodCapIncreaseMinutes do
        local timer = CreateTimer()
        TimerStart(timer, foodCapIncreaseMinutes[foodCap] * 60, false, function()
            for playerId = 0, 11 do
                local player = Player(playerId)
                if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
                    SetPlayerStateBJ(player, PLAYER_STATE_RESOURCE_FOOD_CAP, foodCap)
                    if not UnitHasItems(playerBuilders.altar[playerId]) then
                        AddDraftItemsToAltar(playerId)
                    end
                end
            end
        end)
    end
end

function MakeCirclesOfPowerTranslucent()
    ForGroup(GetUnitsOfTypeIdAll(FourCC('n00A')), function()
		SetUnitVertexColor(GetEnumUnit(), 255, 50, 255, 255)
    end)	
end

function InitPlayers()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local p = Player(i)
        if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetLocalPlayer() == p then
	        --SetTerrainFogEx(0, 0, 100000, 0.0, 0.0, 0.0, 0.0)
	        --SetCameraField(CAMERA_FIELD_FARZ, 10000.0, 0)
        	SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 3000, 0)
        end
    end

	MakeCirclesOfPowerTranslucent()
end

function Init()
	MeleeStartingVisibility()
	MeleeClearExcessUnits()
	FogEnableOff()
	FogMaskEnableOff()
	InitPlayers()
    InitPlayerBuilders()
    InitPlayerDecks()
    CreateWaveSpawnLabels()
    CreateSpawnTimer()
    InitFoodCapTimer()
    GrantWoodPassive()

    local deathTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(deathTrigger, OnUnitDeath)
    
    local spellTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(spellTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddAction(spellTrigger, OnSpellEffect)

    local buildTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(buildTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddAction(buildTrigger, OnConstructFinish)
end

--[[


--]]
function CreateBuildingsForPlayer0()
local p = Player(0)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, 2304.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, 2304.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, 2304.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, 2176.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, 2176.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, 2176.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, 2048.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, 2048.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, 2048.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer1()
local p = Player(1)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, 1728.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, 1728.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, 1728.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer2()
local p = Player(2)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, 832.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, 832.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, 832.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer3()
local p = Player(3)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2304.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2432.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2560.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2304.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2432.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2560.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2304.0, -384.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2432.0, -384.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2560.0, -384.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer4()
local p = Player(4)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1984.0, -1600.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2112.0, -1600.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 2240.0, -1600.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer5()
local p = Player(5)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1088.0, -2496.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1216.0, -2496.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 1344.0, -2496.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer6()
local p = Player(6)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, -2560.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, -2560.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, -2560.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, -2688.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, -2688.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, -2688.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -128.0, -2816.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 0.0, -2816.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), 128.0, -2816.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer7()
local p = Player(7)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, -2240.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, -2368.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, -2496.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, -2496.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, -2496.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer8()
local p = Player(8)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, -1344.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, -1472.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, -1600.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, -1600.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, -1600.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer9()
local p = Player(9)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2560.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2432.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2304.0, -128.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2560.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2432.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2304.0, -256.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2560.0, -384.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2432.0, -384.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2304.0, -384.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer10()
local p = Player(10)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, 1088.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, 960.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2240.0, 832.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -2112.0, 832.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1984.0, 832.0, 270.000, FourCC("n00A"))
end

function CreateBuildingsForPlayer11()
local p = Player(11)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, 1984.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, 1856.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1344.0, 1728.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1216.0, 1728.0, 270.000, FourCC("n00A"))
u = BlzCreateUnitWithSkin(p, FourCC("n00A"), -1088.0, 1728.0, 270.000, FourCC("n00A"))
end

function CreatePlayerBuildings()
CreateBuildingsForPlayer0()
CreateBuildingsForPlayer1()
CreateBuildingsForPlayer2()
CreateBuildingsForPlayer3()
CreateBuildingsForPlayer4()
CreateBuildingsForPlayer5()
CreateBuildingsForPlayer6()
CreateBuildingsForPlayer7()
CreateBuildingsForPlayer8()
CreateBuildingsForPlayer9()
CreateBuildingsForPlayer10()
CreateBuildingsForPlayer11()
end

function CreatePlayerUnits()
end

function CreateAllUnits()
CreatePlayerBuildings()
CreatePlayerUnits()
end

function Trig_Melee_Initialization_Actions()
    Init()
end

function InitTrig_Melee_Initialization()
gg_trg_Melee_Initialization = CreateTrigger()
TriggerAddAction(gg_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
end

function InitCustomTriggers()
InitTrig_Melee_Initialization()
end

function RunInitializationTriggers()
ConditionalTriggerExecute(gg_trg_Melee_Initialization)
end

function InitCustomPlayerSlots()
SetPlayerStartLocation(Player(0), 0)
ForcePlayerStartLocation(Player(0), 0)
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(1), 1)
ForcePlayerStartLocation(Player(1), 1)
SetPlayerColor(Player(1), ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
SetPlayerRaceSelectable(Player(1), true)
SetPlayerController(Player(1), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(2), 2)
ForcePlayerStartLocation(Player(2), 2)
SetPlayerColor(Player(2), ConvertPlayerColor(2))
SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(2), true)
SetPlayerController(Player(2), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(3), 3)
ForcePlayerStartLocation(Player(3), 3)
SetPlayerColor(Player(3), ConvertPlayerColor(3))
SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(3), true)
SetPlayerController(Player(3), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(4), 4)
ForcePlayerStartLocation(Player(4), 4)
SetPlayerColor(Player(4), ConvertPlayerColor(4))
SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(4), true)
SetPlayerController(Player(4), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(5), 5)
ForcePlayerStartLocation(Player(5), 5)
SetPlayerColor(Player(5), ConvertPlayerColor(5))
SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(5), true)
SetPlayerController(Player(5), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(6), 6)
ForcePlayerStartLocation(Player(6), 6)
SetPlayerColor(Player(6), ConvertPlayerColor(6))
SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(6), true)
SetPlayerController(Player(6), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(7), 7)
ForcePlayerStartLocation(Player(7), 7)
SetPlayerColor(Player(7), ConvertPlayerColor(7))
SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(7), true)
SetPlayerController(Player(7), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(8), 8)
ForcePlayerStartLocation(Player(8), 8)
SetPlayerColor(Player(8), ConvertPlayerColor(8))
SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(8), true)
SetPlayerController(Player(8), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(9), 9)
ForcePlayerStartLocation(Player(9), 9)
SetPlayerColor(Player(9), ConvertPlayerColor(9))
SetPlayerRacePreference(Player(9), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(9), true)
SetPlayerController(Player(9), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(10), 10)
ForcePlayerStartLocation(Player(10), 10)
SetPlayerColor(Player(10), ConvertPlayerColor(10))
SetPlayerRacePreference(Player(10), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(10), true)
SetPlayerController(Player(10), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(11), 11)
ForcePlayerStartLocation(Player(11), 11)
SetPlayerColor(Player(11), ConvertPlayerColor(11))
SetPlayerRacePreference(Player(11), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(11), true)
SetPlayerController(Player(11), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(12), 12)
ForcePlayerStartLocation(Player(12), 12)
SetPlayerColor(Player(12), ConvertPlayerColor(12))
SetPlayerRacePreference(Player(12), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(12), true)
SetPlayerController(Player(12), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(13), 13)
ForcePlayerStartLocation(Player(13), 13)
SetPlayerColor(Player(13), ConvertPlayerColor(13))
SetPlayerRacePreference(Player(13), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(13), true)
SetPlayerController(Player(13), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(14), 14)
ForcePlayerStartLocation(Player(14), 14)
SetPlayerColor(Player(14), ConvertPlayerColor(14))
SetPlayerRacePreference(Player(14), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(14), true)
SetPlayerController(Player(14), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(15), 15)
ForcePlayerStartLocation(Player(15), 15)
SetPlayerColor(Player(15), ConvertPlayerColor(15))
SetPlayerRacePreference(Player(15), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(15), true)
SetPlayerController(Player(15), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(16), 16)
ForcePlayerStartLocation(Player(16), 16)
SetPlayerColor(Player(16), ConvertPlayerColor(16))
SetPlayerRacePreference(Player(16), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(16), true)
SetPlayerController(Player(16), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(17), 17)
ForcePlayerStartLocation(Player(17), 17)
SetPlayerColor(Player(17), ConvertPlayerColor(17))
SetPlayerRacePreference(Player(17), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(17), true)
SetPlayerController(Player(17), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(18), 18)
ForcePlayerStartLocation(Player(18), 18)
SetPlayerColor(Player(18), ConvertPlayerColor(18))
SetPlayerRacePreference(Player(18), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(18), true)
SetPlayerController(Player(18), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(19), 19)
ForcePlayerStartLocation(Player(19), 19)
SetPlayerColor(Player(19), ConvertPlayerColor(19))
SetPlayerRacePreference(Player(19), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(19), true)
SetPlayerController(Player(19), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(20), 20)
ForcePlayerStartLocation(Player(20), 20)
SetPlayerColor(Player(20), ConvertPlayerColor(20))
SetPlayerRacePreference(Player(20), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(20), true)
SetPlayerController(Player(20), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(21), 21)
ForcePlayerStartLocation(Player(21), 21)
SetPlayerColor(Player(21), ConvertPlayerColor(21))
SetPlayerRacePreference(Player(21), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(21), true)
SetPlayerController(Player(21), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(22), 22)
ForcePlayerStartLocation(Player(22), 22)
SetPlayerColor(Player(22), ConvertPlayerColor(22))
SetPlayerRacePreference(Player(22), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(22), true)
SetPlayerController(Player(22), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(23), 23)
ForcePlayerStartLocation(Player(23), 23)
SetPlayerColor(Player(23), ConvertPlayerColor(23))
SetPlayerRacePreference(Player(23), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(23), true)
SetPlayerController(Player(23), MAP_CONTROL_COMPUTER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
SetPlayerTeam(Player(1), 0)
SetPlayerTeam(Player(2), 0)
SetPlayerTeam(Player(3), 0)
SetPlayerTeam(Player(4), 0)
SetPlayerTeam(Player(5), 0)
SetPlayerTeam(Player(6), 0)
SetPlayerTeam(Player(7), 0)
SetPlayerTeam(Player(8), 0)
SetPlayerTeam(Player(9), 0)
SetPlayerTeam(Player(10), 0)
SetPlayerTeam(Player(11), 0)
SetPlayerTeam(Player(12), 0)
SetPlayerTeam(Player(13), 0)
SetPlayerTeam(Player(14), 0)
SetPlayerTeam(Player(15), 0)
SetPlayerTeam(Player(16), 0)
SetPlayerTeam(Player(17), 0)
SetPlayerTeam(Player(18), 0)
SetPlayerTeam(Player(19), 0)
SetPlayerTeam(Player(20), 0)
SetPlayerTeam(Player(21), 0)
SetPlayerTeam(Player(22), 0)
SetPlayerTeam(Player(23), 0)
end

function InitAllyPriorities()
SetStartLocPrioCount(0, 2)
SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 1, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(1, 1)
SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(2, 1)
SetStartLocPrio(2, 0, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(3, 2)
SetStartLocPrio(3, 0, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 1, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(4, 1)
SetStartLocPrio(4, 0, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(5, 1)
SetStartLocPrio(5, 0, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(6, 2)
SetStartLocPrio(6, 0, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 1, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(7, 1)
SetStartLocPrio(7, 0, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(8, 1)
SetStartLocPrio(8, 0, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(9, 2)
SetStartLocPrio(9, 0, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 1, 10, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(10, 1)
SetStartLocPrio(10, 0, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(11, 1)
SetStartLocPrio(11, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(12, 7)
SetStartLocPrio(12, 0, 2, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 1, 3, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 2, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 3, 11, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 4, 13, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 5, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(12, 7)
SetEnemyStartLocPrio(12, 0, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(12, 1, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(12, 2, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(12, 3, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(12, 4, 13, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(12, 5, 14, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(13, 12)
SetStartLocPrio(13, 0, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 1, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 2, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 3, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 4, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 5, 12, MAP_LOC_PRIO_LOW)
SetStartLocPrio(13, 6, 15, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 7, 17, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 8, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 9, 21, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 10, 23, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(13, 11)
SetEnemyStartLocPrio(13, 0, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 1, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 2, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 3, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 4, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 5, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 6, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 7, 11, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 8, 12, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 9, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 10, 23, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(14, 1)
SetStartLocPrio(14, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(14, 4)
SetEnemyStartLocPrio(14, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(14, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(14, 2, 6, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(14, 3, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(15, 2)
SetStartLocPrio(15, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrio(15, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(15, 15)
SetEnemyStartLocPrio(15, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 2, 2, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 3, 3, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 5, 6, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 6, 7, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 7, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 8, 10, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 9, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 10, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 11, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 12, 20, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 13, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 14, 23, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(16, 1)
SetStartLocPrio(16, 0, 23, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(16, 2)
SetEnemyStartLocPrio(16, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(16, 1, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(17, 6)
SetStartLocPrio(17, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 1, 3, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 2, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 3, 5, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 4, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 5, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(17, 2)
SetEnemyStartLocPrio(17, 0, 0, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(17, 1, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(18, 11)
SetStartLocPrio(18, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrio(18, 1, 1, MAP_LOC_PRIO_LOW)
SetStartLocPrio(18, 2, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 3, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 4, 10, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 5, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 6, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 7, 20, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 8, 22, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 9, 23, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(18, 15)
SetEnemyStartLocPrio(18, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 5, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 6, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 7, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 8, 10, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 9, 13, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 10, 14, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 11, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 12, 21, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 13, 22, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(19, 1)
SetEnemyStartLocPrio(19, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(20, 10)
SetStartLocPrio(20, 0, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 1, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 2, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 3, 10, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 4, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 5, 16, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 6, 18, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 7, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 8, 21, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(20, 9, 23, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(20, 16)
SetEnemyStartLocPrio(20, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 1, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 2, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 3, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 4, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 5, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 6, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 7, 9, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 8, 10, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 9, 11, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 10, 14, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 11, 16, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 12, 18, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 13, 21, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 14, 23, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(21, 17)
SetStartLocPrio(21, 0, 1, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 1, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 2, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 6, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 7, 13, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 8, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 9, 16, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 10, 17, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 11, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 12, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 13, 20, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 14, 22, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 15, 23, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(21, 23)
SetEnemyStartLocPrio(21, 0, 0, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(21, 1, 1, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(21, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 4, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 5, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 6, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 7, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 8, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 9, 9, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 10, 10, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 11, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 12, 13, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 13, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 14, 15, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 15, 16, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 16, 17, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 17, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 18, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 19, 20, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 20, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 21, 23, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(22, 12)
SetStartLocPrio(22, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrio(22, 1, 6, MAP_LOC_PRIO_LOW)
SetStartLocPrio(22, 2, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 3, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 4, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 5, 12, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 6, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 7, 15, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 8, 16, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 9, 18, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 10, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(22, 14)
SetEnemyStartLocPrio(22, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 1, 1, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(22, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 3, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 5, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 6, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 7, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 8, 9, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 9, 10, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 10, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 11, 12, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(22, 12, 13, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 13, 14, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(23, 16)
SetStartLocPrio(23, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 1, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 2, 3, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 3, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 4, 5, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 6, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 7, 8, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 8, 10, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 9, 11, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 10, 12, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 11, 13, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 12, 16, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 13, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 14, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(23, 13)
SetEnemyStartLocPrio(23, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 1, 2, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 2, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 3, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 5, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 6, 7, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 7, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 8, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 9, 16, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 10, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 11, 22, MAP_LOC_PRIO_LOW)
end

function main()
SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCDalaran\\DNCDalaranTerrain\\DNCDalaranTerrain.mdl", "Environment\\DNC\\DNCDalaran\\DNCDalaranUnit\\DNCDalaranUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("DalaranRuinsDay")
SetAmbientNightSound("DalaranRuinsNight")
SetMapMusic("Music", true, 0)
CreateAllUnits()
InitBlizzard()
InitGlobals()
InitCustomTriggers()
RunInitializationTriggers()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(24)
SetTeams(24)
SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
DefineStartLocation(0, 0.0, 2688.0)
DefineStartLocation(1, 1216.0, 2368.0)
DefineStartLocation(2, 2624.0, 960.0)
DefineStartLocation(3, 2944.0, -256.0)
DefineStartLocation(4, 2624.0, -1472.0)
DefineStartLocation(5, 1216.0, -2944.0)
DefineStartLocation(6, 0.0, -3200.0)
DefineStartLocation(7, -1216.0, -2880.0)
DefineStartLocation(8, -2624.0, -1472.0)
DefineStartLocation(9, -2944.0, -256.0)
DefineStartLocation(10, -2624.0, 960.0)
DefineStartLocation(11, -1216.0, 2368.0)
DefineStartLocation(12, 0.0, 1664.0)
DefineStartLocation(13, 1216.0, 1344.0)
DefineStartLocation(14, 1600.0, 832.0)
DefineStartLocation(15, 1920.0, -320.0)
DefineStartLocation(16, 1600.0, -1408.0)
DefineStartLocation(17, 1088.0, -1856.0)
DefineStartLocation(18, 0.0, -2176.0)
DefineStartLocation(19, -1152.0, -1856.0)
DefineStartLocation(20, -1600.0, -1344.0)
DefineStartLocation(21, -1920.0, -320.0)
DefineStartLocation(22, -1600.0, 832.0)
DefineStartLocation(23, -1152.0, 1344.0)
InitCustomPlayerSlots()
SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(2), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(3), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(4), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(5), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(6), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(7), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(8), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(9), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(10), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(11), MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(12), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(13), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(14), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(15), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(16), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(17), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(18), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(19), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(20), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(21), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(22), MAP_CONTROL_COMPUTER)
SetPlayerSlotAvailable(Player(23), MAP_CONTROL_COMPUTER)
InitGenericPlayerSlots()
InitAllyPriorities()
end

