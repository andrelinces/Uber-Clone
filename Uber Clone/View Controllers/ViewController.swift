//
//  ViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 03/10/21.
//

import UIKit
import FirebaseAuth

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
                
                //passing user to main view.
                self.performSegue(withIdentifier: "segueLoginMain", sender: nil)
                
            }
            
        }
        
        
        
    }
    //Hiding navigation bar
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

}

