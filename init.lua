require 'torch'

local vtutils = {}

vtutils.obtain_gpu_lock_id = require 'vtutils.obtain_gpu_lock_id'
vtutils.tensors = require 'vtutils.tensorutils'

return vtutils
