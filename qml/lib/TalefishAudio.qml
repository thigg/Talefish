/*

Talefish Audiobook Player
Copyright (C) 2016-2019  John Gibbon

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

*/
import QtQuick 2.6
import QtMultimedia 5.6

Audio {
    audioRole: Audio.MusicRole
    autoLoad: true
    playbackRate: app.options.playbackRate
    onPlaybackRateChanged: if(isPlaying) seek(position - 0.01);
    property bool isPlaying: playbackState === Audio.PlayingState
    property int displayPosition: Math.max(position, app.playlist.applyThisTrackPosition)
//    onDurationChanged: {
//        console.log('AUDIO: duration changed', duration);
//        console.log('status is: ', status, 'loaded?', status === Audio.Loaded, 'buffered?', status === Audio.Buffered)
//        console.log('playlist data', JSON.stringify(app.playlist.currentMetaData))
//    }

    function playPause() {
        if(!isPlaying) {
            play();
        } else {
            pause();
        }
    }
}
