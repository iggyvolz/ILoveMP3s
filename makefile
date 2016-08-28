album :=
globals := love
check:
	luacheck *.lua --globals $(globals)
select:
	echo "return \"${album}\"">album.lua
play: select
	love .
gen-conf:
dist: select
	[ -f conf.lua ] || cp conf.default.lua conf.lua
	love-release -WM .
