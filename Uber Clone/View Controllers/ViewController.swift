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
        
        //Aguarda um determinado tempo para chamar uma função de forma assincrona
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        // create the alert
//                let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
//
//                // add an action (button)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                // show the alert
//                self.present(alert, animated: true, completion: nil)
//
//            print("Recebeu o tempo do alerta!!!")
//        }
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
                    
                    //testing data to avoid user deleted error
                    if data != nil {
                        
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
           
    }
    
    //Hiding navigation bar
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    

}

