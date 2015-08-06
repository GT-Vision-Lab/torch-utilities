--
--------------------------------------------------------------------------------
--         File:  gpu_lock.lua
--
--        Usage: From any Torch or Lua Shell, use following commands
--        		> require 'obtain_gpu_lock_id'
--
--        		To obtain and lock an id:
--        		> id = obtain_gpu_lock_id.get_id() -- status.
--        		The lock is automatically freed when the parent terminates
--
--				*NOT RECOMMENDED*
--        		To get an id that won't be freed:
--        		> id = obtain_gpu_lock_id.get_hog_id() -- status.
--        		You *must* manually free these ids:
--        		> obtain_gpu_lock_id.release_id(id)
--				
--  Description:  Wrapper for gpu_lock in Lua. 
--              
--  			If an ID lock is obtained in the default way, the lock is 
--  			automatically freed when the parent process ends (even if it crashes) 
--  			or on a system reboot. 
--
--  			It is also possible to get a lock that will persist 
--  			and that must be manually freed. Make sure you release the ID you 
--  			obtain using this code.
--
-- Requirements:  gpu_lock.py file should exist on the system. Obtain it from 
-- 					http://homepages.inf.ed.ac.uk/imurray2/code/gpu_monitoring/
--
--       Author:  Ramakrishna Vedantam (vrama91), <vrama91@vt.edu>
-- Organization:  Virginia Tech
--      Version:  1.0
--      Created:  08/05/2015
--------------------------------------------------------------------------------
--
require 'os'
path_to_gpu_lock = '/srv/share/gpu_lock/gpu_lock.py' -- Path on VT Server

function os.capture(cmd, raw)
		local f = assert(io.popen(cmd, 'r'))
		local s = assert(f:read('*a'))
		f:close()
		if raw then return s end
		s = string.gsub(s, '^%s+', '')
		s = string.gsub(s, '%s+$', '')
		s = string.gsub(s, '[\n\r]+', ' ')
		return s
end

local function error_check()
		no_error = true
		if(os.rename(path_to_gpu_lock, path_to_gpu_lock)==nil) then
				error('Cannot find gpu_lock.py utility')
				no_error = false
		end
end ----- end of function error_check -----

obtain_gpu_lock_id = {}

function obtain_gpu_lock_id.get_hog_id()                               -- get an ID to run GPU jobs on
		-- If ID is -1, i.e. no GPU is available, torch will run jobs on CPU
		error_check()
		ID = tonumber(os.capture("exec " .. path_to_gpu_lock .. " --id-to-hog")) -- Run the gpu lock utility
		if(ID == -1) then
				print('No GPU available, Torch will run job on CPU with this ID')
		end
		return ID
end  -----  end of function get_hog_id  -----

------------------------------------------------------------------------
--         Name:  obtain_gpu_lock_id.get_release_id
--      Purpose:  Obtain a gpu lock ID and release it once the process quits
--   Parameters:  None
--      Returns:  GPU ID / -1 for CPU
------------------------------------------------------------------------

function obtain_gpu_lock_id.get_id()
		error_check()
		ID = tonumber(os.capture("exec " .. path_to_gpu_lock .. " --id")) -- Run the gpu lock utility
		if(ID == -1) then
				print('No GPU available, Torch will run job on CPU with this ID')
		end
		return ID
end  -----  end of function obtain_gpu_lock_id.get_id()  -----



function obtain_gpu_lock_id.release_id ( ID)                       -- release the ID GPU jobs were running on
		error_check()                           
		if(ID ~= -1) then
				os.execute("exec " .. path_to_gpu_lock .. " --free " .. ID)
		else
				print('Job was running on CPU. Nothing to release.')	
		end
end  -----  end of function release_id  -----



