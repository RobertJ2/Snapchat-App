//
//  SelectRecipientTableViewController.swift
//  Snapchat
//
//  Created by Robert Jackson Jr on 6/18/18.
//  Copyright © 2018 Robert Jackson Jr. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectRecipientTableViewController: UITableViewController {
    
    var downloadURL = ""
    var snapDescription = ""
    var users : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            let user = User()
            if let userDictionary = snapshot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    user.email = email
                    user.uid = snapshot.key
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }

    

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        if let fromEmail = Auth.auth().currentUser?.email {
        
            let snap = ["from":fromEmail, "description":snapDescription, "imageURL":downloadURL]
            
            Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
            
            navigationController?.popToRootViewController(animated: true)
    }
    }

}

class User {
    var email = ""
    var uid = ""
}
