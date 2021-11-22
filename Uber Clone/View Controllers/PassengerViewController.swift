//
//  PassengerViewController.swift
//  Uber Clone
//
//  Created by Andre Linces on 06/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class PassengerViewController: UIViewController, CLLocationManagerDelegate {
    //creating references
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var buttonCallUber: UIButton!
    
    //instantiating object CllocationManager
    var locationManager = CLLocationManager()
    
    //instantiating the objet to the user's coordinates
    var userlocation = CLLocationCoordinate2D()
    
    var uberCalled = false
   
    
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
        
        //Check if you already have an uber request.
        let database = Database.database().reference()
        let authentication = Auth.auth()
        
        if let emailUser = authentication.currentUser?.email {
            
            let requests = database.child("requests")
            let requestsConsul = requests.queryOrdered(byChild: "email").queryEqual(toValue: emailUser)
            
            requestsConsul.observeSingleEvent(of: .childAdded) { snapshot in
                
                if snapshot.value != nil {
                    //Cancels the passenger's run.
                    self.buttonCallUber
                    
                }
            }
        }
    }
    
    //Creating references of the button call uber
    
    @IBAction func callUber(_ sender: Any) {
        //creating references of the database
        let database = Database.database().reference()
        
        //creating references to retrieve user data
        let authentication = Auth.auth()
        
        if let userEmail = authentication.currentUser?.email {
            
            //creating node requests
            let request = database.child("requests")
            
            if self.uberCalled {//uber call
                
                //Change the color and title of the button when user click cancel.
                self.changeColorButtonCallUber()
                
                //remove request
                let request = database.child("requests")
                //Searches the email node and sorts by the email of the logged in user.
                request.queryOrdered(byChild: "e-mail").queryEqual(toValue: userEmail).observeSingleEvent(of: .childAdded) { (snapshot) in
                    //print for test the search.
                    print ("CallUber Snapshot value: \(snapshot.value)")
                    
                    snapshot.ref.removeValue()
                    
                }
                
            }else{//uber was not called
                
                if let userId = authentication.currentUser?.uid {
                    let database = Database.database().reference()
                    //retrive username
                    let users = database.child("users").child(userId)
                    
                    users.observeSingleEvent(of: .value) { snapshot in
                        
                        let data = snapshot.value as? NSDictionary
                        
                        let userName = data!["name"] as? String
                        
                        //Creating request
                        //creating an array of dictionary for the registered data of the passing user.
                        let dataUser = [
                        
                            "e-mail" : userEmail ,
                            "name" : userName ,
                            "latitude" : self.userlocation.latitude,
                            "longitude" : self.userlocation.longitude
                        ] as [String : Any]
                        
                        //Creating automatic ID for requests
                        request.childByAutoId().setValue( dataUser )
                        
                    }
                    //Change the color and title of the button when user click cancel.
                    self.changeColorButtonCancelUber()
                      
                }
                  
            }
             
        }
     
    }//End the method calluber
    
    //Method for updating user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Retrieving the coordinates
        if let coordinateRecovered = manager.location?.coordinate {
            
            //configure the current user location
            self.userlocation = coordinateRecovered
            
            //Defines user's location with the coordinateRecovered object and with a distance accuracy 200
            let region = MKCoordinateRegion.init(center: coordinateRecovered, latitudinalMeters: 200, longitudinalMeters: 200)
            
            //using the mapview of the app
            mapView.setRegion(region, animated: true)
            
            //Removes all user annotations on the map before displaying the current annotation
            
            //Create an annotation for the user's location
            let userAnnotation = MKPointAnnotation()
            userAnnotation.coordinate = coordinateRecovered
            userAnnotation.title = "Your location !!"
            mapView.addAnnotation(userAnnotation)
        }
          
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
    
    func changeColorButtonCallUber () {
        
        self.buttonCallUber.setTitle("Call Uber!", for: .normal)
        self.buttonCallUber.backgroundColor = UIColor(red: 0.067, green: 0.576, blue: 0.604, alpha: 1)
        self.uberCalled = false
        
    }
    
    func changeColorButtonCancelUber() {
        
        self.buttonCallUber.setTitle("Cancel Uber!", for: .normal)
        self.buttonCallUber.backgroundColor = UIColor(red: 0.831, green: 0.237, blue: 0.146, alpha: 1)
        self.uberCalled = true
        
    }
     
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
