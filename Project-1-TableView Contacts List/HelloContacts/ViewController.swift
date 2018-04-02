//
//  ViewController.swift
//  HelloContacts
//
//  Created by Monty Panday on 14/3/18.
//  Copyright © 2018 Monty Panday. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UITableViewDelegate {
    
    var contacts = [CNContact]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        if authorizationStatus == .notDetermined{
            store.requestAccess(for: .contacts, completionHandler: {[weak self] authorized, error in
                if authorized{
                    self?.retrieveContacts(fromStore: store)
                }
            })
        }
        retrieveContacts(fromStore: store)
    }
    
    func retrieveContacts(fromStore store: CNContactStore){
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                           CNContactFamilyNameKey as CNKeyDescriptor,
                           CNContactImageDataKey as CNKeyDescriptor,
                           CNContactImageDataAvailableKey as CNKeyDescriptor]
        
        contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
        DispatchQueue.main.async{
            [weak self] in self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        if
            let imageData = contact.imageData, contact.imageDataAvailable {
            cell.contactImage.image = UIImage(data: imageData)
        }else{
            cell.contactImage.image = #imageLiteral(resourceName: "contact")
            cell.contactImage.clipsToBounds = true
        }
        return cell
    }
}

