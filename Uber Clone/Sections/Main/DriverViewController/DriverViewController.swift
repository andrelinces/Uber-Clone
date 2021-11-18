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


class DriverViewController: UIViewController, DriverModelCellCallBack, CLLocationManagerDelegate {
    
    func acaoCliqueCard(indexPath: IndexPath) {
        print("clicou no card de número: \(indexPath)")
        //let snapshot = self.requisitionList
        performSegue(withIdentifier: "segueAcceptRace", sender: indexPath)
         
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Teste do prepare:")
        if let acceptRaceViewController = segue.destination as? AcceptRaceViewController {
            print("teste depois do prepare, segue: \(sender)")
            
            if let indexPath = sender as? IndexPath {
                print("teste depois do prepare, segue: \(indexPath.row)")
                
                //TESTE REMOVER/ALTERAR
                var listaTeste = [Passenger]()
                
                //Creted database Reference
                let requests = Database.database().reference().child("requests")
                
                //Recovering of the request list
                requests.observe(.childAdded) { (snapshot) in
                    
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
                        
                        let driverLocal = CLLocation(latitude: self.driverlocation.latitude, longitude: self.driverlocation.longitude)
                        
                        let passengerLocal = CLLocation(latitude: latitude, longitude: longitude)
                        
                        let meterDistance = driverLocal.distance(from: passengerLocal)
                        
                        let KmDistance = meterDistance / 1000
                        let finalDistance = round(KmDistance)
                        
                        print("Meter Distance: \( finalDistance)")
                        
                        DispatchQueue.main.async() {
                            print("email antes do append... \(email)")
                            
                            print("Requisicao do append Passenger ... \(self.passenger.count)")
                            
                            
                            
                            listaTeste.append(Passenger(email: email, longitude: longitude, latitude: latitude, nome: nome, distancePassenger: finalDistance ) )
                            //                        if self.requisitionList.count == self.passenger.count {
                            
                            
                            if listaTeste.count == data.count {
                                
                                acceptRaceViewController.initiate(passengerName: listaTeste[indexPath.row].nome, passengerEmail: listaTeste[indexPath.row].email, passengerLocal: CLLocationCoordinate2D(latitude: listaTeste[indexPath.row].latitude, longitude: listaTeste[indexPath.row].longitude), driverLocation: self.driverlocation)
                                
                            }
                            
//                            acceptRaceViewController.initiate(passengerName: nome, passengerEmail: email, passengerLocal: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), driverLocation: self.driverlocation)
                            
                            
                            
                            // Envia os dados para a próxima ViewController
                            
                            //                        AcceptRaceViewController().passengerName = nome
                            //                        AcceptRaceViewController().passengerEmail = email
                            //                        //AcceptRaceViewController().passengerLocal =
                            
                            self.setupTableView()
                            self.tableView.reloadData()
                            
                            print("contador: \(self.passenger.count)")
                            
                            //                        }
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            //pega o dataSnapshot e salva numa variavel [snapshotRecuperado]
            
//            if let snapshot = snapshotRecuperado as? DataSnapshot {
//                print("teste depois do prepare, snapshot: \(snapshot)")
//                if let data = snapshot.value as? [ String : Any ] {
//                    if let passengerLatitude = data["latitude"] as? Double {
//                        if let passengerLongitude = data["longitude"] as? Double {
//                            if let passengerName = data["name"] as? String {
//                                if let passengerEmail = data["e-mail"] as? String {
//
//                                    // retrieves passenger data
//                                    let passengerLocal = CLLocationCoordinate2D(latitude: passengerLatitude, longitude: passengerLongitude)
//
//                                    acceptRaceViewController.initiate(passengerName: passengerName, passengerEmail: passengerEmail, passengerLocal: passengerLocal, driverLocation: driverlocation)
//                                    print("Teste do prepare: \(passengerName)")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
            
            
        }
    }
//        if segue.identifier == "segueAcceptRace" {
//            if let acceptRaceViewController2 = segue.destination as? AcceptRaceViewController {
//
//                if let snapshot = sender as? DataSnapshot {
//
//                                    if let data = snapshot.value as? [ String : Any ] {
//                                        if let passengerLatitude = data["latitude"] as? Double {
//                                            if let passengerLongitude = data["longitude"] as? Double {
//                                                if let passengerName = data["name"] as? String {
//                                                    if let passengerEmail = data["e-mail"] as? String {
//
//                                                        // retrieves passenger data
//                                                        let passengerLocal = CLLocationCoordinate2D(latitude: passengerLatitude, longitude: passengerLongitude)
//                                                        // Envia os dados para a próxima ViewController
//                                                        print("teste do prepare: \(passengerLatitude)")
//                                                        acceptRaceViewController2.passengerName = passengerName
//                                                        acceptRaceViewController2.passengerEmail = passengerEmail
//                                                        acceptRaceViewController2.passengerLocal = passengerLocal
//
//                                                        // Envia os dados do motorista
//                                                        //AcceptRaceViewController().driverLocal = driverlocation
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
                
                
    @IBOutlet weak var tableView: UITableView!
    //Instanting with the driver dataSource
    let dataSource = DriverDataSource()
    
    var passenger = [Passenger]()
    
    //Configuring driver location
    //instantiating object CllocationManager
    var locationManager = CLLocationManager()
    
    //instantiating the objet to the user's coordinates
    var driverlocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       recoveredData()
       setupTableView()
        //own class that will manage the localization features
        locationManager.delegate = self
        //Defining the best location accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //Request user location authorization
        locationManager.requestWhenInUseAuthorization()
        //Updating user location
        locationManager.startUpdatingLocation()
           
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordenadas = manager.location?.coordinate {
            
            self.driverlocation = coordenadas
              
        }
        
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
            //var passengerDistance : Int
            
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
                    
                    let driverLocal = CLLocation(latitude: self.driverlocation.latitude, longitude: self.driverlocation.longitude)
                    
                    let passengerLocal = CLLocation(latitude: latitude, longitude: longitude)
                    
                    let meterDistance = driverLocal.distance(from: passengerLocal)
                    
                    let KmDistance = meterDistance / 1000
                    let finalDistance = round(KmDistance)
                    
                    print("Meter Distance: \( finalDistance)")
                    
                    DispatchQueue.main.async() {
                        print("email antes do append... \(email)")
                        
                        print("Requisicao do append Passenger ... \(self.passenger.count)")
                        
                        
                        self.passenger.append(Passenger(email: email, longitude: longitude, latitude: latitude, nome: nome, distancePassenger: finalDistance ) )
//                        if self.requisitionList.count == self.passenger.count {
                    
                        // Envia os dados para a próxima ViewController
                        
//                        AcceptRaceViewController().passengerName = nome
//                        AcceptRaceViewController().passengerEmail = email
//                        //AcceptRaceViewController().passengerLocal =
                        
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
            
            let driverModellCard1 = DriverModel(delegate: self, tituloCard: passageiro.nome, distanceDriver: passageiro.distancePassenger ,  imageDriver: "menu_cliente", phonePassenger: 77)
            
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
