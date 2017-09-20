local res, err, a, b

res, a, b = pcall(function(...)
	return ...
end, 123, 456)

assert(res, "Function is valid")
assert(a == 123, "pcall not passing retvals")
assert(b == 456, "pcall not passing multiple retvals")

res, err = pcall(function(msg)
	error(msg)
end, "testing")

assert(res == false, "Function raises error")
assert(err ~= "testing", "pcall not passing error msg")

