--
--------------------------------------------------------------------------------
--         File:  unique.lua
--
--        Usage:  ./unique.lua
--
--  Description:  Given a torch tensor, return a "set" of values present in it. 
--  				For instance, set[item] will be true if the item exists, and
--  				set[item] will be nil if it doesnt. Thus, this gives an easy way
--  				to index and check if a value exists in a torch tensor
--
--       Author:  Ramakrishna Vedantam (vrama91), <vrama91@vt.edu>
-- Organization:  Virginia Tech
--      Version:  1.0
--      Created:  08/12/2015
--------------------------------------------------------------------------------
--
require 'torch'

function torch.Tensor:unique()
		t = self:view(self:nElement())
		
		map = {}
		for i = 1, (#t)[1] do
				map[t[i]] = true
		end
		return map
end

