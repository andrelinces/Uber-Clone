//
//  RegisterViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 05/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerEmail: UITextField!
    
    @IBOutlet weak var registerFullName: UITextField!
    
    @IBOutlet weak var registerPassaword: UITextField!
    
    @IBOutlet weak var registerConfirmPassaword: UITextField!
    
    @IBOutlet weak var userType: UISwitch!
    
    @IBOutlet weak var passengerLabel: UILabel!
   
    @IBOutlet weak var driverLabel: UILabel!
    
    
    @IBAction func typeSwitch(_ sender: Any) {
        //change label color as user selects switch
        if self.userType.isOn {
            self.driverLabel.textColor = UIColor.white
            self.passengerLabel.textColor = UIColor.black
                        //self.passengerLabel.textColor = UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)
        }else {
            self.passengerLabel.textColor = UIColor.white
            self.driverLabel.textColor = UIColor.black
        }
        reloadInputViews()
    }
    
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
                                //print to test on success when creating the user.
                                //print("successful creating user account ! ")
                                
                                //Valid if the user is logged in!
                                if user != nil {
                                    //self.performSegue(withIdentifier: "segueLoginRegister", sender: nil)
                                    
                                    //configure database
                                    let database = Database.database().reference()
                                    
                                    let users = database.child("users")
                                    
                                    //checks the user type
                                    var type = ""
                                    if self.userType.isOn {//On passenger
                                        //UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)
                                        type = "passenger"
                                        
                                        
                                    }else{//off driver
                                        
                                        type = "driver"
                                        self.passengerLabel.text = " "
                                    }
                                    
                                    
                                    //Saves the user's data to the database
                                    let userdata = [
                                    
                                        "email" : emailRecovered ,
                                        "name" : fullNameRecovered,
                                        "usertype" : type
                                    ]
                                    
                                    //saves user data in firebase
                                    users.child( (user?.user.uid)! ).setValue(userdata)
                                    
                                    //validates if user is logged, if it is, it will be redirected by the view controller.
                                    
                                }else{
                                    print("Error authenticating user !!")
                                }
                                
                                
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
        /*
        if self.userType.isOn {
            self.passengerLabel.textColor = UIColor.white
            //self.passengerLabel.textColor = UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)
        }else{
            self.passengerLabel.textColor = UIColor.white
        }
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
