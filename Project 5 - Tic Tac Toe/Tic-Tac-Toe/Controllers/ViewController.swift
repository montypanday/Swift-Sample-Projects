//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by MONTY PANDAY on 13/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Variables
    var audioPlayer = AVAudioPlayer()
    
    // MARK: - Outlets
    @IBOutlet weak var volumeControl: UISlider!
    
    
    // MARK: - Actions
    @IBAction func volumeChanged(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    // MARK: - Overridden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundMusic()
        setVolumeSliderImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        volumeControl.value = audioPlayer.volume
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? MiddleViewController{
            destination.audioPlayer = audioPlayer
            if(segue.identifier == "single"){
                destination.isAutoMode = true
            }
        }
    }
    
    // MARK: - Private functions
    private func setVolumeSliderImages(){
        volumeControl.minimumValueImage = #imageLiteral(resourceName: "noVolume")
        volumeControl.maximumValueImage = #imageLiteral(resourceName: "fullVolume")
    }
    
    /// Player background Music from mp3 file.
    private func playBackgroundMusic(){
        do{
            let path = Bundle.main.path(forResource: "background", ofType: "mp3")
            let url = URL(fileURLWithPath: path!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            // Play music undefinitely.
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print("Got error")
            print(error)
        }
    }
}

