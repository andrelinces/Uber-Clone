//
//  DriverDataSource.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit

class DriverDataSource: NSObject {
    
    var data = [Any]()
    
    func initializeTableView ( tableView: UITableView ) {
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "DriverModelCell", bundle: Bundle.main), forCellReuseIdentifier: "DriverModelCellIdentifier")
        
    }
}
    extension DriverDataSource: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if let driverModel = data[ indexPath.row ] as? DriverModel {
                
                return driverModel.cellForTableView(tableView: tableView, atIndexPath: indexPath)
                
                
            }else{
                
                return UITableViewCell()
            }
            
        }
        
    }
    

