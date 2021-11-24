//
//  AcceptRaceViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 13/11/21.
//

import UIKit
import MapKit
import FirebaseDatabase

class AcceptRaceViewController: UIViewController, CLLocationManagerDelegate {
    
 
    @IBOutlet weak var accpetRaceMap: MKMapView!
    
    
    
    var passengerName = ""
    var passengerEmail = ""
    var passengerLocal = CLLocationCoordinate2D()
    var driverlocation = CLLocationCoordinate2D()

    
    @IBAction func acceptRace(_ sender: Any) {
        
        //Update requisition
        let database = Database.database().reference()
        let requests = database.child("requests")
        
        requests.queryOrdered(byChild: "e-mail").queryEqual(toValue: self.passengerEmail).observeSingleEvent(of: .childAdded) { snapshot in
            
            let driverData = [
            
                "DriverLatitude" : self.driverlocation.latitude,
                "DriverLongitude" : self.driverlocation.longitude
            
            ]
            
            snapshot.ref.updateChildValues(driverData)
            
        }
        
        //Displays the path for the passenger on the map.
        
        //Needs create an object of the type Cllocation for o ClGeocoder, so and i'll use in Mkplacemark
        let passengerCLLocation = CLLocation(latitude: passengerLocal.latitude, longitude: passengerLocal.longitude)
        //Create reverseGlGeocoder for retrive o objeto and use Mkplacemark
        CLGeocoder().reverseGeocodeLocation(passengerCLLocation) { ( local, erro ) in
            
            if erro == nil {
                
                if let localData = local?.first {
                    
                    let placeMark = MKPlacemark(placemark: localData)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = self.passengerName
                    
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                    
                }
            }
            
        }
        
      
    }
    
    
    func initiate (passengerName: String, passengerEmail: String, passengerLocal: CLLocationCoordinate2D, driverLocation: CLLocationCoordinate2D) {
        
        self.passengerName = passengerName
        self.passengerEmail = passengerEmail
        self.passengerLocal = passengerLocal
        self.driverlocation = driverLocation
        
        print("TESTE OP passengerName : \(passengerName)")
        print("TESTE OP passengerEmail : \(passengerEmail)")
        print("TESTE OP passengerLocal : \(passengerLocal)")
        print("TESTE OP driverlocation : \(driverlocation)")
        
    }
    
//    //Method for updating user location
//   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        //Retrieving the coordinates
//        if let coordinateRecovered = manager.location?.coordinate {
//
//            //configure the current user location
//            self.userLocationRace = coordinateRecovered
//
//            //Defines user's location with the coordinateRecovered object and with a distance accuracy 200
//            let region = MKCoordinateRegion.init(center: coordinateRecovered, latitudinalMeters: 200, longitudinalMeters: 200)
//
//            //using the mapview of the app
//            accpetRaceMap.setRegion(region, animated: true)
//
//            //Removes all user annotations on the map before displaying the current annotation
//
//            //Create an annotation for the user's location
//            let userAnnotation = MKPointAnnotation()
//            userAnnotation.coordinate = coordinateRecovered
//            userAnnotation.title = "Your location !!"
//            accpetRaceMap.addAnnotation(userAnnotation)
//        }
//    }
    
//    var requisitionList = [DataSnapshot]()
    
    
    
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
//                    nome = data["name"] as? String ?? ""
//
//                    print("e-mail: \(email) \n"  +  "name: \(nome) \n" + "latitude: \(latitude) \n" + "longitude: \(longitude)" )
//
//                    let driverLocal = CLLocation(latitude: self.driverlocation.latitude, longitude: self.driverlocation.longitude)
//
//                    let passengerLocal = CLLocation(latitude: latitude, longitude: longitude)
//
//                    let meterDistance = driverLocal.distance(from: passengerLocal)
//
//                    let KmDistance = meterDistance / 1000
//                    let finalDistance = round(KmDistance)
//
//                    print("Meter Distance: \( finalDistance)")
//
//
//                }
//
//        }
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        //own class that will manage the localization features
//        locationManager.delegate = self
//        //Defining the best location accuracy
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //Request user location authorization
//        locationManager.requestWhenInUseAuthorization()
//        //Updating user location
//        locationManager.startUpdatingLocation()
        
//        let region = MKCoordinateRegion(center: passengerLocal, latitudinalMeters: 200, longitudinalMeters: 200)
//        accpetRaceMap.setRegion(region, animated: true)
//        print("Email acceptRace: \(passengerEmail)")
//        print("teste de latitude: \(passengerLocal.latitude)")

        //adding passenger annotation
//        let passengerAnotation = MKPointAnnotation()
//        passengerAnotation.coordinate = self.passengerLocal
//        passengerAnotation.title = passengerName
//        accpetRaceMap.addAnnotation(passengerAnotation)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Email acceptRace: \(passengerEmail)")
        print("teste de latitude: \(passengerLocal.latitude)")
        
        let region = MKCoordinateRegion(center: passengerLocal, latitudinalMeters: 200, longitudinalMeters: 200)
        accpetRaceMap.setRegion(region, animated: true)
        
        //adding passenger annotation
        let passengerAnotation = MKPointAnnotation()
        passengerAnotation.coordinate = self.passengerLocal
        passengerAnotation.title = passengerName
        accpetRaceMap.addAnnotation(passengerAnotation)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Email acceptRace: \(passengerEmail)")
        print("teste de latitude: \(passengerLocal.latitude)")
    }
    
    
}
