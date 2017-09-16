
if not os.getenv("BLTUnit") then return end

log("/-------------------------------------\\")
log("|          BLT UNIT                   |")
log("\\-------------------------------------/")
log("Running tests...")

local run_test

local function test_dir(path)
	local tests = {}

	for _, t in pairs(file.GetFiles(path)) do
		if t:sub(-4) == ".lua" then
			table.insert(tests, path .. "/" .. t)
		end
	end

	if #tests > 0 then
		log("Running tests in " .. path)
	end

	local result = ""
	local success = true

	for _, path in pairs(tests) do
		local tsuccess, tresult = run_test(path)
		result = result .. tresult
		success = success and tsuccess
	end

	for _, t in pairs(file.GetDirectories(path)) do
		local ssuccess, sresult = test_dir(path .. "/" .. t)
		success = success and ssuccess

		result = result .. " " .. sresult
	end

	return success, result
end

run_test = function(file)
	local test, err = vm.loadfile(file)
	if not test then
		log("Error loading test " .. file .. ": " .. err)
		return false, "!"
	end

	local env = {}
	setmetatable(env, {
		__index = _G
	})
	setfenv(test, env)

	env.f = string.gsub(file, "(.*/)(.*)", "%1")

	local luaerror = false
	local success = vm.xpcall(test, function(msg)
		log(debug.traceback(tostring(msg), 2))
		luaerror = true
	end)

	if not success and not luaerror then
		log("Test " .. file .. " mysteriously failed - maybe a error in C?")
	end

	return success, success and "." or (luaerror and "E" or "@")
end

local success, result = test_dir(ModPath .. "tests")
log("Test Results: " .. result)

log("/-------------------------------------\\")
if success then
	log("|          Completed - Success        |")
else
	log("| !!!!!!!! Completed - Error !!!!!!!! |")
end
log("\\-------------------------------------/")

-- Quit - right now
core:import("CoreEngineAccess")
CoreEngineAccess._quit()

