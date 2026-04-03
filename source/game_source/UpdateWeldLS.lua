local _ = game.Players.LocalPlayer
local v_u_1 = false
local v_u_2 = {}
function sendRequestToOtherClients(p3)
	-- upvalues: (ref) v_u_2, (ref) v_u_1
	for v4 = 1, #p3 do
		local v5 = p3[v4]
		local v6 = { v5, v5.C0, v5.C1 }
		local v7 = v_u_2
		table.insert(v7, 1, v6)
		table.remove(v_u_2, 51)
	end
	if not v_u_1 then
		v_u_1 = true
		spawn(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_1
			while #v_u_2 > 0 do
				script.UpdateOtherClientsRE:FireServer(v_u_2)
				v_u_2 = {}
				wait()
			end
			v_u_1 = false
		end)
	end
end
function requestedWeldUpdate(p8)
	for v9 = #p8, 1, -1 do
		local v10 = p8[v9]
		local v11 = v10[1]
		local v12 = v10[2]
		local v13 = v10[3]
		if game:GetService("CollectionService"):HasTag(v11, "ClientCanUpdate") then
			v11.C0 = v12
			v11.C1 = v13
		end
	end
end
script:WaitForChild("UpdateRequestRE").OnClientEvent:Connect(requestedWeldUpdate)
script:WaitForChild("UpdateClientsWeldE").Event:Connect(sendRequestToOtherClients)
