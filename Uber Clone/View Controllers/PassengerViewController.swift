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
    
    
    
    let region = MKCoordinateRegion(center: <#T##CLLocationCoordinate2D#>, span: <#T##MKCoordinateSpan#>)
    let mapView = MKMapView.setRegion(self.region)
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
