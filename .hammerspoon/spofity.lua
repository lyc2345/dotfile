
-- Spotify control
Hyper:bind({}, 'P', function()
	spotify_was_playing = hs.spotify.isPlaying()
	if spotify_was_playing then
		hs.spotify.pause()
		hs.alert.show("Spotify - Pause", AlertStyle)
	else
		hs.spotify.play()
		hs.alert.show("Spotify - Play", AlertStyle)
		hs.alert.show(
			hs.spotify.getCurrentArtist() ..
			" - "
			.. hs.spotify.getCurrentTrack(),
			AlertStyle
		)
	end
end)
