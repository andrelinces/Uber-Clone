//
//  DriverViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit
import FirebaseAuth

class DriverViewController: UIViewController, DriverModelCellCallBack {
    
    func acaoCliqueCard(indexPath: IndexPath) {
        print("clicou no card")
    }
    
    @IBOutlet weak var tableView: UITableView!
    //Instanting with the driver dataSource
    let dataSource = DriverDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    @IBAction func logoutDriver (_ sender: Any) {
        
        let authentication = Auth.auth()
        
        do {
            try authentication.signOut()
            print("Sucessful logout user !")
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Error logout user!!")
        }
    }
//    do {
//        try authentication.signOut()
//        print("Successful logout user !")
//        dismiss(animated: true, completion: nil)
//    } catch  {
//        print("Error logout user!!")
//    }

    
    func setupTableView (){
        
        let driverModellCard1 = DriverModel(delegate: self, tituloCard: "Request 1", distanceDriver: "2km", imageDriver: "menu_cliente")
        let driverModellCard2 = DriverModel(delegate: self, tituloCard: "Request 2", distanceDriver: "2km", imageDriver: "menu_cliente")
        
        dataSource.data.append(driverModellCard1)
        dataSource.data.append(driverModellCard2)
        
        tableView.allowsSelection = false
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //show tableView
        dataSource.initializeTableView(tableView: tableView)
        
    }
    
}
