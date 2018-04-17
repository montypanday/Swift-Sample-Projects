//
//  NewGridViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 22/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class NewGridViewController: UIViewController {
    
    var counter = 0
    
    var clicked: [Int]
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var restartButton: UIBarButtonItem!
    
    @IBAction func restartGame(_ sender: UIBarButtonItem) {
        self.clicked = [Int]()
        clicked.append(0)
        counter = 0
        self.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: game.autoMode)
        for tag in 1...(game.gameSize * game.gameSize){
            let tmpButton = self.view.viewWithTag(tag) as? UIButton
            tmpButton?.setImage(nil, for: .normal)
        }
 
        winnerLabel.text = ""
    }
    
    var game: Game
    
        var collectionViewDataSource: [Int] = []
    
    required init?(coder aDecoder: NSCoder) {
        self.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: false)
        self.clicked = [Int]()
        clicked.append(0)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

extension NewGridViewController: UICollectionViewDelegate{
    /**
     Allows you to control whether a cell is added to the list of selected
     cells. So, if a user selected a cell, you can tell the collection view
     to "remember" that this cell was tapped/selected by the user (or not).
     */
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Allows you to control whether a cell is removed from the list of selected
     cells. So, if a user selected a cell, you can tell the collection view
     to "forget" that this cell was tapped/selected by the user (or not).
     */
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Allow the cell to be visually highlighted when selected/tapped (or not).
     */
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Useful for confirming which cell was just selected/tapped.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell{
                if(!clicked.contains(cell.tag) && (!game.finished)){
                playTurn(cell: cell)
                if(game.autoMode && clicked.count != ((game.gameSize * game.gameSize) + 1 )){
                    var randomButtonTag = 100
                    var found = false
                    while (!found){
                        randomButtonTag = Int(arc4random_uniform(UInt32(game.gameSize * game.gameSize)))
                        if(!clicked.contains(randomButtonTag)){
                            found = true
                        }
                    }
                    if let coordinates = game.link[randomButtonTag]{
                        if let randomCell = collectionView.cellForItem(at: [coordinates.x,coordinates.y]) as? GameCollectionViewCell{
                            playTurn(cell: randomCell)
                        }
                    }
                }
            }
        }
    }
    
    func playTurn(cell: GameCollectionViewCell){
        clicked.append(cell.tag)
        setImageAndCurrentPlayer(cell: cell)
        game.update(tag: cell.tag)
        checkIfWin()
    }
    
    func checkIfWin(){
        if(game.checkIfWin()){
            winnerLabel.text = "\(game.winner.name) has won!"
        }
    }
    
    func setImageAndCurrentPlayer(cell: GameCollectionViewCell){
        switch game.currentPlayer {
        case 0:
    
            cell.imageView.image = UIImage(named: "zero")
            cell.imageView.layer.masksToBounds = true
            cell.imageView.isOpaque = true
            cell.imageView.frame = cell.frame
            game.currentPlayer = 1
            break
        case 1:
            cell.imageView.image = UIImage(named: "cross")
            cell.imageView.layer.masksToBounds = true
            cell.imageView.isOpaque = true
            cell.imageView.frame = cell.frame
            game.currentPlayer = 0
            break
        default: break
        }
    }
    
}

extension NewGridViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return game.gameSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return game.gameSize;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let collectionViewCell:GameCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell
        collectionViewCell.backgroundColor = UIColor.white
        print("Cell Size: ",collectionViewCell.frame.size)
      
      collectionViewCell.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: collectionViewCell.frame.width, height: collectionViewCell.frame.height))
//        collectionViewCell.imageView.image = UIImage()
//        collectionViewCell.imageView.frame = collectionViewCell.frame
//        
//        
        //collectionViewCell.imageView.frame.size = collectionViewCell.frame.size
       // collectionViewCell.imageView.image = UIImage(named: "zero")
       
        
      
        counter += 1
        collectionViewCell.tag = counter
        let image = UIImage(named: "zero")
        collectionViewCell.imageView.image = image
        collectionViewCell.imageView.contentMode = UIViewContentMode.scaleAspectFit
        print("ImageView Size: ",collectionViewCell.imageView.frame.size)
        print("Image : ",collectionViewCell.imageView.image.debugDescription)
        //collectionViewCell.addSubview(imageView)
        return collectionViewCell
    }
}

extension NewGridViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width/8
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.bounds.width
        let size = width/8
        let numberOfCells = (CGFloat)(game.gameSize)
        let edgeInset = (width - (numberOfCells * size))/2 - 20
        if(section == 0){
            return UIEdgeInsets(top: 50, left: edgeInset, bottom: 5, right: edgeInset)
        }
        return UIEdgeInsets(top: 10, left: edgeInset, bottom: 5, right: edgeInset)
    }
}
