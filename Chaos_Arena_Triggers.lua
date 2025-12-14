--NOTE: copy/paste into WorldEditor triggers module before saving map
function UnitMetaData(name, unitTypeId, dummyBuildingUnitTypeId, draftItemTypeId, draftAbilityId, abilityMetaData)
    return { name = name, unitTypeId = unitTypeId, dummyBuildingUnitTypeId = dummyBuildingUnitTypeId, draftItemTypeId = draftItemTypeId, draftAbilityId = draftAbilityId, abilityMetaData = abilityMetaData }
end

function UnitAbilityMetaData(water, earth, fire, passive)
    return { water = water, earth = earth, fire = fire, passive = passive }
end

local abilityIds = {
    AcidBomb = FourCC('A034'),
    AerialShackles = FourCC('A003'),
    AncestralSpirit = FourCC('A03X'),
    AnimateDead = FourCC('A02T'),
    AntiMagicShell = FourCC('A00A'),
    Avatar = FourCC('A028'),
    Banish = FourCC('A02E'),
    Bash = FourCC('A02A'),
    BigBadVoodoo = FourCC('A02Q'),
    BlackArrow = FourCC('A03I'),
    Bladestorm = FourCC('A02H'),
    Blizzard = FourCC('A027'),
    Bloodlust = FourCC('A005'),
    BreathOfFire = FourCC('A03E'),
    CarrionBeetles = FourCC('A022'),
    CarrionSwarm = FourCC('A02Z'),
    ChainLightning = FourCC('A02I'),
    Charm = FourCC('A00S'),
    CleavingAttack = FourCC('A03N'),
    ClusterRockets = FourCC('A039'),
    CriticalStrike = FourCC('A02F'),
    Cyclone = FourCC('A00H'),
    Curse = FourCC('A00B'),
    DarkPortal = FourCC('A03P'),
    DeathAndDecay = FourCC('A02W'),
    DeathCoil = FourCC('A02R'),
    DeathPact = FourCC('A02S'),
    DiseaseCloud = FourCC('A00C'),
    DivineShield = FourCC('A025'),
    Doom = FourCC('A03Q'),
    DrunkenBrawler = FourCC('A03F'),
    Earthquake = FourCC('A02K'),
    EntanglingRoots = FourCC('A00U'),
    FaerieFire = FourCC('A00I'),
    FanOfKnives = FourCC('A01Y'),
    FeralSpirit = FourCC('A02J'),
    FlameStrike = FourCC('A02D'),
    ForceOfNature = FourCC('A01P'),
    ForkedLightning = FourCC('A035'),
    FrostArmor = FourCC('A02V'),
    FrostArrows = FourCC('A036'),
    FrostNova = FourCC('A02U'),
    HardenedSkin = FourCC('A00J'),
    HealingSpray = FourCC('A033'),
    HealingWard = FourCC('A03R'),
    HealingWave = FourCC('A03T'),
    Hex = FourCC('A02P'),
    HolyLight = FourCC('A024'),
    HowlOfTerror = FourCC('A03M'),
    Immolation = FourCC('A01V'),
    Impale = FourCC('A030'),
    Incinerate = FourCC('A03J'),
    Inferno = FourCC('A021'),
    LifeDrain = FourCC('A004'),
    LightningAttack = FourCC('A00K'),
    LightningShield = FourCC('A007'),
    LocustSwarm = FourCC('A031'),
    ManaBurn = FourCC('A01U'),
    ManaFlare = FourCC('A00L'),
    ManaShield = FourCC('A037'),
    Metamorphosis = FourCC('A01W'),
    MirrorImage = FourCC('A02G'),
    PhaseShift = FourCC('A00M'),
    Phoenix = FourCC('A02C'),
    PocketFactory = FourCC('A038'),
    Possession = FourCC('A00D'),
    RainOfChaos = FourCC('A03O'),
    RainOfFire = FourCC('A03S'),
    RaiseDead = FourCC('A00E'),
    Reincarnation = FourCC('A02L'),
    Resurrection = FourCC('A026'),
    RoboGoblin = FourCC('A03A'),
    SearingArrows = FourCC('A01R'),
    SerpentWard = FourCC('A02O'),
    ShadowStrike = FourCC('A01Z'),
    Shockwave = FourCC('A02N'),
    Silence = FourCC('A03H'),
    Sleep = FourCC('A02Y'),
    SlowPoison = FourCC('A00O'),
    SoulBurn = FourCC('A03K'),
    SpellImmunity = FourCC('A00P'),
    SpikedCarapace = FourCC('A032'),
    SpiritLink = FourCC('A008'),
    SpiritTouch = FourCC('A00F'),
    Stampede = FourCC('A03D'),
    Starfall = FourCC('A01S'),
    StatisTrap = FourCC('A009'),
    StormBolt = FourCC('A02B'),
    StormEarthAndFire = FourCC('A03G'),
    SummonBear = FourCC('A03B'),
    SummonLavaSpawn = FourCC('A03L'),
    SummonQuilbeast = FourCC('A03C'),
    SummonWaterElemental = FourCC('A029'),
    Taunt = FourCC('A00Q'),
    ThunderClap = FourCC('A01T'),
    Tornado = FourCC('A03U'),
    Tranquility = FourCC('A01Q'),
    Transmute = FourCC('A00T'),
    Vengeance = FourCC('A020'),
    Volcano = FourCC('A023'),
    VorpalBlades = FourCC('A044'),
    WarStomp = FourCC('A02M'),
    Aura_Agility = FourCC('A006'),
    Aura_Armor = FourCC('A00N'),
    Aura_Damage = FourCC('A00G'),
    Aura_Intelligence = FourCC('A02X'),
    Aura_MaxMana = FourCC('A03W'),
    Aura_MaxHP = FourCC('A00R'),
    Aura_Strength = FourCC('A03V')
}

local draftableUnits = {
    akama = UnitMetaData('akama', FourCC('N009'), FourCC('h00S'), FourCC('I001'), FourCC('A01O'), UnitAbilityMetaData(abilityIds.Immolation, abilityIds.HardenedSkin, abilityIds.Taunt, abilityIds.Aura_Armor)),
    alchemist = UnitMetaData('alchemist', FourCC('N000'), FourCC('h00O'), FourCC('I000'), FourCC('A01C'), UnitAbilityMetaData(abilityIds.HealingSpray, abilityIds.AcidBomb, abilityIds.Transmute, abilityIds.Aura_Strength)),
    archimonde = UnitMetaData('archimonde', FourCC('U005'), FourCC('h00N'), FourCC('I002'), FourCC('A01K'), UnitAbilityMetaData(abilityIds.RainOfChaos, abilityIds.DarkPortal, abilityIds.Curse, abilityIds.Aura_MaxMana)),
    archmange = UnitMetaData('archmange', FourCC('H002'), FourCC('h00C'), FourCC('I003'), FourCC('A011'), UnitAbilityMetaData(abilityIds.LifeDrain, abilityIds.Blizzard, abilityIds.SummonWaterElemental, abilityIds.Aura_MaxHP)),
    beastmaster = UnitMetaData('beastmaster', FourCC('N001'), FourCC('h00T'), FourCC('I004'), FourCC('A01F'), UnitAbilityMetaData(abilityIds.SummonBear, abilityIds.SummonQuilbeast, abilityIds.Stampede, abilityIds.Aura_Agility)),
    blademaster = UnitMetaData('blademaster', FourCC('O000'), FourCC('h00F'), FourCC('I005'), FourCC('A014'), UnitAbilityMetaData(abilityIds.CriticalStrike, abilityIds.MirrorImage, abilityIds.Bladestorm, abilityIds.Aura_Damage)),
    bloodMage = UnitMetaData('bloodMage', FourCC('H004'), FourCC('h00E'), FourCC('I006'), FourCC('A013'), UnitAbilityMetaData(abilityIds.FlameStrike, abilityIds.Banish, abilityIds.Phoenix, abilityIds.Aura_MaxHP)),
    brewmaster = UnitMetaData('brewmaster', FourCC('N005'), FourCC('h00U'), FourCC('I007'), FourCC('A01G'), UnitAbilityMetaData(abilityIds.BreathOfFire, abilityIds.DrunkenBrawler, abilityIds.StormEarthAndFire, abilityIds.Aura_Armor)),
    cryptLord = UnitMetaData('cryptLord', FourCC('U003'), FourCC('h00M'), FourCC('I008'), FourCC('A01B'), UnitAbilityMetaData(abilityIds.Impale, abilityIds.SpikedCarapace, abilityIds.LocustSwarm, abilityIds.Aura_Intelligence)),
    darkRanger = UnitMetaData('darkRanger', FourCC('N007'), FourCC('h00V'), FourCC('I009'), FourCC('A01H'), UnitAbilityMetaData(abilityIds.Silence, abilityIds.BlackArrow, abilityIds.Charm, abilityIds.Aura_Agility)),
    deathKnight = UnitMetaData('deathKnight', FourCC('U000'), FourCC('h00J'), FourCC('I00A'), FourCC('A018'), UnitAbilityMetaData(abilityIds.DeathCoil, abilityIds.DeathPact, abilityIds.AnimateDead, abilityIds.Aura_Intelligence)),
    demonHunter = UnitMetaData('demonHunter', FourCC('E002'), FourCC('h007'), FourCC('I00B'), FourCC('A00X'), UnitAbilityMetaData(abilityIds.ManaBurn, abilityIds.PhaseShift, abilityIds.Metamorphosis, abilityIds.Aura_Damage)),
    dreadlord = UnitMetaData('dreadlord', FourCC('U002'), FourCC('h00L'), FourCC('I00C'), FourCC('A01A'), UnitAbilityMetaData(abilityIds.SpiritLink, abilityIds.Sleep, abilityIds.CarrionSwarm, abilityIds.Aura_Strength)),
    farSeer = UnitMetaData('farSeer', FourCC('O001'), FourCC('h00G'), FourCC('I00D'), FourCC('A015'), UnitAbilityMetaData(abilityIds.FeralSpirit, abilityIds.ChainLightning, abilityIds.Earthquake, abilityIds.Aura_MaxMana)),
    firelord = UnitMetaData('firelord', FourCC('N004'), FourCC('h00W'), FourCC('I00E'), FourCC('A01I'), UnitAbilityMetaData(abilityIds.Incinerate, abilityIds.SoulBurn, abilityIds.SummonLavaSpawn, abilityIds.Aura_Agility)),
    guldan = UnitMetaData('guldan', FourCC('O003'), FourCC('h00X'), FourCC('I00F'), FourCC('A01L'), UnitAbilityMetaData(abilityIds.DiseaseCloud, abilityIds.HealingWard, abilityIds.Doom, abilityIds.Aura_Armor)),
    jaina = UnitMetaData('jaina', FourCC('H009'), FourCC('h00Y'), FourCC('I00G'), FourCC('A01M'), UnitAbilityMetaData(abilityIds.RainOfFire, abilityIds.HealingWave, abilityIds.Tornado, abilityIds.Aura_MaxHP)),
    keeperOfTheGrove = UnitMetaData('keeperOfTheGrove', FourCC('E000'), FourCC('h005'), FourCC('I00H'), FourCC('A00V'), UnitAbilityMetaData(abilityIds.EntanglingRoots, abilityIds.ForceOfNature, abilityIds.Tranquility, abilityIds.Aura_MaxMana)),
    lich = UnitMetaData('lich', FourCC('U001'), FourCC('h00K'), FourCC('I00I'), FourCC('A019'), UnitAbilityMetaData(abilityIds.FrostNova, abilityIds.FrostArmor, abilityIds.DeathAndDecay, abilityIds.Aura_Armor)),
    mountainKing = UnitMetaData('mountainKing', FourCC('H003'), FourCC('h00D'), FourCC('I00J'), FourCC('A012'), UnitAbilityMetaData(abilityIds.StormBolt, abilityIds.Bash, abilityIds.Avatar, abilityIds.Aura_Strength)),
    murloc = UnitMetaData('murloc', FourCC('N008'), FourCC('h00P'), FourCC('I00K'), FourCC('A01N'), UnitAbilityMetaData(abilityIds.RaiseDead, abilityIds.LightningShield, abilityIds.AerialShackles, abilityIds.Aura_Agility)),
    ogreMauler = UnitMetaData('ogreMauler', FourCC('E004'), FourCC('h008'), FourCC('I00L'), FourCC('A00Y'), UnitAbilityMetaData(abilityIds.Inferno, abilityIds.CarrionBeetles, abilityIds.Volcano, abilityIds.Aura_MaxMana)),
    paladin = UnitMetaData('paladin', FourCC('H001'), FourCC('h00B'), FourCC('I00M'), FourCC('A010'), UnitAbilityMetaData(abilityIds.HolyLight, abilityIds.DivineShield, abilityIds.Resurrection, abilityIds.Aura_Intelligence)),
    pitLord = UnitMetaData('pitLord', FourCC('N006'), FourCC('h00Z'), FourCC('I00N'), FourCC('A01J'), UnitAbilityMetaData(abilityIds.HowlOfTerror, abilityIds.CleavingAttack, abilityIds.SpellImmunity, abilityIds.Aura_MaxHP)),
    priestessOfTheMoon = UnitMetaData('priestessOfTheMoon', FourCC('E001'), FourCC('h006'), FourCC('I00O'), FourCC('A00W'), UnitAbilityMetaData(abilityIds.ThunderClap, abilityIds.SearingArrows, abilityIds.Starfall, abilityIds.Aura_Damage)),
    seaWitch = UnitMetaData('seaWitch', FourCC('N002'), FourCC('h00Q'), FourCC('I00P'), FourCC('A01D'), UnitAbilityMetaData(abilityIds.ForkedLightning, abilityIds.FrostArrows, abilityIds.ManaShield, abilityIds.Aura_MaxMana)),
    shadowHunter = UnitMetaData('shadowHunter', FourCC('O004'), FourCC('h00I'), FourCC('I00Q'), FourCC('A017'), UnitAbilityMetaData(abilityIds.Hex, abilityIds.SerpentWard, abilityIds.BigBadVoodoo, abilityIds.Aura_MaxHP)),
    taurenChieftain = UnitMetaData('taurenChieftain', FourCC('O002'), FourCC('h00H'), FourCC('I00R'), FourCC('A016'), UnitAbilityMetaData(abilityIds.Shockwave, abilityIds.Reincarnation, abilityIds.WarStomp, abilityIds.Aura_Damage)),
    tinker = UnitMetaData('tinker', FourCC('N003'), FourCC('h00R'), FourCC('I00S'), FourCC('A01E'), UnitAbilityMetaData(abilityIds.PocketFactory, abilityIds.ClusterRockets, abilityIds.RoboGoblin, abilityIds.Aura_Intelligence)),
    warden = UnitMetaData('warden', FourCC('E003'), FourCC('h00A'), FourCC('I00T'), FourCC('A00Z'), UnitAbilityMetaData(abilityIds.FanOfKnives, abilityIds.ShadowStrike, abilityIds.Vengeance, abilityIds.Aura_Strength))
}

local purchaseableUpgrades = {
    criticalStrike = {
        item = FourCC('I00V'),
        upgrade = FourCC('R007'),
        ability = FourCC('A045')
    },
    evasion = {
        item = FourCC('I00W'),
        upgrade = FourCC('R006'),
        ability = FourCC('A04B')
    },
    hpRegen = {
        item = FourCC('I010'),
        upgrade = FourCC('R00B')
    },
    longRifles = {
        item = FourCC('I00Z'),
        upgrade = FourCC('R00C')
    },
    manaBurn = {
        item = FourCC('I00X'),
        upgrade = FourCC('R00D'),
        ability = FourCC('A049')
    },
    manaRegen = {
        item = FourCC('I011'),
        upgrade = FourCC('R003')
    },
    spikedArmor = {
        item = FourCC('I00U'),
        upgrade = FourCC('R004')
    },
    vampiricAura = {
        item = FourCC('I00Y'),
        upgrade = FourCC('R00A'),
        ability = FourCC('A04A')
    },
}

local unitTypeIdToName = {}
for key, metaData in pairs(draftableUnits) do
    unitTypeIdToName[metaData.unitTypeId] = key
end

local CIRCLE_OF_POWER_METADATA = UnitMetaData('circle_of_power', FourCC('n00A'), nil, nil, nil, UnitAbilityMetaData(FourCC('A042'), FourCC('A040'), FourCC('A041'), nil))

function GetUnitMetaData(unit)
    local unitTypeId = GetUnitTypeId(unit)
    if unitTypeId == CIRCLE_OF_POWER_METADATA.unitTypeId then
        return CIRCLE_OF_POWER_METADATA
    end

    return GetUnitTypeIdMetaData(unitTypeId)
end

function GetUnitTypeIdMetaData(unitTypeId)
    local name = unitTypeIdToName[unitTypeId]
    if name then
        return draftableUnits[name]
    end

    return nil
end

function MapListValues(tbl, fn)
    local result = {}
    for i = 1, #tbl do
        table.insert(result, fn(tbl[i]))
    end
    return result
end

function get_table_keys(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

function DEBUG_GetDuplicateAbilityIds()
    local duplicated = {}
    local used = {}
    local result = {}

    for _, unit in pairs(draftableUnits) do
        local metaData = unit.abilityMetaData
        if metaData.water and used[metaData.water] then duplicated[metaData.water]   = true end
        if metaData.earth and used[metaData.earth] then duplicated[metaData.earth]   = true end
        if metaData.fire and used[metaData.fire] then duplicated[metaData.fire]    = true end

        if metaData.water   then used[metaData.water]   = true end
        if metaData.earth   then used[metaData.earth]   = true end
        if metaData.fire    then used[metaData.fire]    = true end
        if metaData.passive then used[metaData.passive] = true end
    end

    return MapListValues(get_table_keys(duplicated),
        function (abilityId)
            for key, value in pairs(abilityIds) do
                if value == abilityId then
                    return key
                end
            end

            return abilityId
        end
    )
end

function DEBUG_GetUnusedAbilityIds()
    local used = {}
    local result = {}

    for _, unit in pairs(draftableUnits) do
        local metaData = unit.abilityMetaData
        if metaData.water   then used[metaData.water]   = true end
        if metaData.earth   then used[metaData.earth]   = true end
        if metaData.fire    then used[metaData.fire]    = true end
        if metaData.passive then used[metaData.passive] = true end
    end

    for _, abilityId in pairs(abilityIds) do
        if not used[abilityId] then
            result[abilityId] = true
        end
    end

    return MapListValues(get_table_keys(result),
        function (abilityId)
            for key, value in pairs(abilityIds) do
                if value == abilityId then
                    return key
                end
            end

            return abilityId
        end
    )
end

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

local PATHING_BLOCKER_UNIT_TYPE_ID = FourCC('YTfb')
local BUILDER_UNIT_TYPE_ID = FourCC('O005')
local ALTAR_UNIT_TYPE_ID = FourCC('h010')
local BLACKSMITH_UNIT_TYPE_ID = FourCC('n00B')
local DRAFT_ABILITY_ID = FourCC('A000')
local UPGRADE_ABILITY_ID = FourCC('A01X')
local CANCEL_ABILITY_ID = FourCC('A001')
local SWAP_UNITS_ABILITY_ID = FourCC('A03Z')
local ATTACK_ABILITY_ID = FourCC('Aatk')
local MOVE_ABILITY_ID = FourCC('Amov')
--note: used to hide health bars (also requires ObjectEditor IsBuilding=true, but can still move)
local INVULNERABLE_ABILITY_ID = FourCC('Avul')

local ORDER_IDs = {
    stop = 851972
}

local GLOBAL_ITEM_SET = {}
table.insert(GLOBAL_ITEM_SET, FourCC('bgst')) -- Belt of Giant Strength +6
table.insert(GLOBAL_ITEM_SET, FourCC('belv')) -- Boots of Quel'Thalas (+6 agility)
table.insert(GLOBAL_ITEM_SET, FourCC('cnob')) -- Circlet of Nobility (+2 Strength, Agility Intelligence)
table.insert(GLOBAL_ITEM_SET, FourCC('rat6')) -- Claws of Attack +5
table.insert(GLOBAL_ITEM_SET, FourCC('gcel')) -- Gloves of Haste (+.15)
table.insert(GLOBAL_ITEM_SET, FourCC('pmna')) -- Pendant of Mana (+250)
table.insert(GLOBAL_ITEM_SET, FourCC('prvt')) -- Periapt of Vitality (+150 health) - duplicate of rhth?
table.insert(GLOBAL_ITEM_SET, FourCC('rde4')) -- Ring of Protection (+5 armor)
table.insert(GLOBAL_ITEM_SET, FourCC('ciri')) -- Robe of the Magi (+6 intelligence)

local GLOBAL_ELEMENT_NAME_TO_COLOR = {
    water = '|cff0000ff',
    earth = '|cff00ff00',
    fire = '|cffff0000'
}

local COLOR_WHITE = '|cffffffff'

local GLOBAL_ELEMENT_NAME_TO_COLORED_STRING = {
    water = GLOBAL_ELEMENT_NAME_TO_COLOR.water .. 'Water' .. COLOR_WHITE,
    earth = GLOBAL_ELEMENT_NAME_TO_COLOR.earth .. 'Earth' .. COLOR_WHITE,
    fire = GLOBAL_ELEMENT_NAME_TO_COLOR.fire .. 'Fire' .. COLOR_WHITE,
}

local GLOBAL_TILE_SETUP = {
    itemCounts = {},
    elementCounts = {}
}

local playerIdMapping_draftedUnitsCount = {}
for playerId = 0, 11 do
    playerIdMapping_draftedUnitsCount[playerId] = 0
end

local playerIdMapping_realToProxy = {}
for playerId = 0, 11 do
    playerIdMapping_realToProxy[playerId] = playerId + 12
end
local playerIdMapping_proxyToReal = {}
for playerId = 12, 23 do
    playerIdMapping_proxyToReal[playerId] = playerId - 12
end

function IntegerToFourCC(i)
    local a = string.char(math.fmod(i, 256))
    i = math.floor(i / 256)
    local b = string.char(math.fmod(i, 256))
    i = math.floor(i / 256)
    local c = string.char(math.fmod(i, 256))
    i = math.floor(i / 256)
    local d = string.char(math.fmod(i, 256))
    
    return d .. c .. b .. a
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

function UpdateHeroLevel(unit, level)
    level = math.max(level, 1)
    
    local currentHeroLevel = GetHeroLevel(unit)
    if level > currentHeroLevel then
        SetHeroLevel(unit, level, false)
    elseif level < currentHeroLevel then
        UnitStripHeroLevel(unit, currentHeroLevel - level)
    end
end

local TARGETS_ITEM = 1 << 5
function DisableAttacks(unit)
    BlzSetUnitWeaponIntegerField(unit, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED, 0, TARGETS_ITEM)
    BlzSetUnitWeaponIntegerField(unit, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED, 1, TARGETS_ITEM)
end

function CalcUnitRotationAngle(unitLocationX, unitLocationY, lookAtX, lookAtY)
    local unitLocation = Location(unitLocationX, unitLocationY)
    local lookAtLocation = Location(lookAtX, lookAtY)
    local result = AngleBetweenPoints(unitLocation, lookAtLocation)
    RemoveLocation(unitLocation)
    RemoveLocation(lookAtLocation)
    return result
end

local HOTKEY_ON = ConvertAbilityStringField(FourCC('ahky'))
local HOTKEY_OFF = ConvertAbilityStringField(FourCC('auhk'))
function SetAbilityHotkey(unit, abilityId, key)
    local ability = BlzGetUnitAbility(unit, abilityId)
    BlzSetAbilityStringField(ability, HOTKEY_ON, key)
    BlzSetAbilityStringField(ability, HOTKEY_OFF, key)
end

function GetUnitAbilityTooltip(unit, abilityId, tooltip)
    local ability = BlzGetUnitAbility(unit, abilityId)
    return BlzGetAbilityStringLevelField(ability, ABILITY_SLF_TOOLTIP_NORMAL, 0)
end

function SetUnitAbilityTooltip(unit, abilityId, tooltip)
    local ability = BlzGetUnitAbility(unit, abilityId)
    BlzSetAbilityStringLevelField(ability, ABILITY_SLF_TOOLTIP_NORMAL, 0, tooltip)
end

function HideUnitHealthAndManaBars(unit, hidden)
    --BlzSetUnitBooleanField(unit, UNIT_BF_IS_A_BUILDING, hidden) -- only hides health if invulnerable, doesn't hide mana
    local scale = math.abs(BlzGetUnitRealField(unit, UNIT_RF_SELECTION_SCALE))
    if hidden then
        scale = scale * -1
    end

    BlzSetUnitRealField(unit, UNIT_RF_SELECTION_SCALE, scale)
end

function InitAbilityGridPositions()
    local tooltipsAlreadySet = {}

    for _, metaData in pairs(draftableUnits) do
        if metaData.abilityMetaData.passive then
            BlzSetAbilityPosX(metaData.abilityMetaData.passive, 0)
            BlzSetAbilityPosY(metaData.abilityMetaData.passive, 0)
            if not tooltipsAlreadySet[metaData.abilityMetaData.passive] then
                BlzSetAbilityTooltip(metaData.abilityMetaData.passive, BlzGetAbilityTooltip(metaData.abilityMetaData.passive, 0) .. ' (passive)', 0)
                tooltipsAlreadySet[metaData.abilityMetaData.passive] = true
            end
        end
        if metaData.abilityMetaData.water then
            BlzSetAbilityPosX(metaData.abilityMetaData.water, 1)
            BlzSetAbilityPosY(metaData.abilityMetaData.water, 0)
            if not tooltipsAlreadySet[metaData.abilityMetaData.water] then
                BlzSetAbilityTooltip(metaData.abilityMetaData.water, GLOBAL_ELEMENT_NAME_TO_COLOR.water .. BlzGetAbilityTooltip(metaData.abilityMetaData.water, 0) .. COLOR_WHITE, 0)
                tooltipsAlreadySet[metaData.abilityMetaData.water] = true
            end
        end
        if metaData.abilityMetaData.earth then
            BlzSetAbilityPosX(metaData.abilityMetaData.earth, 2)
            BlzSetAbilityPosY(metaData.abilityMetaData.earth, 0)
            if not tooltipsAlreadySet[metaData.abilityMetaData.earth] then
                BlzSetAbilityTooltip(metaData.abilityMetaData.earth, GLOBAL_ELEMENT_NAME_TO_COLOR.earth .. BlzGetAbilityTooltip(metaData.abilityMetaData.earth, 0) .. COLOR_WHITE, 0)
                tooltipsAlreadySet[metaData.abilityMetaData.earth] = true
            end
        end
        if metaData.abilityMetaData.fire then
            BlzSetAbilityPosX(metaData.abilityMetaData.fire, 3)
            BlzSetAbilityPosY(metaData.abilityMetaData.fire, 0)
            if not tooltipsAlreadySet[metaData.abilityMetaData.fire] then
                BlzSetAbilityTooltip(metaData.abilityMetaData.fire, GLOBAL_ELEMENT_NAME_TO_COLOR.fire .. BlzGetAbilityTooltip(metaData.abilityMetaData.fire, 0) .. COLOR_WHITE, 0)
                tooltipsAlreadySet[metaData.abilityMetaData.fire] = true
            end
        end
    end    
end

function GetUnitAbilityName(unit, abilityId)
    local ability = BlzGetUnitAbility(unit, abilityId)
    return BlzGetAbilityStringField(ability, ABILITY_SF_NAME)
end

function GetItemAbilityName(item, abilityId)
    local ability = BlzGetItemAbility(item, abilityId)
    return BlzGetAbilityStringField(ability, ABILITY_SF_NAME)
end

function SetDraftItemTooltip(item)
    local metaData = GLOBAL_DRAFT_SETS.draftItemTypeIds[GetItemTypeId(item)]
    local abilityMetaData = metaData.abilityMetaData

    local waterName = GetAbilityName(abilityMetaData.water)
    local earthName = GetAbilityName(abilityMetaData.earth)
    local fireName = GetAbilityName(abilityMetaData.fire)
    local passiveName = GetAbilityName(abilityMetaData.passive)

    local tooltip = ''
    tooltip = tooltip .. GLOBAL_ELEMENT_NAME_TO_COLOR.water .. waterName .. '|n'
    tooltip = tooltip .. GLOBAL_ELEMENT_NAME_TO_COLOR.earth .. earthName .. '|n'
    tooltip = tooltip .. GLOBAL_ELEMENT_NAME_TO_COLOR.fire .. fireName .. '|n'
    tooltip = tooltip .. COLOR_WHITE .. 'Aura: ' .. passiveName .. '|n'

    BlzSetItemExtendedTooltip(item, tooltip)
end


function GetUnitActivatedElements(unit)
    local unitType = GetUnitTypeId(unit)
    local name
    if unitType ~= CIRCLE_OF_POWER_METADATA.unitTypeId then
        name = GetHeroProperName(unit)
    else
        name = GetUnitName(unit)
    end

    return {
        water = string.find(name, GLOBAL_ELEMENT_NAME_TO_COLORED_STRING.water) ~= nil,
        earth = string.find(name, GLOBAL_ELEMENT_NAME_TO_COLORED_STRING.earth) ~= nil,
        fire = string.find(name, GLOBAL_ELEMENT_NAME_TO_COLORED_STRING.fire) ~= nil
    }
end

function SetAbilityUIState(whichUnit, abilityId, disabled, hidden)
    --NOTE: abilities have internal counter for disabled & hidden counts in case they're called simultaneously from multiple timed sources. Trick to reset counter is remove/add, then call the real values you want after a slight delay
    UnitRemoveAbility(whichUnit, abilityId)
    UnitAddAbility(whichUnit, abilityId)
    BlzUnitDisableAbility(whichUnit, abilityId, disabled, hidden)
end


function SetupUnitAbilities(unit, includeDisabled)
    local unitType = GetUnitTypeId(unit)
    local elements = GetUnitActivatedElements(unit)

    local metaData = GetUnitMetaData(unit)
    if not metaData then
        return
    end
    local abilityMetaData = metaData.abilityMetaData
    if not abilityMetaData then
        return
    end

    if abilityMetaData.passive then
        SetAbilityUIState(unit, abilityMetaData.passive, false, false)
    end
    
    if abilityMetaData.water then
        if elements.water or includeDisabled then
            SetAbilityUIState(unit, abilityMetaData.water, not elements.water, false)
            SetAbilityHotkey(unit, abilityMetaData.water, 'W')
            if not elements.water then
                SetUnitAbilityTooltip(unit, abilityMetaData.water, GetUnitAbilityTooltip(unit, abilityMetaData.water) .. ' (disabled)')
            end
        end
    end
    if abilityMetaData.earth then
        if elements.earth or includeDisabled then
            SetAbilityUIState(unit, abilityMetaData.earth, not elements.earth, false)
            SetAbilityHotkey(unit, abilityMetaData.earth, 'E')
            if not elements.earth then
                SetUnitAbilityTooltip(unit, abilityMetaData.earth, GetUnitAbilityTooltip(unit, abilityMetaData.earth) .. ' (disabled)')
            end
        end
    end
    if abilityMetaData.fire then
        if elements.fire or includeDisabled then
            SetAbilityUIState(unit, abilityMetaData.fire, not elements.fire, false)
            SetAbilityHotkey(unit, abilityMetaData.fire, 'R')
            if not elements.fire then
                SetUnitAbilityTooltip(unit, abilityMetaData.fire, GetUnitAbilityTooltip(unit, abilityMetaData.fire) .. ' (disabled)')
            end
        end
    end
end

function CopyUnitGear(sourceUnit, targetUnit)
    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(targetUnit, slotIndex)
        if item then
            RemoveItem(item)
        end
    end

    for slot = 0, 5 do
        local item = UnitItemInSlot(sourceUnit, slot)
        if item then
            local clonedItem = UnitAddItemById(targetUnit, GetItemTypeId(item))
            SetItemDroppable(clonedItem, false)
        end
    end
    
    local name
    local sourceType = GetUnitTypeId(sourceUnit)
    if sourceType == CIRCLE_OF_POWER_METADATA.unitTypeId then
        name = GetUnitName(sourceUnit)
    else
        name = GetHeroProperName(sourceUnit)
    end

    local targetType = GetUnitTypeId(targetUnit)
    if targetType == CIRCLE_OF_POWER_METADATA.unitTypeId then
        BlzSetUnitName(targetUnit, name)
    else
        BlzSetHeroProperName(targetUnit, name)
    end
end

function SwapUnitPositions(sourceUnit, targetUnit)
    local sourceX = GetUnitX(sourceUnit)
    local sourceY = GetUnitY(sourceUnit)
    local sourceFacing = GetUnitFacing(sourceUnit)
    local targetX = GetUnitX(targetUnit)
    local targetY = GetUnitY(targetUnit)
    local targetFacing = GetUnitFacing(targetUnit)
    
    SetUnitPosition(sourceUnit, targetX, targetY)
    SetUnitFacing(sourceUnit, targetFacing)
    SetUnitPosition(targetUnit, sourceX, sourceY)
    SetUnitFacing(targetUnit, sourceFacing)
end

function GetSpawnOffset(playerId)
    local SPAWN_OFFSET = 500
    local player = Player(playerId)
    local startX = GetPlayerStartLocationX(player)
    local startY = GetPlayerStartLocationY(player)
    local result = { x = 0, y = 0 }
    if math.abs(startX) >= math.abs(startY) then
        result.x = SPAWN_OFFSET

        if startX > 0 then
            result.x = -1 * result.x
        end
    else
        result.y = SPAWN_OFFSET

        if startY > 0 then
            result.y = -1 * result.y
        end
    end

    return result
end

local spawnedUnitsPerPlayerPerWave = {}
for playerId = 0, 11 do
    spawnedUnitsPerPlayerPerWave[playerId] = {}
end

local waveNumber = 0
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
            if heroLevel > 1 then
                UpdateHeroLevel(clonedUnit, heroLevel, false)
            end

            CopyUnitGear(unit, clonedUnit)
            SetupUnitAbilities(clonedUnit, false)

            for key, data in pairs(purchaseableUpgrades) do
                if data.ability then
                    if GetPlayerTechResearched(player, data.upgrade, true) then
                        SetAbilityUIState(clonedUnit, data.ability, false, true)
                    end
                end
            end

            local attackLoc = Location(0, 0)
            IssuePointOrderLoc(clonedUnit, 'attack', attackLoc)
            RemoveLocation(attackLoc)

            table.insert(spawnedUnitsPerPlayerPerWave[playerId][waveNumber], clonedUnit)
        end
    end)
    
    DestroyGroup(group)
end

function SpawnWaveAllPlayers()
    waveNumber = waveNumber + 1
    for playerId = 0, 11 do
        spawnedUnitsPerPlayerPerWave[playerId][waveNumber] = {}
    end

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
    altar = {},
    blacksmith = {}
}
local playerDecks = {}

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

local gameTimerSecondsElapsed = 0
function InitGameTimer()
    local countdownTimer = CreateTimer()
    TimerStart(countdownTimer, 1, true, function()
        gameTimerSecondsElapsed = gameTimerSecondsElapsed + 1
        OnGameTimerSecondsTick()
    end)
end

local playerTileCoords = {}
function UnlockPlayerTiles(playerId, count)
    local player = Player(playerId)
    local lookAtAngle = CalcUnitRotationAngle(0, 0, 0, 0)

    for tile = 1, count do
        local tileIndex = 9 - #playerTileCoords[playerId] + 1
        local pos = table.remove(playerTileCoords[playerId], 1)
        local circle = CreateUnit(player, CIRCLE_OF_POWER_METADATA.unitTypeId, pos.x, pos.y, lookAtAngle)
        SetUnitVertexColor(circle, 255, 50, 255, 255)

        local itemCount = GLOBAL_TILE_SETUP.itemCounts[tileIndex]
        local elementCount = GLOBAL_TILE_SETUP.elementCounts[tileIndex]
        for itemIndex = 1, itemCount do
            local itemType = GLOBAL_ITEM_SET[math.random(1, #GLOBAL_ITEM_SET)]
            local item = UnitAddItemById(circle, itemType)
            SetItemDroppable(item, false)
        end

        local elements = get_table_keys(GLOBAL_ELEMENT_NAME_TO_COLORED_STRING)
        local shuffledElements = CloneAndShuffleArray(elements)
        local chosenElements = {}
        for element = 1, elementCount do
            local elementName = table.remove(shuffledElements, 1)
            chosenElements[elementName] = true
        end
        
        local name = ''
        for elementName, elementColor in pairs(GLOBAL_ELEMENT_NAME_TO_COLORED_STRING) do
            if chosenElements[elementName] then
                name = name .. elementColor .. ' '
            end
        end
        BlzSetUnitName(circle, name)
        SetupUnitAbilities(circle, false)
    end
end

function InitPlayerDecks()
    for playerId = 0, 11 do
        playerDecks[playerId] = CloneAndShuffleArray(get_table_keys(GLOBAL_DRAFT_SETS.draftItemTypeIds))
        AddDraftItemsToAltar(playerId)
    end
end

function InitPlayerBase(playerId)
    local player = Player(playerId)
    local offset = GetSpawnOffset(playerId)
    local startLocation = { x = GetPlayerStartLocationX(player), y = GetPlayerStartLocationY(player) }
    local lookAtAngle = CalcUnitRotationAngle(startLocation.x, startLocation.y, startLocation.x + offset.x, startLocation.y + offset.y)

    local builder = CreateUnit(player, BUILDER_UNIT_TYPE_ID, startLocation.x, startLocation.y, lookAtAngle)
    UnitRemoveAbility(builder, ATTACK_ABILITY_ID)
    UnitAddAbility(builder, INVULNERABLE_ABILITY_ID)

    local buildingStartPosition = { x = startLocation.x - offset.x / 2, y = startLocation.y - offset.y / 2 }
    local buildingOffsets = { x = 0, y = 0 }
    if math.abs(offset.x) > math.abs(offset.y) then
        buildingOffsets.y = 200
    else
        buildingOffsets.x = 200
    end
    local altar = CreateUnit(player, ALTAR_UNIT_TYPE_ID, buildingStartPosition.x + buildingOffsets.x, buildingStartPosition.y + buildingOffsets.y, lookAtAngle)    
    UnitRemoveAbility(altar, ATTACK_ABILITY_ID)
    UnitAddAbility(altar, INVULNERABLE_ABILITY_ID)

    --NOTE: Neutral allows other players to see what purchases have been made
    local blacksmith = CreateUnit(player, BLACKSMITH_UNIT_TYPE_ID, buildingStartPosition.x - math.max(buildingOffsets.x, 10), buildingStartPosition.y - math.max(buildingOffsets.y, 10), lookAtAngle)    

    playerBuilders.primary[playerId] = builder
    playerBuilders.altar[playerId] = altar
    playerBuilders.blacksmith[playerId] = blacksmith

    UnlockPlayerTiles(playerId, 3)

    SelectUnitForPlayerSingle(builder, player)
    SetCameraPositionForPlayer(player, GetUnitX(builder), GetUnitY(builder))
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
    local altar = playerBuilders.altar[playerId]
    if not altar then
        return
    end
    
    local items = DrawChoicesFromDeck(playerId)
    for i = 1, #items do
        local item = UnitAddItemById(altar, items[i])
        SetDraftItemTooltip(item)
    end
end

function OnConstructFinish()
    local unit = GetConstructedStructure()
    local unitType = GetUnitTypeId(unit)
    if GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[unitType] then
        OnUnitDrafted(unit)
    end
end

function OnItemSold()
    local item = GetSoldItem()
    local itemType = GetItemTypeId(item)
    local unit = GetBuyingUnit()
    local player = GetOwningPlayer(unit)

    for key, data in pairs(purchaseableUpgrades) do
        if data.item == itemType then
            AddPlayerTechResearched(player, data.upgrade, 1)
            break
        end
    end

    RemoveItem(item)
end

local STOP_ORDER_ID = 851972
function OnIssuedOrder() 
    if GetIssuedOrderId() == STOP_ORDER_ID then
        return
    end

    if GetSpellAbilityId() == SWAP_UNITS_ABILITY_ID then
        return
    end

    local unit = GetTriggerUnit()
    if GetPlayerId(GetOwningPlayer(unit)) <= 11 and unitTypeIdToName[GetUnitTypeId(unit)] ~= nil then
        IssueImmediateOrderById(unit, STOP_ORDER_ID)
        PauseUnit(unit, true)
        PauseUnit(unit, false)
    end
end

local MIN_X, MIN_Y
function SwapTileUnits(caster, target)
    local player = GetOwningPlayer(caster)
    
    local casterX = GetUnitX(caster)
    local casterY = GetUnitY(caster)
    local targetX = GetUnitX(target)
    local targetY = GetUnitY(target)
    
    --todo: check if this is necessary (assuming it'll have collision issues otherwise & bump position slightly)
    SetUnitX(caster, MIN_X)
    SetUnitY(caster, MIN_Y)
    SetUnitX(target, MIN_X)
    SetUnitY(target, MIN_Y)

    local casterType = GetUnitTypeId(caster)
    local targetType = GetUnitTypeId(target)
    local casterFacing = GetUnitFacing(caster)
    local targetFacing = GetUnitFacing(target)
    
    local newCaster = CreateUnit(player, casterType, targetX, targetY, targetFacing)
    local newTarget = CreateUnit(player, targetType, casterX, casterY, casterFacing)
    
    UnitRemoveAbility(newCaster, MOVE_ABILITY_ID)
    UnitAddAbility(newCaster, INVULNERABLE_ABILITY_ID)
    DisableAttacks(newCaster)    

    UnitRemoveAbility(newTarget, MOVE_ABILITY_ID)
    UnitAddAbility(newTarget, INVULNERABLE_ABILITY_ID)
    DisableAttacks(newTarget)    
    
    CopyUnitGear(target, newCaster)
    CopyUnitGear(caster, newTarget)

    local newTargetHeroLevel = GetHeroLevel(target)
    if newTargetHeroLevel > 1 then
        UpdateHeroLevel(newTarget, newTargetHeroLevel, false)
    end
    local newCasterHeroLevel = GetHeroLevel(caster)
    if newCasterHeroLevel > 1 then
        UpdateHeroLevel(newCaster, newCasterHeroLevel, false)
    end

    local targetStillHadSwap = UnitRemoveAbility(target, SWAP_UNITS_ABILITY_ID)
    if targetStillHadSwap then
        UnitAddAbility(newTarget, SWAP_UNITS_ABILITY_ID)
    end

    RemoveUnit(caster)
    RemoveUnit(target)

    SetupUnitAbilities(newCaster, true)
    SetupUnitAbilities(newTarget, true)
    HideUnitHealthAndManaBars(newCaster, true)
    HideUnitHealthAndManaBars(newTarget, true)
end

function OnSpellEffect()
    local abilityId = GetSpellAbilityId()
    local unit = GetSpellAbilityUnit()
    local player = GetOwningPlayer(unit)
    local unitTypeId = GetUnitTypeId(unit)

    if abilityId == CANCEL_ABILITY_ID and unitTypeId == ALTAR_UNIT_TYPE_ID then
        SelectUnitForPlayerSingle(playerBuilders.primary[GetPlayerId(player)], player)
        return
    end

    if abilityId == CANCEL_ABILITY_ID and unitTypeId == BLACKSMITH_UNIT_TYPE_ID then
        for i = 0, #playerBuilders.blacksmith do
            if playerBuilders.blacksmith[i] == unit then
                SelectUnitForPlayerSingle(playerBuilders.primary[i], Player(i))
            end
        end
        return
    end

    if abilityId == DRAFT_ABILITY_ID then
        SelectUnitForPlayerSingle(playerBuilders.altar[GetPlayerId(player)], player)
        return
    end

    if abilityId == UPGRADE_ABILITY_ID then
        SelectUnitForPlayerSingle(playerBuilders.blacksmith[GetPlayerId(player)], player)
        return
    end

    if abilityId == SWAP_UNITS_ABILITY_ID then
        local caster = GetSpellAbilityUnit()
        local target = GetSpellTargetUnit()
        SwapTileUnits(caster, target)
        return
    end

    --todo: create abilities in object editor
    if abilityId == FourCC('A014') then
        OnSoulSiphonEffect()
        return
    elseif abilityId == FourCC('A015') then
        OnHealingWaveEffect()
        return
    end
end

function UnitHasItems(unit)
    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(unit, slotIndex)
        if item then
            return true
        end
    end

    return false
end

function OnUnitDrafted(unit)
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player)

    local foodUsed = GetPlayerState(player, PLAYER_STATE_RESOURCE_FOOD_USED)
    local foodCap = GetPlayerState(player, PLAYER_STATE_RESOURCE_FOOD_CAP)
    if foodUsed > foodCap then
        DisplayTextToPlayer(player, 0, 0, 'Food Cap Exceeded')
        RemoveUnit(unit)
        return
    end

    local circle
    local group = CreateGroup()
    local unitX = GetUnitX(unit)
    local unitY = GetUnitY(unit)
    GroupEnumUnitsInRange(group, unitX, unitY, 100, nil)
    ForGroup(group, function()
        local enumUnit = GetEnumUnit()
        if GetUnitTypeId(enumUnit) == CIRCLE_OF_POWER_METADATA.unitTypeId then
            circle = enumUnit
            return
        end
    end)

    DestroyGroup(group)

    if circle == nil then
        DisplayTextToPlayer(player, 0, 0, 'Must build on Circle of Power')
        RemoveUnit(unit)
        return        
    end

    local dummyUnitTypeId = GetUnitTypeId(unit)
    RemoveUnit(unit)

    local realUnitTypeId = GLOBAL_DRAFT_SETS.dumyBuildingUnitTypeIds[dummyUnitTypeId].unitTypeId

    DraftUnit(playerId, realUnitTypeId, circle)
end

function DraftUnit(playerId, unitTypeId, circle)
    local player = Player(playerId)
    local altar = playerBuilders.altar[playerId]

    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(altar, slotIndex)
        if item then
            RemoveItem(item)
        end
    end

    local draftedCount = playerIdMapping_draftedUnitsCount[playerId] + 1
    playerIdMapping_draftedUnitsCount[playerId] = draftedCount

    local builder = playerBuilders.primary[playerId]
    local nextDraftTimeInSeconds = GetDraftCooldownMinutes(draftedCount) * 60
    BlzEndUnitAbilityCooldown(builder, DRAFT_ABILITY_ID)
    local cooldownSeconds = nextDraftTimeInSeconds - gameTimerSecondsElapsed
    if cooldownSeconds > 0 then
        BlzStartUnitAbilityCooldown(builder, DRAFT_ABILITY_ID, cooldownSeconds)
    end

    local circleX = GetUnitX(circle)
    local circleY = GetUnitY(circle)

    --todo: check if this is necessary (assuming it'll have collision issues otherwise & bump position slightly)
    --SetUnitX(circle, MIN_X)
    --SetUnitY(circle, MIN_Y)

    local unit = CreateUnit(player, unitTypeId, circleX, circleY, CalcUnitRotationAngle(circleX, circleY, 0, 0))
    CopyUnitGear(circle, unit)

    RemoveUnit(circle)

    UnitAddAbility(unit, INVULNERABLE_ABILITY_ID)
    UnitAddAbility(unit, SWAP_UNITS_ABILITY_ID)
    UnitRemoveAbility(unit, MOVE_ABILITY_ID)
    DisableAttacks(unit)
    SetupUnitAbilities(unit, true)
    HideUnitHealthAndManaBars(unit, true)
    if draftedCount > 1 then
        UpdateHeroLevel(unit, draftedCount, false)
    end

    SelectUnitForPlayerSingle(playerBuilders.primary[playerId], player)
    
    AddDraftItemsToAltar(playerId)
end

function PerformComputerDraft(playerId)
    local player = Player(playerId)
    local altar = playerBuilders.altar[playerId]

    local draftableItems = {}
    for slotIndex = 0, 5 do
        local item = UnitItemInSlot(altar, slotIndex)
        if item then
            table.insert(draftableItems, item)
        end
    end

    local chosenItem = draftableItems[math.random(1, #draftableItems)]
    local metaData = GLOBAL_DRAFT_SETS.draftItemTypeIds[GetItemTypeId(chosenItem)]
    local unitTypeId = metaData.unitTypeId

    local circles = {}
    local group = CreateGroup()
    GroupEnumUnitsOfPlayer(group, player, nil)
    ForGroup(group, function()
        local enumUnit = GetEnumUnit()
        if GetUnitTypeId(enumUnit) == CIRCLE_OF_POWER_METADATA.unitTypeId then
            table.insert(circles, enumUnit)
        end
    end)
    DestroyGroup(group)

    local chosenCircle = circles[math.random(1, #circles)]

    DraftUnit(playerId, unitTypeId, chosenCircle)
    UnitUseItemPoint(altar, chosenItem, GetUnitX(chosenCircle), GetUnitY(chosenCircle))
end


function OnSoulSiphonEffect()
    local caster = GetSpellAbilityUnit()
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
	local AOE_RADIUS = 175
    local casterOwner = GetOwningPlayer(caster)
    local group = CreateGroup()
    GroupEnumUnitsInRange(group, targetX, targetY, AOE_RADIUS, nil)
    
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
                -- todo: test if already granted by OnDeath event
                --AdjustPlayerStateBJ(5, casterOwner, PLAYER_STATE_RESOURCE_GOLD)
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
    GroupEnumUnitsInRange(group, targetX, targetY, AOE_RADIUS, nil)
    
    ForGroup(group, function()
        local target = GetEnumUnit()        
        if IsUnitOwnedByPlayer(target, casterOwner) and GetUnitState(target, UNIT_STATE_LIFE) > 0 then
            local maxHP = GetUnitState(target, UNIT_STATE_MAX_LIFE)
            local currentHP = GetUnitState(target, UNIT_STATE_LIFE)
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
        
        local actualPlayerId = playerIdMapping_proxyToReal[killerIndex]
        if actualPlayerId then
            AdjustPlayerStateBJ(1, Player(actualPlayerId), PLAYER_STATE_RESOURCE_GOLD)
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

function pow(base, exponent)
    return math.exp(math.log(base) * exponent)
end

local ANTI_SNOWBALL_POISON = FourCC('B007')
function ApplyNegativeHPRegen()
    local hpRegenTimer = CreateTimer()
    TimerStart(hpRegenTimer, 15.0, true, function()
        for playerId = 0, 11 do
            for waveIndex = waveNumber-1, 1, -1 do
                local ageOfWave = waveNumber - waveIndex
                local damageMultiplier = pow(1.1, ageOfWave) - 1
                local waveUnits = spawnedUnitsPerPlayerPerWave[playerId][waveIndex]
                for unitIndex = #waveUnits, 1, -1 do
                    local unit = waveUnits[unitIndex]
                    local currentLife = GetUnitState(unit, UNIT_STATE_LIFE)
                    if currentLife > 0 then
                        local damage = GetUnitState(unit, UNIT_STATE_MAX_LIFE) * damageMultiplier
                        local newLife = currentLife - damage

                        SetUnitState(unit, UNIT_STATE_LIFE, newLife)
                        --todo: test, but it appears there's no function for adding buffs so I probably need to do it with a dummy unit casting a spell
                        UnitAddAbility(unit, ANTI_SNOWBALL_POISON)
                        SetUnitAbilityLevel(unit, ANTI_SNOWBALL_POISON, 1)
                        if newLife <= 0 then
                            table.remove(waveUnits, unitIndex)
                        end
                    else
                        table.remove(waveUnits, unitIndex)
                    end
                end
            end
        end
    end)
end

function GrantPassiveXP()
    local xpTimer = CreateTimer()
    TimerStart(xpTimer, 60.0, true, function()
        for playerId = 0, 11 do
            local player = Player(playerId)
            if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
                local builder = playerBuilders.primary[playerId]
                AddHeroXP(builder, 15, true)
            end
        end
    end)
end

local foodCapIncreaseMinutes = {
    0, 1, 2, 3, 5, 8, 12, 17, 23
}
function GetDraftCooldownMinutes(foodUsed)
    return foodCapIncreaseMinutes[math.min(foodUsed+1, #foodCapIncreaseMinutes)]
end

local nextFoodCapIncreaseSeconds = 0
local foodCap = 0
function IncreaseFoodCap()
    if foodCap >= #foodCapIncreaseMinutes then
        return
    end

    foodCap = foodCap + 1
    nextFoodCapIncreaseSeconds = GetDraftCooldownMinutes(foodCap) * 60

    for playerId = 0, 11 do
        local player = Player(playerId)
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            SetPlayerStateBJ(player, PLAYER_STATE_RESOURCE_FOOD_CAP, foodCap)
            if math.fmod(foodCap, 3) == 0 and foodCap < 9 then
                UnlockPlayerTiles(playerId, 3)
            end
            if GetPlayerController(player) == MAP_CONTROL_COMPUTER then
                PerformComputerDraft(playerId)
            end

            --not working (wrong path to level, only hero models support level up animation due to origin target location in mesh, but can use Abilities\Spells\Other\Levelup\Levelupcaster.mdx)
            --SetUnitAnimation(playerBuilders.altar[playerId], 'levelup')
            --PlaySound('Sounds/Internal/Abilities/Spells/Other/Levelup')
            --SelectUnitForPlayerSingle(playerBuilders.altar[playerId], Player(playerId))
        end
    end
end

function OnGameTimerSecondsTick()
    if gameTimerSecondsElapsed >= nextFoodCapIncreaseSeconds then
        IncreaseFoodCap()
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
            if playerIndex ~= otherPlayerIndex then
                local otherPlayer = Player(otherPlayerIndex)
                local otherTeam = GetPlayerTeam(otherPlayer)
                if team == otherTeam then
                    local otherProxyPlayer = Player(playerIdMapping_realToProxy[otherPlayerIndex])
                    SetPlayerAlliance(otherProxyPlayer, proxyPlayer, ALLIANCE_PASSIVE, true)
                    SetPlayerAlliance(proxyPlayer, otherProxyPlayer, ALLIANCE_PASSIVE, true)
                end
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
    for playerId = 0, 11 do
        local player = Player(playerId)
        local proxyPlayer = Player(playerIdMapping_realToProxy[playerId])
        if GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            SetPlayerController(proxyPlayer, MAP_CONTROL_COMPUTER)
            
            if GetLocalPlayer() == player then
                --SetTerrainFogEx(0, 0, 100000, 0.0, 0.0, 0.0, 0.0)
                --SetCameraField(CAMERA_FIELD_FARZ, 10000.0, 0)
                SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 3000, 0)
            end
        end
    end

    InitPlayerTiles()
    InitPlayerBases()
    InitPlayerDecks()
    InitPlayerAlliances()    
end

function PrintDebugInfo()
    local duplicates = DEBUG_GetDuplicateAbilityIds()
    if #duplicates > 0 then
        print('duplicated abilities: ' .. table.concat(duplicates, ' '))
    else
        print('no duplicates')
    end

    local unused = DEBUG_GetUnusedAbilityIds()
    if #unused > 0 then
        print('unused abilities: ' .. table.concat(unused, ' '))
    else
        print('no unused abilities')
    end
end

function Init()
	MeleeStartingVisibility()
	MeleeClearExcessUnits()
	FogEnableOff()
	FogMaskEnableOff()
    InitAbilityGridPositions()
	InitPlayers()
    CreateWaveSpawnLabels()
    CreateSpawnTimer()
    InitGameTimer()
    GrantWoodPassive()
    ApplyNegativeHPRegen()
    GrantPassiveXP()

    local worldBounds = GetWorldBounds()
    MIN_X = GetRectMinX(worldBounds)
    MIN_Y = GetRectMinY(worldBounds)
    RemoveRect(worldBounds)

    local deathTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(deathTrigger, OnUnitDeath)
    
    local spellTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(spellTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddAction(spellTrigger, OnSpellEffect)

    local buildTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(buildTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddAction(buildTrigger, OnConstructFinish)
    --PrintDebugInfo()

    local disableDraftUnitAbilities = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(disableDraftUnitAbilities, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerRegisterAnyUnitEventBJ(disableDraftUnitAbilities, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddAction(disableDraftUnitAbilities, OnIssuedOrder)
    
    local itemSoldTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(itemSoldTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddAction(itemSoldTrigger, OnItemSold)
end

--[[
    xpcall(function()
    end, function(error) print(error) end)
--]]