--[[
	Purpose: Provides a library for creating factions and having
	players able to be whitelisted to certain factions.
--]]

nut.class = nut.class or {}
nut.class.buffer = {}

function nut.class.Register(classTable)
	return table.insert(nut.class.buffer, classTable)
end

function nut.class.Get(index)
	return nut.class.buffer[index]
end

do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:CharClass()
		if (self.character) then
			return self.character:GetData("class")	
		end
	end

	if (SERVER) then
		function playerMeta:SetCharClass(index)
			if (self.character) then
				local class = nut.class.Get(index)

				if (class) then
					local result = true

					if (class.OnSet) then
						result = class:OnSet(self) or true
					end

					if (result == false) then
						return
					end
					
					self.character:SetData("class", index)
				end
			end
		end
	end
end