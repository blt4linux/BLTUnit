
local res, val = vm.xpcall(function(...)
	return ...
end, nil, 123)

if val ~= 123 then
	error("Arguments not passed through vm.xpcall")
end

