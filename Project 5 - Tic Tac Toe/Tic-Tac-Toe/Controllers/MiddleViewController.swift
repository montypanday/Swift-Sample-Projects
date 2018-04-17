//
//  MiddleViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 2/4/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit
import AVFoundation

class MiddleViewController: UIViewController {
    
    // MARK: - Variables
    var isAutoMode = false;
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var player1 = Player(name: "Player1", image: "cross")
    var player2 = Player(name: "Player2", image: "zero")
    
    // MARK: - Outlets
    @IBOutlet weak var player1NameField: UITextField!
    @IBOutlet weak var player2NameField: UITextField!
    @IBOutlet weak var volumeControl: UISlider!
    @IBOutlet weak var player1Icon: UIButton!
    @IBOutlet weak var player2Icon: UIButton!
    
    // MARK: - Actions
    @IBAction func player1NameChanged(_ sender: UITextField) {
        player1.name = sender.text!
    }
    @IBAction func player2NameChanged(_ sender: UITextField) {
        player2.name = sender.text!
    }
    @IBAction func iconSelected(_ sender: UIButton) {
        toggleIconsForBothPlayers()
    }
    @IBAction func volumeChanged(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    // MARK: - Overridden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayer2NameIfAutoMode()
        setVolumeSliderImages()
        player1Icon.setBackgroundImage(#imageLiteral(resourceName: "smallCross"), for: .normal)
        player2Icon.setBackgroundImage(#imageLiteral(resourceName: "smallZero"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        volumeControl.value = audioPlayer.volume
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "start"){
            if let destination = segue.destination as? GridViewController{
                destination.audioPlayer = audioPlayer
                destination.game = Game(player1: player1, player2: player2, size: 4, autoMode: isAutoMode)
            }
        }
    }
    
    // MARK: - Private Functions
    private func toggleIconsForBothPlayers(){
        player1.toggleIcon()
        player2.toggleIcon()
        player1Icon.setBackgroundImage(giveSmallIcon(icon: player1.icon), for: .normal)
        player2Icon.setBackgroundImage(giveSmallIcon(icon: player2.icon), for: .normal)
    }
    
    private func setVolumeSliderImages(){
        volumeControl.minimumValueImage = #imageLiteral(resourceName: "noVolume")
        volumeControl.maximumValueImage = #imageLiteral(resourceName: "fullVolume")
    }
    
    private func setPlayer2NameIfAutoMode(){
        if(isAutoMode){
            let AI = "AI"
            player2.name = AI
            player2NameField.text = AI
            player2NameField.isUserInteractionEnabled = false
        }
    }
    
    private func giveSmallIcon(icon: String)->UIImage{
        // need small icons for size purpose.
        switch icon {
        case "zero":
            return #imageLiteral(resourceName: "smallZero")
        case "cross":
            return #imageLiteral(resourceName: "smallCross")
        default:
            return UIImage()
        }
    }
}
