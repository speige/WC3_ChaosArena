function MakeBuildersInvulnerable()
    ForGroup(GetUnitsOfTypeIdAll(FourCC('hpea')), function()
        SetUnitInvulnerable(GetEnumUnit(), true)
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

	MakeBuildersInvulnerable()
end

function Init()
	MeleeStartingVisibility()
	MeleeClearExcessUnits()
	FogEnableOff()
	FogMaskEnableOff()
	InitPlayers()
	SetAllTilesUnbuildable()
end

--[[


--]]