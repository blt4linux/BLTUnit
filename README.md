# BLTUnit

A PAYDAY 2 BLT Unit-testing system

## What is BLTUnit

BLTUnit is a system to unit-test the API for the BLT4L (and possibly
other loaders/lua mods in the future). This is to make it easier to
modify BLT4L and be sure you haven't broken anything.

## How to use

BLTUnit does nothing, unless the environment variable `BLTUnit` is set.

In the interests of making it easy to run the tests, create a shell script somewhere
easily accessable, and be sure to set the executable flag (`chmod +x filename`):

```
#!/usr/bin/env bash

# Load the environment variables required for Steam
source "steam_env"

# Go to where PD2 is located
# If you have it installed elsewhere, change this.
pd_path="$HOME/.steam/steam/steamapps/common/PAYDAY 2"
cd "$pd_path"

# Run PD2
export BLTUnit=1
LD_PRELOAD=$so_path" ./payday2_release
```

Now make another file in the same place as the first one, called `steam_env`:

```
export SteamAppUser=<your username>
export SteamAppId=218620
export SteamGameId=$SteamAppId
export SteamUser=$SteamAppUser
export suppress_restart=1
```

Where `<your username>` is your normal steam username - the one you see in
your friends list, not any kind of numeric ID.

Now, run the first script and the unit tests will be run. PAYDAY 2 will open then
quickly close, after the tests have been run.

## Adding unit tests
Add a .lua file anywhere inside `tests`. Raising an error with `assert` or `error` will
fail the test.

Inside a unit test, you can use the variable `f` to access the location of the
unit test - for example, to load test data. This variable is set for each test, so
feel free to overwrite it and use the name for your own stuff.

By convention, you should group your tests into lower-case-named directories, one per object
you are testing (ex: `SystemFS`) with one Lua file for each function/method you are testing.

Example:
```
if not SystemFS:exists(f .. "sample") then
        error("Bad SystemFS state!")
end
```

## TODO

* Use a custom base.lua, completely replacing the current base system.
* Make an option to run BLTUnit from the Mod Options menu
* Make a custom function for failing a unit test, so errors can be shown seperately.

