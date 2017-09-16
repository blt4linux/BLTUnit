
file.RemoveDirectory(f .. "sample")
file.RemoveDirectory(f .. "sample2")

file.CreateDirectory(f .. "sample")

if not SystemFS:exists(f .. "sample") then
	error("Bad SystemFS state!")
end

if SystemFS:exists(f .. "sample2") then
	error("Bad SystemFS state!")
end

file.MoveDirectory(f .. "sample", f .. "sample2");

if SystemFS:exists(f .. "sample") then
	error("Bad SystemFS state!")
end

if not SystemFS:exists(f .. "sample2") then
	error("Bad SystemFS state!")
end

local res, err = file.MoveDirectory(f .. "abc", f .. "def")
if res or err ~= "No such file or directory" then
	error("Bad MoveDirectory()")
end

file.RemoveDirectory(f .. "sample2")

