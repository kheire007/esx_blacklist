-- CONFIG --

-- Blacklisted ped models
pedblacklist = {
	"CSB_BallasOG",
    "MP_S_ARMOURED_01",
	"S_F_Y_Cop_01",
	"S_F_Y_Cop_02",
	"S_F_Y_Cop_03",
	"Cop01SMY",
	"S_M_Y_Cop_02",
	"S_M_Y_Cop_03",
	"S_F_Y_Sheriff_01",
	"S_F_Y_Sheriff_02",
	"S_F_Y_Sheriff_03",
	"S_M_Y_Marine_01",
	"S_M_Y_Marine_02",
	"S_M_Y_Marine_03",
	"S_M_SECURITY_01",
	"S_M_SECURITY_02",
	"S_M_SECURITY_03",
	"S_M_Y_ARMYMECH_01",
	"S_M_Y_ARMYMECH_02",
	"S_M_Y_ARMYMECH_03",
	"S_M_Y_BLACKOPS_01",
	"S_M_Y_BLACKOPS_02",
	"S_M_Y_BLACKOPS_03"
}

-- Defaults to this ped model if an error happened
defaultpedmodel = "a_m_y_skater_01"

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerModel = GetEntityModel(playerPed)

			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					SetPlayerModel(PlayerId(), GetHashKey(defaultpedmodel))
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					SetPlayerModel(PlayerId(), prevPlayerModel)
					sendForbiddenMessage("This ped model is blacklisted!")
				end

				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end

	return false
end