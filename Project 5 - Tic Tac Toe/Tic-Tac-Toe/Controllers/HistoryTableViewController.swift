//
//  HistoryTableTableViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 3/4/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    // MARK: - Variables
    var games = [GameRecord]()
    
    // MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedGames = loadGames(){
            games += storedGames
        }
        // TODO: Add a edit button to allow deleting archived games.
//        if games.count > 0{
//              self.navigationItem.rightBarButtonItem = self.editButtonItem
//        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if games.count > 0{
             return 1
        }else{
            TableViewHelper.EmptyMessage(message: "No History", viewController: self)
            return 0
        }
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> HistoryTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        // Configure the cell...
        let game = games.popLast()
        cell.player1Name.text = game?.player1
        cell.player2Name.text = game?.player2
        if(game?.player1 == game?.winner){
            cell.player1Name.textColor = UIColor.green
            cell.player2Name.textColor = UIColor.red
        }
        if(game?.player2 == game?.winner){
            cell.player2Name.textColor = UIColor.green
            cell.player1Name.textColor = UIColor.red
        }
        return cell
    }
    
    // TODO: Implement the deleting history.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
//    }
    
    // MARK: - Private Functions
    
    /// Load archived Games
    ///
    /// - Returns: Array of unarchived GameRecord's
    private func loadGames() -> [GameRecord]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GameRecord.ArchiveURL.path) as? [GameRecord]
    }

}
