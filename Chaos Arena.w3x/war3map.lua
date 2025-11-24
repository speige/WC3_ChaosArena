gg_trg_Melee_Initialization = nil
function InitGlobals()
end

local GLOBAL_DECK_UNIT_SET = {}
GLOBAL_DECK_UNIT_SET[FourCC('E000')] = true
GLOBAL_DECK_UNIT_SET[FourCC('E001')] = true
GLOBAL_DECK_UNIT_SET[FourCC('E002')] = true
GLOBAL_DECK_UNIT_SET[FourCC('E004')] = true
GLOBAL_DECK_UNIT_SET[FourCC('E003')] = true
GLOBAL_DECK_UNIT_SET[FourCC('H001')] = true
GLOBAL_DECK_UNIT_SET[FourCC('H002')] = true
GLOBAL_DECK_UNIT_SET[FourCC('H003')] = true
GLOBAL_DECK_UNIT_SET[FourCC('H004')] = true
GLOBAL_DECK_UNIT_SET[FourCC('O000')] = true
GLOBAL_DECK_UNIT_SET[FourCC('O001')] = true
GLOBAL_DECK_UNIT_SET[FourCC('O002')] = true
GLOBAL_DECK_UNIT_SET[FourCC('O004')] = true
GLOBAL_DECK_UNIT_SET[FourCC('U000')] = true
GLOBAL_DECK_UNIT_SET[FourCC('U001')] = true
GLOBAL_DECK_UNIT_SET[FourCC('U002')] = true
GLOBAL_DECK_UNIT_SET[FourCC('U004')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N000')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N008')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N002')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N003')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N001')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N005')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N007')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N004')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N006')] = true
GLOBAL_DECK_UNIT_SET[FourCC('U005')] = true
GLOBAL_DECK_UNIT_SET[FourCC('N009')] = true
GLOBAL_DECK_UNIT_SET[FourCC('O003')] = true
GLOBAL_DECK_UNIT_SET[FourCC('H009')] = true

local GLOBAL_DECK_SPELLBOOK_SET = {}
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00U')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00I')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00Q')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A007')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00L')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00A')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A009')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00M')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00H')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00N')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00E')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A003')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00G')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00B')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00O')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00R')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00S')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A001')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00F')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A008')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00T')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A004')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A006')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00P')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A002')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00J')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00D')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00C')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A00K')] = true
GLOBAL_DECK_SPELLBOOK_SET[FourCC('A005')] = true

function SpawnWaveForPlayer(playerIndex)
    local p = Player(playerIndex)
    local proxyPlayer = Player(playerIndex + 12)
    local playerStart = { x = GetPlayerStartLocationX(p), y = GetPlayerStartLocationY(p) }
    local proxyStart = { x = GetPlayerStartLocationX(proxyPlayer), y = GetPlayerStartLocationY(proxyPlayer) }
    local offset = { x = playerStart.x - proxyStart.x, y = playerStart.y - proxyStart.y }
    
    local g = CreateGroup()
    GroupEnumUnitsOfPlayer(g, p, nil)
    
    ForGroup(g, function()
        local u = GetEnumUnit()
        local unitType = GetUnitTypeId(u)
        if GLOBAL_DECK_UNIT_SET[unitType] then
            local ux = GetUnitX(u)
            local uy = GetUnitY(u)            
            local clone = CreateUnit(proxyPlayer, unitType, ux + offset.x, uy + offset.y, 0)
            SetUnitFacingToFaceLocTimed(clone, Location(0, 0), 0 )
            
            local heroLevel = GetHeroLevel(u)
            if heroLevel > 0 then
                for i = 1, heroLevel - 1 do
                    SetHeroLevel(clone, heroLevel, false)
                end
            end
            
            IssuePointOrderLoc(clone, "attack", Location(0, 0))
        end
    end)
    
    DestroyGroup(g)
end

function SpawnWaveAllPlayers()
    for i = 0, 11 do
        local p = Player(i)
        if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
            SpawnWaveForPlayer(i)
        end
    end
end

local spawnTimer
local floatingTexts = {}
local spawnCountdown = 45

function CreateWaveSpawnLabels()
    for playerIndex = 0, 11 do
        local proxyPlayer = Player(playerIndex + 12)
        local txt = CreateTextTag()  
        SetTextTagText(txt, "", 0.024)
        SetTextTagPos(txt, GetPlayerStartLocationX(proxyPlayer), GetPlayerStartLocationY(proxyPlayer), 0)
        SetTextTagPermanent(txt, true)
        floatingTexts[playerIndex] = txt
    end
end

function CreateSpawnTimer()
    spawnTimer = CreateTimer()
    TimerStart(spawnTimer, 1.0, true, function()
        spawnCountdown = spawnCountdown - 1
        
        if spawnCountdown <= 0 then
            spawnCountdown = 30
        end
        
        for i = 0, 11 do
            local p = Player(i)
            SetTextTagText(floatingTexts[index], tostring(spawnCountdown), 0.024)
            SetTextTagVisibility(floatingTexts[index], GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING)
        end

    end)
end

function InitWaveSpawner()
    local t = CreateTimer()
    TimerStart(t, 30.0, true, function()
        SpawnWaveAllPlayers()
    end)
end

local proxyToRealPlayerMapping = {}
for i = 0, 11 do
    proxyToRealPlayerMapping[i + 12] = i
end

local BUILDER_ID = FourCC('h000')
local SPELLBOOK_ID = FourCC('A000')

local playerBuilders = {}
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
    for i = 0, 11 do
        playerDecks[i] = CloneAndShuffleArray(get_table_keys(GLOBAL_DECK_SPELLBOOK_SET))
    end
end

function FindPlayerBuilder(playerIndex)
    local p = Player(playerIndex)
    local g = CreateGroup()
    GroupEnumUnitsOfPlayer(g, p, nil)
    
    local builder = nil
    ForGroup(g, function()
        local u = GetEnumUnit()
        if GetUnitTypeId(u) == BUILDER_ID then
            builder = u
        end
    end)
    
    DestroyGroup(g)
    return builder
end

function InitPlayerBuilders()
    for i = 0, 11 do
        local p = Player(i)
        if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
            playerBuilders[i] = FindPlayerBuilder(i)
        end
    end
end

function DrawChoicesFromDeck(playerIndex)
    local list = playerDecks[playerIndex]
    local abilities = {}
    
    for i = 1, 3 do
        if #list > 0 then
            table.insert(abilities, table.remove(list, 1))
        end
    end
    
    return abilities
end

function AddDraftAbilitiesToBuilder(playerIndex)
    if (GetPlayerState(Player(playerIndex), PLAYER_STATE_RESOURCE_FOOD_USED) >= GetPlayerState(Player(playerIndex), PLAYER_STATE_RESOURCE_FOOD_CAP)) then
        return
    end

    local builder = playerBuilders[playerIndex]
    if not builder then return end
    
    local abilities = DrawChoicesFromDeck(playerIndex)
    for i = 1, #abilities do
        UnitAddAbility(builder, abilities[i])
    end
end

function OnSpellEffect()
    local abilityId = GetSpellAbilityId()
    
    if GLOBAL_DECK_SPELLBOOK_SET[abilityId] then
        OnUnitDrafted()
    end

    --todo: create abilities in object editor
    if abilityId == FourCC('A014') then
        OnSoulSiphonEffect()
    elseif abilityId == FourCC('A015') then
        OnHealingWaveEffect()
    end
end

function OnUnitDrafted()
    local builder = GetSpellAbilityUnit()

    for i = 1, #GLOBAL_DECK_SPELLBOOK_SET do
        UnitRemoveAbility(builder, GLOBAL_DECK_SPELLBOOK_SET[i])                
    end                

    local circle
    local g = CreateGroup()
    GroupEnumUnitsInRange(g, GetSpellTargetX(), GetSpellTargetY(), 25, nil)        
    ForGroup(g, function()
        circle = GetEnumUnit()
        if GetUnitTypeId(circle) == FourCC('ncop') then
            RemoveUnit(circle)
            return
        end
    end)
    
    DestroyGroup(g)

    AddDraftAbilitiesToBuilder(GetPlayerId(GetOwningPlayer(builder)))
end

function OnSoulSiphonEffect()
    local caster = GetSpellAbilityUnit()
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
	local AOE_RADIUS = 175
    local casterOwner = GetOwningPlayer(caster)
    local g = CreateGroup()
    GroupEnumUnitsInRange(g, x, y, AOE_RADIUS, nil)
    
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
    
    DestroyGroup(g)
end

function OnHealingWaveEffect()
    local caster = GetSpellAbilityUnit()
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
	local AOE_RADIUS = 350
    local casterOwner = GetOwningPlayer(caster)
    local g = CreateGroup()
    GroupEnumUnitsInRange(g, x, y, AOE_RADIUS, nil)
    
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
    
    DestroyGroup(g)
end

function OnUnitDeath()
    local dying = GetDyingUnit()
    local killer = GetKillingUnit()
    
    if killer then
        local killerOwner = GetOwningPlayer(killer)
        local killerIndex = GetPlayerId(killerOwner)
        
        if proxyToRealPlayerMapping[killerIndex] then
            local actualPlayer = Player(proxyToRealPlayerMapping[killerIndex])
            AdjustPlayerStateBJ(1, actualPlayer, PLAYER_STATE_RESOURCE_GOLD)
        else
            AdjustPlayerStateBJ(1, killerOwner, PLAYER_STATE_RESOURCE_GOLD)
        end
    end
end

function GrantWoodPassive()
    local t = CreateTimer()
    TimerStart(t, 5.0, true, function()
        for i = 0, 11 do
            local p = Player(i)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
                AdjustPlayerStateBJ(1, p, PLAYER_STATE_RESOURCE_LUMBER)
            end
        end
    end)
end

function GrantFoodCap()
    local foodTimes = {
        0, 0.5, 1, 2, 3.5, 5.5, 9, 15, 24.5
    }
    
    for i = 1, #foodTimes do
        local t = CreateTimer()
        TimerStart(t, foodTimes[i] * 60, false, function()
            for j = 0, 11 do
                local p = Player(j)
                if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
                    SetPlayerStateBJ(p, PLAYER_STATE_RESOURCE_FOOD_CAP, i)
                    AddDraftAbilitiesToBuilder(j)
                end
            end
        end)
    end
end

function MakeCirclesOfPowerTranslucent()
    ForGroup(GetUnitsOfTypeIdAll(FourCC('ncop')), function()
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

    local deathTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(deathTrigger, OnUnitDeath)
    
    local spellTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(spellTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddAction(spellTrigger, OnSpellEffect)
    InitCustomAbilities()
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

function CreateUnitsForPlayer0()
local p = Player(0)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("hpea"), 2553.2, 693.3, 120.095, FourCC("hpea"))
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
CreateUnitsForPlayer0()
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
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(1), 1)
SetPlayerColor(Player(1), ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(1), true)
SetPlayerController(Player(1), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(2), 2)
SetPlayerColor(Player(2), ConvertPlayerColor(2))
SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(2), true)
SetPlayerController(Player(2), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(3), 3)
SetPlayerColor(Player(3), ConvertPlayerColor(3))
SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(3), true)
SetPlayerController(Player(3), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(4), 4)
SetPlayerColor(Player(4), ConvertPlayerColor(4))
SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(4), true)
SetPlayerController(Player(4), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(5), 5)
SetPlayerColor(Player(5), ConvertPlayerColor(5))
SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(5), true)
SetPlayerController(Player(5), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(6), 6)
SetPlayerColor(Player(6), ConvertPlayerColor(6))
SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(6), true)
SetPlayerController(Player(6), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(7), 7)
SetPlayerColor(Player(7), ConvertPlayerColor(7))
SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(7), true)
SetPlayerController(Player(7), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(8), 8)
SetPlayerColor(Player(8), ConvertPlayerColor(8))
SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(8), true)
SetPlayerController(Player(8), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(9), 9)
SetPlayerColor(Player(9), ConvertPlayerColor(9))
SetPlayerRacePreference(Player(9), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(9), true)
SetPlayerController(Player(9), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(10), 10)
SetPlayerColor(Player(10), ConvertPlayerColor(10))
SetPlayerRacePreference(Player(10), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(10), true)
SetPlayerController(Player(10), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(11), 11)
SetPlayerColor(Player(11), ConvertPlayerColor(11))
SetPlayerRacePreference(Player(11), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(11), true)
SetPlayerController(Player(11), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(12), 12)
SetPlayerColor(Player(12), ConvertPlayerColor(12))
SetPlayerRacePreference(Player(12), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(12), true)
SetPlayerController(Player(12), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(13), 13)
SetPlayerColor(Player(13), ConvertPlayerColor(13))
SetPlayerRacePreference(Player(13), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(13), true)
SetPlayerController(Player(13), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(14), 14)
SetPlayerColor(Player(14), ConvertPlayerColor(14))
SetPlayerRacePreference(Player(14), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(14), true)
SetPlayerController(Player(14), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(15), 15)
SetPlayerColor(Player(15), ConvertPlayerColor(15))
SetPlayerRacePreference(Player(15), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(15), true)
SetPlayerController(Player(15), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(16), 16)
SetPlayerColor(Player(16), ConvertPlayerColor(16))
SetPlayerRacePreference(Player(16), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(16), true)
SetPlayerController(Player(16), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(17), 17)
SetPlayerColor(Player(17), ConvertPlayerColor(17))
SetPlayerRacePreference(Player(17), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(17), true)
SetPlayerController(Player(17), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(18), 18)
SetPlayerColor(Player(18), ConvertPlayerColor(18))
SetPlayerRacePreference(Player(18), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(18), true)
SetPlayerController(Player(18), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(19), 19)
SetPlayerColor(Player(19), ConvertPlayerColor(19))
SetPlayerRacePreference(Player(19), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(19), true)
SetPlayerController(Player(19), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(20), 20)
SetPlayerColor(Player(20), ConvertPlayerColor(20))
SetPlayerRacePreference(Player(20), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(20), true)
SetPlayerController(Player(20), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(21), 21)
SetPlayerColor(Player(21), ConvertPlayerColor(21))
SetPlayerRacePreference(Player(21), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(21), true)
SetPlayerController(Player(21), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(22), 22)
SetPlayerColor(Player(22), ConvertPlayerColor(22))
SetPlayerRacePreference(Player(22), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(22), true)
SetPlayerController(Player(22), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(23), 23)
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
SetStartLocPrioCount(13, 12)
SetStartLocPrio(13, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 1, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 2, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 3, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 4, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 5, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 6, 15, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 7, 17, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 8, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 9, 21, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(13, 10, 23, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(13, 12)
SetEnemyStartLocPrio(13, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 4, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 5, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 6, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 7, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 8, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 9, 11, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 10, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(13, 11, 23, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(14, 2)
SetEnemyStartLocPrio(14, 0, 6, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(14, 1, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(15, 1)
SetStartLocPrio(15, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(15, 16)
SetEnemyStartLocPrio(15, 0, 0, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 1, 1, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 2, 2, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 3, 3, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 5, 6, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 6, 7, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 7, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(15, 8, 10, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 9, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 10, 12, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 11, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 12, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 13, 20, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 14, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 15, 23, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(16, 1)
SetStartLocPrio(16, 0, 23, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(16, 2)
SetEnemyStartLocPrio(16, 0, 0, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(16, 1, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(17, 7)
SetStartLocPrio(17, 0, 0, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 1, 1, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 2, 3, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 3, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 4, 5, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 5, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 6, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(17, 1)
SetEnemyStartLocPrio(17, 0, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(18, 10)
SetStartLocPrio(18, 0, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 1, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 2, 10, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 3, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 4, 12, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 5, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 6, 20, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 7, 22, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 8, 23, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(18, 16)
SetEnemyStartLocPrio(18, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 5, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 6, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 7, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(18, 8, 10, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 9, 12, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 10, 13, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 11, 14, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 12, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 13, 21, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(18, 14, 22, MAP_LOC_PRIO_HIGH)
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
SetEnemyStartLocPrioCount(20, 18)
SetEnemyStartLocPrio(20, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 1, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 2, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 4, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 5, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 6, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 7, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(20, 8, 9, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 9, 10, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 10, 11, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 11, 12, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 12, 14, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 13, 16, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 14, 18, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 15, 21, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(20, 16, 23, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(21, 18)
SetStartLocPrio(21, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 1, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 2, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 6, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 7, 12, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 8, 13, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 9, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 10, 16, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 11, 17, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 12, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 13, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(21, 14, 20, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 15, 22, MAP_LOC_PRIO_LOW)
SetStartLocPrio(21, 16, 23, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(21, 24)
SetEnemyStartLocPrio(21, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 1, 1, MAP_LOC_PRIO_LOW)
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
SetEnemyStartLocPrio(21, 12, 12, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 13, 13, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 14, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 15, 15, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 16, 16, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 17, 17, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 18, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 19, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 20, 20, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 21, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(21, 22, 23, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(22, 11)
SetStartLocPrio(22, 0, 6, MAP_LOC_PRIO_LOW)
SetStartLocPrio(22, 1, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 2, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 3, 11, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 4, 12, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 5, 14, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 6, 15, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 7, 16, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 8, 18, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(22, 9, 20, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(22, 13)
SetEnemyStartLocPrio(22, 0, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 1, 2, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 2, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 3, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 4, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 5, 7, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 6, 8, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 7, 9, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 8, 10, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 9, 11, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 10, 12, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 11, 13, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(22, 12, 14, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(23, 17)
SetStartLocPrio(23, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 3, 3, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 4, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 5, 5, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 6, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(23, 7, 7, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 8, 8, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 9, 10, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 10, 11, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 11, 12, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 12, 13, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 13, 16, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 14, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(23, 15, 22, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(23, 14)
SetEnemyStartLocPrio(23, 0, 0, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 1, 1, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 2, 2, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 3, 3, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 4, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 5, 5, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 6, 6, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 7, 7, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 8, 8, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(23, 9, 14, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 10, 16, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 11, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(23, 12, 22, MAP_LOC_PRIO_LOW)
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

