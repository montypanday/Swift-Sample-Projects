//
//  MusicPlayer.swift
//  MusicPlayer
//
//  Created by Mohamed Abdelrazek on 21/3/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import AVFoundation

typealias SongDetails = (index : Int, title : String, singer : String, timeElapsed : Double, duration : Double)

//This class maintains the list of songs available for the user to play
class PlayList {
    var songsBySinger : [String : [String]] = [ String : [String]] ()
    var songs : [String] = [String]()
    init() {
        songs += ["yanni_allsessons", "adele_hello", "luis fonsi_despacito"]
        songsBySinger = [
            "Yanni" : ["yanni_allsessons"] ,
            "Adele" : ["adele_hello"],
            "Luis Fonsi" : ["Luis Fonsi_despacito"]
        ]
    }
    func getSongAt(forSinger : String, index : Int) -> (song : String, singer : String) {
        if forSinger == "All" {
            let song = songs[ abs(index) % songs.count ]
            let singer = String(song[..<song.index(of: "_")!])
            return ( song, singer)
        }
        if songsBySinger[forSinger] != nil {
            let song = songsBySinger[forSinger]![ abs(index) % songsBySinger[forSinger]!.count]
            return ( song, forSinger)
        }
        return ("" , "")
        
    }
    
}

//This class is an abstract representation of the music player logic
class MusicPlayer {
    
    //vars
    var playList : PlayList
    var currentSong : SongDetails
    
    var filterBy : String = "All"
    var player : AVAudioPlayer!
    
    init(_ list : PlayList, filter : String = "All") {
        playList = list
        filterBy = filter
        currentSong = (0 , "" , "All" , 0 , 0)
    }
    
    func getCurrentSong() -> SongDetails {
        currentSong.timeElapsed = player.currentTime
        return currentSong
    }
    
    func setCurrentSong(filter: String, index: Int) -> Bool{
        let (song , singer) = playList.getSongAt(forSinger: filter, index: index)
        if loadSong(song) == true {
            currentSong = (index : index, title: song, singer: singer , timeElapsed : 0, duration : player.duration)
            return true
        }
        else { return false }
    }
    
    func loadSong(_ songPath : String, _ type : String = "mp3" , _ subDirectory : String = "songs") -> Bool {
        let path = Bundle.main.path(forResource: songPath, ofType: type, inDirectory: subDirectory)
        let url = URL(fileURLWithPath: path!)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        }
        catch {
            print("could not play this song \(songPath)")
            return false
        }
        return true
    }
    
    func play(filterBy : String) {
        if setCurrentSong(filter: filterBy, index: currentSong.index) &&
            loadSong(currentSong.title) == true {
            player.play()
        }
    }
    func resume() {
        if player != nil {
            player.play()
        }
    }
    
    func next(filterBy : String) {
        if setCurrentSong(filter: filterBy, index: currentSong.index + 1) &&
            loadSong(currentSong.title) == true {
            player.play()
        }
    }
    
    func previous(filterBy : String) {
        if setCurrentSong(filter: filterBy, index: currentSong.index - 1) && loadSong(currentSong.title) == true {
            player.play()
        }
    }
    
    func pause() {
        if  player != nil {
            player.pause()
        }
    }
    
    func stop() {
        if  player != nil {
            player.stop()
        }
    }
    
    func changeVolume( newValue : Float) {
        if player != nil {
            player.volume = newValue
        }
    }
}
