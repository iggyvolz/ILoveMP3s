playlist={}
currentSong=1
loaded=false
paused=false
function timify(n)
  n=math.floor(n)
  m=math.floor(n/60)
  s=n-(60*m)
  return string.format("%02d:%02d",m,s)
end
function love.load(t)
  assert(love.filesystem.isDirectory("assets"),"No assets directory found.")
  for i,v in ipairs(love.filesystem.getDirectoryItems("assets")) do
    if love.filesystem.isFile("assets/"..v) then
      local success,data = pcall(function() return love.audio.newSource("assets/"..v) end )
      if success then
        table.insert(playlist,{name=v,sound=data})
      end
    end
  end
  assert(#playlist>0,"No songs found.")
  playlist[currentSong].sound:play()
  loaded=true
end
function love.update(dt)
  if not loaded then return end
  if paused then return end
  if playlist[currentSong].sound:isPlaying() then return end
  if not playlist[currentSong] then
    currentSong=1
    paused=true
    return
  end
  currentSong=currentSong+1
  playlist[currentSong].sound:play()
end
function love.draw()
  if not loaded then love.graphics.print("Loading...") end
  if paused then
    love.graphics.print(playlist[currentSong].name.." (paused)",0,0)
  else
    love.graphics.print(playlist[currentSong].name,0,0)
  end
  love.graphics.print(timify(playlist[currentSong].sound:tell()),0,10)
  love.graphics.print("Play/Pause-Space  Next/Last Song-Left/Right",0,20)
end
function love.keypressed(k)
  if k==" " then
    if paused then
      paused=false
      playlist[currentSong].sound:play()
    else
      paused=true
      playlist[currentSong].sound:pause()
    end
  elseif k=="right" then
    playlist[currentSong].sound:stop()
  elseif k=="left" then
    if playlist[currentSong].sound:tell()<5 and currentSong ~= 1 then
      playlist[currentSong].sound:stop()
      currentSong=currentSong-1
      playlist[currentSong].sound:play()
    else
      playlist[currentSong].sound:stop()
      playlist[currentSong].sound:play()
    end
  end
end
