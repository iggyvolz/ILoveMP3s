ILoveMP3s - a minimalist MP3 player written in Love (a Lua framework).

Controls:
Play/pause with space bar
Go to beginning of song with left arrow (goes to previous song if within first 5 seconds)
Go to next song with right arrow

To package your mp3 files, put them all into assets/{album name}.  Songs will be played in alphabetical order, so it is highly recommended that you include the song number at the beginning, like so: 01 - [Song Name].mp3

To run , install [love](http://love2d.org) and run `make play album={album name}`.  If you do not have make installed, you can do this manually be writing: `return "album name"` to album.lua and then running `love .`.

To build .app's, .exe's, or .love's, please see [love's documentation](https://love2d.org/wiki/Game_Distribution).

This software is licensed under the MIT license.  Please see the LICENSE file for more details.
