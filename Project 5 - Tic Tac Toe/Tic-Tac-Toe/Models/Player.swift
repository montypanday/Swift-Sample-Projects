//
//  Player.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import Foundation

class Player {
    
    // MARK: variables
    
    /// Name of the Player
    var name: String
    
    /// Name of the image to be used for this player (cross/zero)
    var icon: String
    
    // MARK: Public functions
    
    /// Initialize a new Player
    ///
    /// - Parameters:
    ///   - name: Name of the Player
    ///   - image: Icon Image
    init(name:String, image: String) {
        self.name = name
        self.icon = image
    }

    
    /// Switch the icon for the current user
    func toggleIcon(){
        if icon == "cross"{
            icon = "zero"
        }else if icon == "zero"{
           icon = "cross"
        }
    }
}
