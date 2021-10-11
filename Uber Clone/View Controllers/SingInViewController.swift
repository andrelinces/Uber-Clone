//
//  SingInViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 05/10/21.
//

import UIKit
import FirebaseAuth

class SingInViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var passaword: UITextField!
    
    @IBAction func buttonSingin(_ sender: Any) {
        
        let buttonReturn = self.validateFields()
        if buttonReturn == " "{
            
            //authenticate the user (Login)
            let authentication = Auth.auth()
            
            if let emailRecovered = self.email.text {
                
                if let passawordRecovered = self.passaword.text {
                    
                    authentication.signIn(withEmail: emailRecovered, password: passawordRecovered) { (user, error) in
                        
                        if error == nil {
                            
                            if user != nil {
                                //Print to display test login
                                //print("user successful authentication!")
                                
                                //passing the user to the main view
                                //self.performSegue(withIdentifier: "segueLogin", sender: nil)
                            }
                            
                        }else{
                            
                            print("Error login user!")
                        }
                        
                    }
                }
            }
            
            
        }else{
            
            print("The field \(buttonReturn) was not filled in !")
        }
        
    }
    
    //Method for validate user-entered fields
    func validateFields() -> String {
        
        if (self.email.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (self.passaword.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
       return " "
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
