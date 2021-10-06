//
//  CadastroViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 04/10/21.
//

import UIKit

class CadastroViewController: UIViewController {
    
    
    @IBOutlet weak var registerEmail: UITextField!
    
    @IBOutlet weak var registerFullName: UITextField!
    
    @IBOutlet weak var registerPassaword: UITextField!
    
    @IBOutlet weak var registerConfirmPassaword: UITextField!
    
    @IBOutlet weak var userType: UISwitch!
    
    @IBAction func registerUserButton(_ sender: Any) {
        
        let validadeReturn = self.validateFields()
        
        if validadeReturn == " " {
        
    }else {
            //print to show if the user left any field empety!      
            print("The field \(validadeReturn) was not filled in ! ")
    
        }
    
    }
    
    //Method for validate user-entered fields
    func validateFields() -> String {
        
        if (self.registerEmail.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (self.registerFullName.text?.isEmpty)! {
            
            return "Full name"
            
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
