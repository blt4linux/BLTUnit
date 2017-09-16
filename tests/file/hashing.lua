
-- Generate with:
-- sha256sum rand1.dat | awk '{print $1}' | tr -d "\n" | sha256sum
local hash = file.FileHash(f .. "random_files/rand1.dat")
if hash ~= "0aa8db327da57615df2d6a62495bc9c1ceb87aa715db25fefa3ebd6686269df8" then
	error("Bad hash for rand1.dat: " .. hash)
end

-- Generate with:
-- find . -type f | xargs sha256sum | awk '{print $1}' | tr -d "\n" | sha256sum
local hash = file.DirectoryHash(f .. "random_files")
if hash ~= "32be5f78b5c7bc84ee0f24fcc6bbb0bbd711f37e99a47f97064c0f8c43192dfd" then
	error("Bad hash for random_files: " .. hash)
end

local res, err = file.FileHash("abcd")
if res or err ~= "No such file or directory" then
	error("Problem with error for DirectoryHash: hash='" .. tostring(res) .. "' err='" .. tostring(err) .. "'")
end

