album :=
globals := love
check:
	luacheck *.lua --globals $(globals)
select:
	echo "return \"${album}\"">album.lua
play: select
	love .
