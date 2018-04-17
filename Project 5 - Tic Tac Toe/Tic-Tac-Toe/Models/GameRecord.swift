//
//  GameRecord.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 4/4/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import Foundation


/// GameRecord class is a subset of Game which includes the data i want to archive.
class GameRecord : NSObject, NSCoding{
    
    /// you have to use fixed strings for encoding and decoding, it is better to use a struct to avoid future errors.
    struct PropertyKey{
        static let player1 = "player1"
        static let player2 = "player2"
        static let winner = "winner"
    }
    
    // MARK: - Properties
    
    /// Player 1
    var player1: String
    
    /// Player 2
    var player2: String
    
    /// Winner of the game.
    var winner: String
    
    // MARK: - Archiving Paths
    
    /// Path of the directory where archived data is stored.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    /// URL to the archiving folder.
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("games")
    
    
    /// Encode the current GameRecord
    ///
    /// - Parameter aCoder: NSCoder used for encoding.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(player1,forKey: PropertyKey.player1)
        aCoder.encode(player2,forKey: PropertyKey.player2)
        aCoder.encode(winner,forKey: PropertyKey.winner)
    }
    
    
    /// Initialise a GameRecord.
    ///
    /// - Parameters:
    ///   - player1Name: Name of First Player
    ///   - player2Name: Name of Second Player
    ///   - winnerName: Name of Winner
    init(player1Name: String, player2Name: String, winnerName: String) {
        self.player1 = player1Name
        self.player2 = player2Name
        self.winner = winnerName
        super.init()
    }
    
    
    /// Decode and initialize archived objects.
    ///
    /// - Parameter aDecoder: NSCoder used for decoding
    required convenience init?(coder aDecoder: NSCoder) {
        let player1Value = aDecoder.decodeObject(forKey: PropertyKey.player1) as? String
        let player2Value = aDecoder.decodeObject(forKey: PropertyKey.player2) as? String
        let winnerValue = aDecoder.decodeObject(forKey: PropertyKey.winner) as? String
        self.init(player1Name: player1Value!, player2Name: player2Value!, winnerName: winnerValue!)
        
    }
}
