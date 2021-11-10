//
//  DriverViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit


class DriverViewController: UIViewController, DriverModelCellCallBack {
    
    func acaoCliqueCard(indexPath: IndexPath) {
        print("clicou no card")
    }
    
    @IBOutlet weak var tableView: UITableView!
    //Instanting with the driver dataSource
    let dataSource = DriverDataSource()
    
    var passenger = [Passenger]()
    
    //instantiating object CllocationManager
    var locationManager = CLLocationManager()
    
    //instantiating the objet to the user's coordinates
    var driverlocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       recoveredData()
       setupTableView()
           
    }
    
    //testing data recover of the firebase
    var requisitionList = [DataSnapshot]()
    
    //let database = Database.database().reference()
    
//    func recoveredData () {
//        //Creted database Reference
//        let requests = Database.database().reference().child("requests")
//
//        //Recovering of the request list
//        requests.observe(.childAdded) { (snapshot) in
//            self.requisitionList.append(snapshot)
//            var email : String = ""
//            var latitude : CLLocationDegrees = 0
//            var longitude : CLLocationDegrees = 0
//            var nome : String = ""
//
//            print("requisitions : \(self.requisitionList.count)")
//
//            for indexPassenger in 0..<self.requisitionList.count {
//                print("indexPassenger... \(indexPassenger)")
//
//
//                //recovering the requests
//                let snapshot = self.requisitionList[ indexPassenger ]
//                if let data = snapshot.value as? [String: Any] {
//
//                    //Configure the cell
//                    email = data["e-mail"] as? String ?? ""
//                    latitude = data["latitude"] as? CLLocationDegrees ?? 0
//                    longitude = data["longitude"] as? CLLocationDegrees ?? 0
//                    nome = data["nome"] as? String ?? ""
//
//                    print("e-mail: \(email) \n"  +  "nome: \(nome) \n" + "latitude: \(latitude) \n" + "longitude: \(longitude)" )
//
//                    DispatchQueue.main.async() {
//                        print("email antes do append... \(email)")
//                        //self.recoveredData()
//                        self.passenger.append(Passenger(email: email, longitude: longitude, latitude: latitude, nome: nome))
//                        if self.requisitionList.count == self.passenger.count {
//
//                            self.setupTableView()
//                            self.tableView.reloadData()
//                            print("contador: \(self.passenger.count)")
//
//                        }
//                    }
//                }
//
//            }
//
//
//        }
//
//
//    }
    //method to retrieve firebase requests
    func recoveredData () {
        //Creted database Reference
        let requests = Database.database().reference().child("requests")
        
        //Recovering of the request list
        requests.observe(.childAdded) { (snapshot) in
//            self.requisitionList.append(snapshot)
            var email : String = ""
            var latitude : CLLocationDegrees = 0
            var longitude : CLLocationDegrees = 0
            var nome : String = ""
            
            print("requisitions : \(self.requisitionList.count)")
            
//            for indexPassenger in 0..<self.requisitionList.count {
//                print("indexPassenger... \(indexPassenger)")
                
                
                //recovering the requests
//                let snapshot = self.requisitionList[ indexPassenger ]
                if let data = snapshot.value as? [String: Any] {
                    
                    //Configure the cell
                    email = data["e-mail"] as? String ?? ""
                    latitude = data["latitude"] as? CLLocationDegrees ?? 0
                    longitude = data["longitude"] as? CLLocationDegrees ?? 0
                    nome = data["name"] as? String ?? ""
                    
                    print("e-mail: \(email) \n"  +  "name: \(nome) \n" + "latitude: \(latitude) \n" + "longitude: \(longitude)" )
                    
                    DispatchQueue.main.async() {
                        print("email antes do append... \(email)")
                        
                        print("email antes do append Passenger ... \(self.passenger.count)")
                        
                        self.passenger.append(Passenger(email: email, longitude: longitude, latitude: latitude, nome: nome))
//                        if self.requisitionList.count == self.passenger.count {
                            
                            self.setupTableView()
                            self.tableView.reloadData()
                            print("contador: \(self.passenger.count)")
                            
//                        }
                    }
                }
                
//            }
            
            
        }
        
        
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
    
    func setupTableView (){
        
        dataSource.data = [Any]()
        
//        let driverModellCard1 = DriverModel(delegate: self, tituloCard: self.requisitionList, distanceDriver: passenger.first?.email ?? "", imageDriver: "menu_cliente")
//        let driverModellCard2 = DriverModel(delegate: self, tituloCard: requisitionList, distanceDriver:  passenger.last?.email ?? "", imageDriver: "menu_cliente")
//
//        dataSource.data.append(driverModellCard1)
//        dataSource.data.append(driverModellCard2)
        
        for passageiro in passenger {
            
            let driverModellCard1 = DriverModel(delegate: self, tituloCard: passageiro.nome, distanceDriver: passageiro.email , imageDriver: "menu_cliente")
            
            dataSource.data.append(driverModellCard1)
            
        }
        
        tableView.allowsSelection = false
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        print("Entrou na funcao... setupTableView")
//        print("email : \(self.passenger.first?.email)")
//        print("latitude : \(self.passenger.first?.latitude)")
//        print("longitude : \(self.passenger.first?.longitude)")
//        print("nome : \(self.passenger.first?.nome)")
//        print(passenger.count)
//
//        //show tableView
        dataSource.initializeTableView(tableView: tableView)
        
    }
    
}
