//
//  PassengerViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 06/10/21.
//

import UIKit
import FirebaseAuth
import MapKit

class PassengerViewController: UIViewController, CLLocationManagerDelegate {
    //creating references
    @IBOutlet weak var mapView: MKMapView!
    
    //instantiating object CllocationManager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //own class that will manage the localization features
        locationManager.delegate = self
        //Defining the best location accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //Request user location authorization
        locationManager.requestWhenInUseAuthorization()
        //Updating user location
        locationManager.startUpdatingLocation()
        
    }
    //Method for updating user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Retrieving the coordinates
        if let coordinateRecovered = manager.location?.coordinate {
            
            //Defines user's location with the coordinateRecovered object and with a distance accuracy 200
            let region = MKCoordinateRegion.init(center: coordinateRecovered, latitudinalMeters: 200, longitudinalMeters: 200)
            
            //using the mapview of the app
            mapView.setRegion(region, animated: true)
            
            //Create an annotation for the user's location
            let userAnnotation = MKPointAnnotation()
            userAnnotation.coordinate = coordinateRecovered
            userAnnotation.title = "Your location !!"
            mapView.addAnnotation(userAnnotation)
        }
          
    }
    
    //let region = MKCoordinateRegion(center: <#T##CLLocationCoordinate2D#>, span: <#T##MKCoordinateSpan#>)
    //let mapView = MKMapView.setRegion(self.region)
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //Logout user
    @IBAction func logoutUser(_ sender: Any) {
        
        let authentication = Auth.auth()
        
        do {
            try authentication.signOut()
            print("Successful logout user !")
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Error logout user!!")
        }
        
    }
    
}
