--
--------------------------------------------------------------------------------
--         File:  tensorutils.lua
--
--        Usage:  ./tensorutils.lua
--
--  Description:  Some utility functions for torch tensors, not originally present
--  				in Torch/Lua.
--  				Given a torch tensor, return a "set" of values present in it. 
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
--
require 'torch'

tensors = {}

function tensors.permute_vector(x, dim)
		order = torch.randperm(x:size()[1]):long()
		x = x:index(dim, order)
		return x
end  -----  end of function torch.FloatTensor:permute_tensor  -----

function tensors.set_length(x)

		local function tablelength(T)
				local count = 0
				for _ in pairs(T) do count = count + 1 end
				return count
		end
		t = x:view(x:nElement())

		map = {}
		for i = 1, (#t)[1] do
				map[t[i]] = true
		end
		return tablelength(map)
end  -----  end of function unique  -----

return tensors
