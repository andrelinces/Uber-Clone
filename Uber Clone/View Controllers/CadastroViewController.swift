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
    
    @IBOutlet weak var registerUserButton: UIButton!
    
    
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
