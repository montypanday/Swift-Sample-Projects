//
//  GridViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit
import AVFoundation

class GridViewController: UIViewController{
    
    // MARK: - Variables
    
    /// Current Game instance.
    var game: Game
    
    /// Stores tags of buttons which can be clicked.
    var clicked: [Int]
    
    /// AudioPlayer to play background music.
    var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    // MARK: - Outlets
    
    /// VolumeControl
    @IBOutlet weak var volumeControl: UISlider!
    
    /// All buttons on the grid.
    @IBOutlet var buttons: [UIButton]!
    
    /// Restart Button
    @IBOutlet weak var restartButton: UIButton!
    
    /// Label which shows which player has won the game.
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var player1Name: UILabel!
    
    @IBOutlet weak var player2Name: UILabel!
    
    @IBOutlet weak var player1Score: UILabel!
    
    @IBOutlet weak var player2Score: UILabel!
    
    @IBOutlet weak var noOfTies: UILabel!
    // MARK: - Actions
    
    /// Change the Volume when the slider is moved.
    ///
    /// - Parameter sender: UISlider to increase/decrease Volume
    @IBAction func volumeChanged(_ sender: UISlider) {
          audioPlayer.volume = sender.value
    }
    
    /// Restart the game.
    ///
    /// - Parameter sender: Restart Button
    @IBAction func restartGame(_ sender: UIButton) {
        self.clicked = [Int]()
        clicked.append(0)
        self.game = Game(player1: game.player1, player2: game.player2, size: 4, autoMode: game.autoMode)
        for button in buttons{
            button.setImage(nil, for: .normal)
        }
        restartButton.isHidden = true
        winnerLabel.text = ""
    }
    @IBAction func handleClick(_ sender: UIButton) {
        if(!clicked.contains(sender.tag) && (!game.finished)){
            playTurn(sender: sender)
            restartButton.isHidden = false
            if(game.autoMode && clicked.count != ((game.gameSize * game.gameSize) + 1 ) && !game.finished){
                var randomButtonTag = 100
                var found = false
                while (!found){
                    randomButtonTag = Int(arc4random_uniform(UInt32(game.gameSize * game.gameSize)))
                    if(!clicked.contains(randomButtonTag)){
                        found = true
                    }
                }
                let randomButton = self.view.viewWithTag(randomButtonTag) as! UIButton
                playTurn(sender: randomButton)
            }
        }
    }
    
    // MARK: - Overriden functions
    required init?(coder aDecoder: NSCoder) {
        // initialize a template game.
        self.game = Game(player1: Player(name: "player1",image: "cross"), player2: Player(name: "player2",image: "zero"), size: 4, autoMode: false)
        self.clicked = [Int]()
        clicked.append(0)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        volumeControl.minimumValueImage = #imageLiteral(resourceName: "noVolume")
        volumeControl.maximumValueImage = #imageLiteral(resourceName: "fullVolume")
        player1Name.text = game.player1.name
        player2Name.text = game.player2.name
        var player1WonGames = 0
        var player2WonGames = 0
        if let archivedGames = loadGames(){
            for gameRecord in archivedGames{
                if(gameRecord.player1.lowercased() == game.player1.name.lowercased() && gameRecord.player2.lowercased() == game.player2.name.lowercased()){
                    if gameRecord.winner.lowercased() == game.player1.name.lowercased(){
                        player1WonGames += 1
                    }
                    if gameRecord.winner.lowercased() == game.player2.name.lowercased(){
                        player2WonGames += 1
                    }
                }
            }
        }
        player1Score.text = "\(player1WonGames)"
        player2Score.text = "\(player2WonGames)"
        noOfTies.text = "VS"
    }
    
    
    /// After the view appears on screen. Called after ViewDidLoad.
    ///
    /// - Parameter animated: should the view be animated.
    override func viewWillAppear(_ animated: Bool) {
        volumeControl.value = audioPlayer.volume
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private functions
    
    /// simulate a turn based on the currentPlayer.
    ///
    /// - Parameter sender: tag of the button which was clicked.
    private func playTurn(sender: UIButton){
        clicked.append(sender.tag)
        setImageAndCurrentPlayer(sender: sender)
        game.update(tag: sender.tag)
        checkIfWin()
    }
    
    /// Display the label if any user won the game.
    private func checkIfWin(){
        if(game.checkIfWin()){
            winnerLabel.text = "\(game.winner.name) has won!"
            if game.winner.name == player1Name.text{
                let newScore = Int(player1Score.text!)! + 1
                player1Score.text = "\(newScore)"
            }
            if game.winner.name == player2Name.text{
                let newSecondScore = Int(player2Score.text!)! + 1
                player2Score.text = "\(newSecondScore)"
            }
        }
    }
    
    /// Set the appropriate image on the button and toggle the current user.
    ///
    /// - Parameter sender: Tag of the button which was clicked
    private func setImageAndCurrentPlayer(sender: UIButton){
        switch game.currentPlayer.name {
        case game.player1.name:
            sender.setImage(UIImage(named: game.player1.icon), for: .normal)
            game.currentPlayer = game.player2
            break
        case game.player2.name:
            sender.setImage(UIImage(named: game.player2.icon), for: .normal)
            game.currentPlayer = game.player1
            break
        default: break
        }
    }
    
    /// Load archived Games
    ///
    /// - Returns: Array of unarchived GameRecord's
    private func loadGames() -> [GameRecord]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GameRecord.ArchiveURL.path) as? [GameRecord]
    }
}
