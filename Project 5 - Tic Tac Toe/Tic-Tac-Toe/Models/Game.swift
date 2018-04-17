//
//  Game.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import Foundation
import os.log

class Game {
    
    // MARK: - Variables
    
    /// first player
    var player1: Player
    
    /// second player
    var player2: Player
    
    /// Winner of the game.
    var winner: Player
    
    /// size of grid, no. of buttons = gameSize * gameSize
    var gameSize: Int
    
    /// player now playing.
    var currentPlayer: Player
    
    /// Array required for calculating the current state of the game, modified with each turn.
    var grid = [[Int]]()
    
    /// should the game run in single/multi player mode.
    var autoMode: Bool
    
    /// To keep track of which buttons have been pressed.
    var link = [Int:(x: Int, y: Int )]()
    
    /// is the game finished.
    var finished = false
    
    // MARK: Constants
    // select two number to put in array that will help determine win condition
    // please note that one number must be bigger than the other to avoid wrong wins.
    
    /// Placeholder digit for first user.
    let digit1 = 10
    
    /// Placeholder digit for second user.
    let digit2 = 100
    
    // MARK: - Functions
    
    
    /// Initialise a new game.
    ///
    /// - Parameters:
    ///   - player1: first player
    ///   - player2: second player
    ///   - size: size of grid, e.g 4 in this case
    ///   - autoMode: two players or single player
    init(player1: Player, player2: Player, size: Int, autoMode: Bool) {
        self.player1 = player1
        self.player2 = player2
        self.gameSize = size
        self.currentPlayer = player1
        self.autoMode = autoMode
        self.grid = Array(repeating: Array(repeating: 0, count: size), count: size)
        self.winner = Player(name: "",image:"")
        let totalNoOfElements = size * size
        let tempArray = [Int](1...totalNoOfElements)
        var a = 1, b = 1
        for button in tempArray{
            link[button] = (x: a, y: b)
            if(b == size){
                b = 1
                a += 1
                continue
            }
            b += 1
        }
    }
    
    
    /// Updates the two dimensional array according to the button clicked.
    ///
    /// - Parameter tag: button tag
    func update(tag: Int){
        if let position = link[tag]{
            if(currentPlayer.name == player2.name){
                grid[position.x - 1][position.y - 1] = digit1
            }else{
                grid[position.x - 1][position.y - 1] = digit2
            }
        }
    }
    
    
    /// Check if the current user has won the game.
    ///
    /// - Returns: true or false
    func checkIfWin()-> Bool{
        checkRows()
        checkColumns()
        checkDiagonals()
        if(finished){
            return true
        }
        return false
    }
    
    // MARK: - Private Functions
    
    
    /// Check all the rows to see if the user won the game.
    private func checkRows(){
        for x in 1...gameSize{
            var tempScore = 0
            for y in 1...gameSize{
                tempScore += grid[x - 1][y - 1]
            }
            checkWin(score: tempScore)
        }
    }
    
    
    /// Save the current game, reads the archived games and add one more.
    private func saveGame(){
        var games = [GameRecord]()
        if let oldgames = NSKeyedUnarchiver.unarchiveObject(withFile: GameRecord.ArchiveURL.path) as? [GameRecord]{
            games += oldgames
        }
        print("Number of Stored games: ",games.count)
        games.append(GameRecord(player1Name: player1.name, player2Name: player2.name, winnerName: winner.name))
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(games, toFile: GameRecord.ArchiveURL.path)
        if isSuccessfulSave{
            print("Game saved successfully")
        }
        else{
            print("Save Failed")
        }
    }
    
    
    /// Helps checkIfWin by finding out which player won the game.
    ///
    /// - Parameter score: sum of a integers in a row/column/diagonal.
    private func checkWin(score: Int){
        switch score {
        case (digit1 * gameSize):
            finished = true
            winner = player1
            saveGame()
            print("Player 1 won the game")
            break
        case (digit2 * gameSize):
            finished = true
            winner = player2
            saveGame()
            print("Player 2 won the game")
            break
        default: break
        }
 
    }
    
    
    /// Loop on all columns to find a user won the game.
    private func checkColumns(){
        for y in 1...gameSize{
            var tempScore = 0
            for x in 1...gameSize{
                tempScore += grid[x - 1][y - 1]
            }
            checkWin(score: tempScore)
        }
    }
    
    
    /// Loop on all diagonals to find a user won the game.
    private func checkDiagonals(){
        checkDiagonalLeftToRight()
        checkDiagonalRightToLeft()
    }
    
    
    /// Check the diagonal from left to right.
    private func checkDiagonalLeftToRight(){
        // Check diagonal left to right
        var x = 1, y = 1
        var tempScore = 0
        repeat{
            tempScore += grid[x - 1][y - 1]
            x += 1
            y += 1
        } while x <= gameSize
        checkWin(score: tempScore)
    }
    
    
    /// Check the diagonal from right to left.
    private func checkDiagonalRightToLeft(){
        // Check diagonal left to right
        var x = 1, y = gameSize
        var tempScore = 0
        repeat{
            tempScore += grid[x - 1][y - 1]
            x += 1
            y -= 1
        } while x <= gameSize
        checkWin(score: tempScore)
    }
}
