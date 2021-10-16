//
//  DriverTableViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 11/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DriverTableViewController: UITableViewController {
    
    var requisitionList : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure database
        
        let database = Database.database().reference()
        let requests = database.child("requests")
        
        //Recovering of the request list
        requests.observe(.childAdded) { (snapshot) in
            
            self.requisitionList.append( snapshot )
            self.tableView.reloadData()
            
        }
        
    }
    
    @IBAction func logoutDriver(_ sender: Any) {
        
        let authentication = Auth.auth()
        
        do {
            try authentication.signOut()
            print("Successful logout user !")
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Error logout user!!")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requisitionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseDriver", for: indexPath)
        
        //recovering the requests
        let snapshot = self.requisitionList[ indexPath.row ]
        if let data = snapshot.value as? [String: Any] {
            
            //Configure the cell
            cell.textLabel?.text = data["e-mail"] as? String
        }
        
        return cell
    }
    
}
