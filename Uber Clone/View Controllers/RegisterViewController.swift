//
//  RegisterViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 05/10/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerEmail: UITextField!
    
    @IBOutlet weak var registerFullName: UITextField!
    
    @IBOutlet weak var registerPassaword: UITextField!
    
    @IBOutlet weak var registerConfirmPassaword: UITextField!
    
    @IBOutlet weak var userType: UISwitch!
    
    @IBAction func registerButton(_ sender: Any) {
        
        let validateReturn = validateFields()
        
        if validateReturn == " " {
            
            //Register user in firebase, creating references
            let authentication = Auth.auth()
            
            if let emailRecovered = self.registerEmail.text {
                
                if let fullNameRecovered = self.registerFullName.text {
                    
                    if let passawordRecovered = self.registerPassaword.text {
                        
                        authentication.createUser(withEmail: emailRecovered, password: passawordRecovered) { (user, error) in
                            
                            if error == nil {
                                
                                print("successful creating user account ! ")
                                
                            }else{
                                
                                print("Error creating user, try again ! ")
                            }
                            
                        }
                    }
                }
                
            }//end of test if authentication
            
            
            
            
        }else{
            //print to show if the user left any field empety!
            print("The field \(validateReturn) was not filled in !!")
            
        }
        
    }
    //Method for validate user-entered fields
    func validateFields() -> String {
        
        if (self.registerEmail.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (self.registerFullName.text?.isEmpty)! {
            
            return "Full Name"
        }else if (self.registerPassaword.text?.isEmpty)! {
            
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
