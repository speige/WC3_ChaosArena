--NOTE: copy/paste into WorldEditor before saving map
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

local abilityIds = {
    AcidBomb = '',
    AerialShackles = '',
    AnimateDead = '',
    Avatar = '',
    Banish = '',
    Bash = '',
    BigBadVoodoo = '',
    BlackArrow = '',
    Bladestorm = '',
    Blizzard = '',
    BreathOfFire = '',
    CarrionBeetles = '',
    CarrionSwarm = '',
    ChainLightning = '',
    Charm = '',
    CleavingAttack = '',
    ClusterRockets = '',
    CriticalStrike = '',
    DarkPortal = '',
    DeathCoil = '',
    DeathPact = '',
    DeathAndDecay = '',
    DiseaseCloud = '',
    DivineShield = '',
    Doom = '',
    DrunkenBrawler = '',
    Earthquake = '',
    EntanglingRoots = '',
    Evasion = '',
    FanOfKnives = '',
    FeralSpirit = '',
    FlameStrike = '',
    ForceOfNature = '',
    ForkedLightning = '',
    FrostArmor = '',
    FrostArrows = '',
    FrostNova = '',
    HardenedSkin = '',
    HealingSpray = '',
    HealingWard = '',
    HealingWave = '',
    Hex = '',
    HolyLight = '',
    HowlOfTerror = '',
    Immolation = '',
    Impale = '',
    Incinerate = '',
    Inferno = '',
    LifeDrain = '',
    LightningAttack = '',
    LightningShield = '',
    LocustSwarm = '',
    ManaBurn = '',
    ManaShield = '',
    Metamorphosis = '',
    MirrorImage = '',
    Phoenix = '',
    PocketFactory = '',
    Possession = '',
    RainOfChaos = '',
    RainOfFire = '',
    RaiseDead = '',
    Reincarnation = '',
    Resurrection = '',
    Robo_Goblin = '',
    SearingArrows = '',
    SerpentWard = '',
    ShadowStrike = '',
    Shockwave = '',
    Silence = '',
    Sleep = '',
    SummonQuilbeast = '',
    SoulBurn = '',
    SpikedCarapace = '',
    Stampede = '',
    Starfall = '',
    StormBolt = '',
    Storm_Earth_andFire = '',
    SummonBear = '',
    SummonLavaSpawn = '',
    SummonWaterElemental = '',
    Taunt = '',
    ThunderClap = '',
    Tornado = '',
    Tranquility = '',
    Transmute = '',
    VampiricAura = '',
    Vengeance = '',
    Volcano = '',
    WarStomp = '',
    AncestralSpirit = '',
    Anti_MagicShell = '',
    Bloodlust = '',
    Curse = '',
    FaerieFire = '',
    ManaFlare = '',
    ResistantSkin = '',
    SlowPoison = '',
    SpellImmunity = '',
    SpiritLink = '',
    SpiritTouch = '',
    StatisTrap = '',
    StoneForm = '',
    VorpalBlades = ''
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

local CIRCLE_OF_POWER_UNIT_TYPE_ID = FourCC('n00A')
local BUILDER_UNIT_TYPE_ID = FourCC('h000')
local ALTAR_UNIT_TYPE_ID = FourCC('h010')
local DRAFT_ABILITY_ID = FourCC('A000')
local CANCEL_ABILITY_ID = FourCC('A001')
local INVULNERABLE_ABILITY_ID = FourCC('Avul') --note: used to hide health bars (also requires ObjectEditor IsBuilding=true, but can still move)

local ORDER_IDs = {
    stop = 851972
}

local GLOBAL_ITEM_SET = {}
table.insert(GLOBAL_ITEM_SET, FourCC('bgst'))
table.insert(GLOBAL_ITEM_SET, FourCC('belv'))
table.insert(GLOBAL_ITEM_SET, FourCC('cnob'))
table.insert(GLOBAL_ITEM_SET, FourCC('rat6'))
table.insert(GLOBAL_ITEM_SET, FourCC('gcel'))
table.insert(GLOBAL_ITEM_SET, FourCC('rhth'))
table.insert(GLOBAL_ITEM_SET, FourCC('pmna'))
table.insert(GLOBAL_ITEM_SET, FourCC('prvt'))
table.insert(GLOBAL_ITEM_SET, FourCC('rde4'))
table.insert(GLOBAL_ITEM_SET, FourCC('ciri'))
--table.insert(GLOBAL_ITEM_SET, FourCC('texp')) -- need to create custom item that's not consumeable but passively adds XP [also, circle needs to be converted to hero or game crashes]

local GLOBAL_ELEMENT_NAMES = {
    fire = '|cffff0000Fire|cffffffff',
    earth = '|cff00ff00Earth|cffffffff',
    water = '|cff0000ffWater|cffffffff'
}

local GLOBAL_TILE_SETUP = {
    itemCounts = {},
    elementCounts = {}
}

local playerIdMapping_realToProxy = {}
for playerId = 0, 11 do
    playerIdMapping_realToProxy[playerId] = playerId + 12
end
local playerIdMapping_proxyToReal = {}
for playerId = 12, 23 do
    playerIdMapping_proxyToReal[playerId] = playerId - 12
end

function WeightedRandom(weights)
    local total = 0
    for _, weight in ipairs(weights) do
        total = total + weight
    end
    
    local rand = math.random() * total
    local cumulative = 0
    
    for i, weight in ipairs(weights) do
        cumulative = cumulative + weight
        if rand <= cumulative then
            return i
        end
    end
    
    return #weights
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
    local offset = 500
    local player = Player(playerId)
    local startX = GetPlayerStartLocationX(player)
    local startY = GetPlayerStartLocationY(player)
    local result = { x = 0, y = 0 }
    if (math.abs(startX) >= math.abs(startY)) then
        result.x = offset

        if (startX > 0) then
            result.x = -1 * result.x
        end
    else
        result.y = offset

        if (startY > 0) then
            result.y = -1 * result.y
        end
    end
    
    return result
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
            local clonedUnit = CreateUnit(proxyPlayer, unitType, x + offset.x, y + offset.y, CalcUnitRotationAngle(x, y, 0, 0))
            UnitRemoveAbility(clonedUnit, INVULNERABLE_ABILITY_ID)

            local heroLevel = GetHeroLevel(unit)
            if heroLevel > 0 then
                for i = 1, heroLevel - 1 do
                    SetHeroLevel(clonedUnit, heroLevel, false)
                end
            end

            for itemSlot = 1, 6 do
                local item = UnitItemInSlot(unit, itemSlot)
                if (item) then
                    local clonedItem = UnitAddItemById(clonedUnit, itemType)
                    SetItemDroppable(clonedItem, false)
                end
            end

            local attackLoc = Location(0, 0)
            IssuePointOrderLoc(clonedUnit, 'attack', attackLoc)
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
        local offset = GetSpawnOffset(playerId)
        local player = Player(playerId)
        local text = CreateTextTag()  
        SetTextTagText(text, '', 0.024)
        SetTextTagPos(text, GetPlayerStartLocationX(player) + offset.x * 2, GetPlayerStartLocationY(player) + offset.y * 2, 0)
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

local playerTileCoords = {}

function UnlockPlayerTiles(playerId, count)
    local player = Player(playerId)
    local offset = GetSpawnOffset(playerId)
    local startLocation = { x = GetPlayerStartLocationX(player), y = GetPlayerStartLocationY(player) }
    local lookAtAngle = CalcUnitRotationAngle(startLocation.x, startLocation.y, startLocation.x + offset.x, startLocation.y + offset.y)

    for tile = 1, count do
        local tileIndex = 9 - #playerTileCoords[playerId] + 1
        local pos = table.remove(playerTileCoords[playerId], 1)
        local circle = CreateUnit(player, CIRCLE_OF_POWER_UNIT_TYPE_ID, pos.x, pos.y, lookAtAngle)
        SetUnitVertexColor(circle, 255, 50, 255, 255)

        local itemCount = GLOBAL_TILE_SETUP.itemCounts[tileIndex]
        local elementCount = GLOBAL_TILE_SETUP.elementCounts[tileIndex]
        for itemIndex = 1, itemCount do
            local itemType = GLOBAL_ITEM_SET[math.random(1, #GLOBAL_ITEM_SET)]
            local item = UnitAddItemById(circle, itemType)
            SetItemDroppable(item, false)
        end

        local elements = get_table_keys(GLOBAL_ELEMENT_NAMES)
        local shuffledElements = CloneAndShuffleArray(elements)
        local elemNames = {}
        for element = 1, elementCount do
            table.insert(elemNames, GLOBAL_ELEMENT_NAMES[table.remove(shuffledElements, 1)])
        end
        local name = table.concat(elemNames, ' ')
        BlzSetUnitName(circle, name)
    end
end

function InitPlayerDecks()
    for playerId = 0, 11 do
        playerDecks[playerId] = CloneAndShuffleArray(get_table_keys(GLOBAL_DRAFT_SETS.draftItemTypeIds))
    end
end

function InitPlayerBase(playerId)
    local player = Player(playerId)
    local offset = GetSpawnOffset(playerId)
    local startLocation = { x = GetPlayerStartLocationX(player), y = GetPlayerStartLocationY(player) }

    local lookAtAngle = CalcUnitRotationAngle(startLocation.x, startLocation.y, startLocation.x + offset.x, startLocation.y + offset.y)
    local builder = CreateUnit(player, BUILDER_UNIT_TYPE_ID, startLocation.x, startLocation.y, lookAtAngle)
    UnitRemoveAbility(builder, FourCC('Aatk'))
    UnitAddAbility(builder, INVULNERABLE_ABILITY_ID)

    local offset = GetSpawnOffset(playerId)
    local altar = CreateUnit(player, ALTAR_UNIT_TYPE_ID, startLocation.x - offset.x / 2, startLocation.y - offset.y / 2, lookAtAngle)
    UnitRemoveAbility(altar, FourCC('Aatk'))
    UnitAddAbility(altar, INVULNERABLE_ABILITY_ID)

    playerBuilders.primary[playerId] = builder
    playerBuilders.altar[playerId] = altar

    UnlockPlayerTiles(playerId, 3)

    SelectUnitForPlayerSingle(builder, player)
    SetCameraPositionLocForPlayer(player, GetUnitLoc(builder))
end

function InitPlayerBases()
    for playerId = 0, 11 do
        local player = Player(playerId)
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            InitPlayerBase(playerId)
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
    --SetUnitAnimation(altar, 'levelup')
    --PlaySound('Sounds/Internal/Abilities/Spells/Other/Levelup')
    --SelectUnitForPlayerSingle(altar, Player(playerId))
end

function OnConstructFinish()
    local unit = GetConstructedStructure()
    local unitType = GetUnitTypeId(unit)
    if GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[unitType] then
        OnUnitDrafted(unit)
    end
end

function SetAbilityUIState(whichUnit, abilityId, disabled, hidden)
    --NOTE: abilities have internal counter for disable & hidden counts in case they're called simultaneously from multiple timed sources, but remove/add resets counter
    UnitRemoveAbility(whichUnit, abilityId)
    UnitAddAbility(whichUnit, abilityId)
    BlzUnitDisableAbility(whichUnit, abilityId, disabled, hidden)
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
    GroupEnumUnitsInRange(group, unitX, unitY, 100, nil)
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
    
    ForGroup(group, function()
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
    
    ForGroup(group, function()
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
                    if foodCap % 3 == 0 and foodCap < 9 then
                        UnlockPlayerTiles(playerId, 3)
                    end
                    if not UnitHasItems(playerBuilders.altar[playerId]) then
                        AddDraftItemsToAltar(playerId)
                    end
                end
            end
        end)
    end
end

function InitPlayerAlliances()
    for playerIndex=0,11 do
        local player = Player(playerIndex)
        local proxyPlayer = Player(playerIdMapping_realToProxy[playerIndex])
        SetPlayerAlliance(player, proxyPlayer, ALLIANCE_PASSIVE, true)
        SetPlayerAlliance(proxyPlayer, player, ALLIANCE_PASSIVE, true)
        local team = GetPlayerTeam(player)
        SetPlayerTeam(proxyPlayer, team)

        for otherPlayerIndex=0,11 do
            if (playerIndex ~= otherPlayerIndex) then
                local otherProxyPlayer = Player(playerIdMapping_realToProxy[otherPlayerIndex])
                SetPlayerAlliance(otherProxyPlayer, proxyPlayer, ALLIANCE_PASSIVE, true)
                SetPlayerAlliance(proxyPlayer, otherProxyPlayer, ALLIANCE_PASSIVE, true)
            end
        end
    end
end

function InitPlayerTiles()
    for i = 1, 9 do
        table.insert(GLOBAL_TILE_SETUP.itemCounts, WeightedRandom({25, 25, 20, 15, 10, 5}))
        table.insert(GLOBAL_TILE_SETUP.elementCounts, WeightedRandom({50, 40, 10}))
    end

    for playerId = 0, 11 do
        local player = Player(playerId)
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            local tileCoords = {}
            local offset = GetSpawnOffset(playerId)
            local baseX = GetPlayerStartLocationX(player) + offset.x
            local baseY = GetPlayerStartLocationY(player) + offset.y
            for x = -1, 1 do
                for y = -1, 1 do
                    table.insert(tileCoords, {x = baseX + (x * 125), y = baseY + (y * 125)})
                end
            end
            playerTileCoords[playerId] = CloneAndShuffleArray(tileCoords)
        end
    end
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

    InitPlayerTiles()
    InitPlayerBases()
    InitPlayerDecks()
    InitPlayerAlliances()
end

function Init()
	MeleeStartingVisibility()
	MeleeClearExcessUnits()
	FogEnableOff()
	FogMaskEnableOff()
	InitPlayers()
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
    xpcall(function()
    end, function(error) print(error) end)
--]]