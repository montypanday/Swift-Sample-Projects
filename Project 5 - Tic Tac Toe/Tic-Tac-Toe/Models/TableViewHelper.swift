//
//  TableViewHelper.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 5/4/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    
    class func EmptyMessage(message: String, viewController: HistoryTableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }
}
