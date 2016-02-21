local playlist={}
local currentSong
local currentSongNum=1
local loaded=false
local paused=false
local album=require "album"
function timify(n)
  local n=math.floor(n)
  local m=math.floor(n/60)
  local s=n-(60*m)
  return string.format("%02d:%02d",m,s)
end
function loadSong(name)
  local success,data = pcall(function() return love.audio.newSource("assets/"..album.."/"..name) end )
  assert(success,data)
  return data
end
function love.load(t)
  assert(love.filesystem,"Love filesystem is needed.  If you would like to add support for 0.8 or before, place songs directly into playlist and comment this line.")
  assert(love.filesystem.isDirectory("assets/"..album),"No assets directory found.")
  for i,v in ipairs(love.filesystem.getDirectoryItems("assets/"..album)) do
    if love.filesystem.isFile("assets/"..album.."/"..v) then
      table.insert(playlist,v)
    end
  end
  assert(#playlist>0,"No songs found.")
  currentSong=loadSong(playlist[currentSongNum])
  currentSong:play()
  loaded=true
end
function love.update(dt)
  if not loaded then return end
  if paused then return end
  if currentSong:isPlaying() then return end
  if not playlist[currentSongNum+1] then
    currentSongNum=1
    paused=true
    return
  end
  currentSongNum=currentSongNum+1
  currentSong=loadSong(playlist[currentSongNum])
  currentSong:play()
end
function love.draw()
  if not loaded then love.graphics.print("Loading...") return end
  if paused then
    love.graphics.print(playlist[currentSongNum].." (paused)",0,0)
  else
    love.graphics.print(playlist[currentSongNum],0,0)
  end
  love.graphics.print(timify(currentSong:tell()),0,10)
  love.graphics.print("Play/Pause-Space  Next/Last Song-Left/Right",0,20)
end
function love.keypressed(k)
  if k==" " or k=="space" then
    if paused then
      paused=false
      currentSong:play()
    else
      paused=true
      currentSong:pause()
    end
  elseif k=="right" then
    currentSong:stop()
  elseif k=="left" then
    if currentSong:tell()<5 and currentSong ~= 1 then
      currentSong:stop()
      currentSongNum=currentSongNum-1
      currentSong:play()
    else
      currentSong:stop()
      currentSong:play()
    end
  end
end
