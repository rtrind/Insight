--[[
Copyright (C) 2020, 2021 penguin0616

This file is part of Insight.

The source code of this program is shared under the RECEX
SHARED SOURCE LICENSE (version 1.0).
The source code is shared for referrence and academic purposes
with the hope that people can read and learn from it. This is not
Free and Open Source software, and code is not redistributable
without permission of the author. Read the RECEX SHARED
SOURCE LICENSE for details
The source codes does not come with any warranty including
the implied warranty of merchandise.
You should have received a copy of the RECEX SHARED SOURCE
LICENSE in the form of a LICENSE file in the root of the source
directory. If not, please refer to
<https://raw.githubusercontent.com/Recex/Licenses/master/SharedSourceLicense/LICENSE.txt>
]]

-- dryer.lua
local function Describe(self, context)
	local description = nil

	if not self.product then
		-- no product
		return
	end

	if self.paused or not self.task or not self.task:NextTime() then
		-- we are paused
		description = context.lstr.dryer_paused
	else
		if self:IsDrying() and self:GetTimeToDry() then
			local product = (context.usingIcons and PrefabHasIcon(self.product)) or nil
			-- drying
			if product then
				description = string.format(context.lstr.dry_time, self.product, TimeToText(time.new(self:GetTimeToDry(), context)))
			else
				description = string.format(context.lstr.lang.dry_time, TimeToText(time.new(self:GetTimeToDry(), context)))
			end
		elseif self:IsDone() and self:GetTimeToSpoil() then
			-- TODO: check for rot later
			description = string.format(context.lstr.perishable.transition, context.lstr.perishable.spoil, TimeToText(time.new(self:GetTimeToSpoil(), context)))
		end
	end

	return {
		priority = 0,
		description = description
	}
end

return {
	Describe = Describe
}