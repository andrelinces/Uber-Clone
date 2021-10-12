//
//  DriverTableViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 11/10/21.
//

import UIKit
import FirebaseAuth

class DriverTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseDriver", for: indexPath)
        
        //Configure the cell
        cell.textLabel?.text = "test"
        
        
        return cell
    }
    
}
