//
//  GameCollectionViewCell.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 22/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView = UIImageView()
        imageView.image = UIImage()
        print("Preparing Cell for reuse")
    }
}
