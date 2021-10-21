//
//  ViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 03/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retriveing the objetc
        let authentication = Auth.auth()
        
        //singOut user
        /*
        do {
            try try authentication.signOut()
        } catch  {
            print("Error singOut user!!")
        }
        */
        authentication.addStateDidChangeListener { authentication, user in
            //If the logged in user has a value, there is a logged in user.
            if let userLogged = user {
                
                //passing user to main view if he is logged in.
                //self.performSegue(withIdentifier: "segueLoginMain", sender: nil)
                
                //creating object to identifier user type, and passing user para the correct view
                let database = Database.database().reference()
                
                let user = database.child("users").child( userLogged.uid )
                
                user.observeSingleEvent(of: .value) { (snapshot) in
                    
                    let data = snapshot.value as? NSDictionary
                    
                    let userType = data!["usertype"] as! String
                    
                    if userType == "passenger" {
                        
                        //passing user to passenger view if he is logged in.
                        self.performSegue(withIdentifier: "segueLoginMain", sender: nil)
                        
                    }else{
                        
                        //passing user to driver view if he is logged in.
                         self.performSegue(withIdentifier: "DriverModelCellIdentifier", sender: nil)
                        
                    }
                    
                }
            }
            
        }
           
    }
    
    //Hiding navigation bar
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    

}

