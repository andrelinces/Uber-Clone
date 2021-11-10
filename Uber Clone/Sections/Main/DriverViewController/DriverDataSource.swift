//
//  DriverDataSource.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DriverDataSource: NSObject {
    
    
    var data = [Any]()
    
    func initializeTableView ( tableView: UITableView ) {
        
        tableView.dataSource = self
        //Register tableview, model cell DriverModelCell
        tableView.register(UINib(nibName: "DriverModelCell", bundle: Bundle.main), forCellReuseIdentifier: "DriverModelCellIdentifier")
        
    }
     
}

    extension DriverDataSource: UITableViewDataSource {
     
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
            //Recorver model dataSource
            return data.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Mounting the is model cell.
            if let driverModel = data[ indexPath.row ] as? DriverModel {
                
                return driverModel.cellForTableView(tableView: tableView, atIndexPath: indexPath)
                
                
            }else{
                
                return UITableViewCell()
            }
            
        }
        
    }
    

