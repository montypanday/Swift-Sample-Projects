//
//  ViewController.swift
//  Music Player
//
//  Created by Monty Panday on 2/4/18.
//  Copyright © 2018 Monty Panday. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singerImg: UIImageView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var filterBySinger = "All"
    var musicPlayer: MusicPlayer = MusicPlayer(PlayList())
    var isPlaying: Bool = false
    var playOrResume : Bool = false
    var timer : Timer!
    

    @IBAction func changeVolume(_ sender: UISlider) {
        musicPlayer.changeVolume(newValue: sender.value)
    }
    
    @IBAction func previous(_ sender: UIBarButtonItem) {
        musicPlayer.previous(filterBy: filterBySinger)
        updateUI()
    }
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
      musicPlayer.stop()
        playOrResume = false
        updateUI()
    }
    
    @IBAction func play(_ sender: UIBarButtonItem) {
        if playOrResume == true {
            musicPlayer.resume()
        } else{
            musicPlayer.play(filterBy: filterBySinger)
        }
        updateUI()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRealtimeUI), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: UIBarButtonItem) {
        musicPlayer.pause()
        playOrResume = true
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        musicPlayer.next(filterBy: filterBySinger)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        let currentSong = musicPlayer.currentSong
        singerImg.image = #imageLiteral(resourceName: "song")
        nowPlayingLabel.text = currentSong.title
    }
    
    @objc func updateRealtimeUI(){
        let currentSong = musicPlayer.getCurrentSong()
        let progress = Float(currentSong.timeElapsed / currentSong.duration)
        songProgress.setProgress(progress, animated: true)
        let elaspedTime = Int(currentSong.timeElapsed.nextUp)
        let remainingTime = Int(currentSong.duration.nextUp) - elaspedTime
        elapsedTimeLabel.text = "\(elaspedTime)"
        remainingTimeLabel.text = "\(remainingTime)"
    }


}

