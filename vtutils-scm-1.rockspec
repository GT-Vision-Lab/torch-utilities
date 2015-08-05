package = "vtutils"
version = "scm-1"

source = {
   url = "https://github.com/VT-vision-lab/torch-utilities",
   tag = "master"
}

description = {
   summary = "Utility package for torch",
   detailed = [[
   	    A utility torch package
   ]],
   homepage = "https://github.com/VT-vision-lab/torch-utilities"
}

dependencies = {
   "torch >= 7.0"
}

build = {
   type = "command",
   build_command = [[
cmake -E make_directory build;
cd build;
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)"; 
$(MAKE)
   ]],
   install_command = "cd build && $(MAKE) install"
}
