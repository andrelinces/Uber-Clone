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
    
    //References for view adress
    @IBOutlet weak var adressArea: UIView!
    @IBOutlet weak var passengerLocationMarker: UIView!
    @IBOutlet weak var destinationLocationMarker: UIView!
    @IBOutlet weak var fieldAdressDestination: UITextField!
    
    
    
    //instantiating object CllocationManager
    var locationManager = CLLocationManager()
    
    //instantiating the objet to the user's coordinates
    var userlocation = CLLocationCoordinate2D()
    
    //instantiating the objet to the user's coordinates
    var driverLocation = CLLocationCoordinate2D()
    
    var uberCalled = false
    
    var uberWay = false
    
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
        
        //It's creates rounding for markers
        self.passengerLocationMarker.layer.cornerRadius = 17.5
        self.passengerLocationMarker.clipsToBounds = true
        
        self.destinationLocationMarker.layer.cornerRadius = 17.5
        self.destinationLocationMarker.clipsToBounds = true
        
        self.adressArea.layer.cornerRadius = 10
        self.adressArea.clipsToBounds = true


    }
    
    func  displayDriverPassenger() {
        
        self.uberWay = true
        
        print("entrou na funcao display: \(buttonCallUber)")
        //retrive distance between driver and passenger
        let driverLocations = CLLocation(latitude: self.driverLocation.latitude, longitude: self.driverLocation.longitude)
        
        let passengerLocations = CLLocation(latitude: self.userlocation.latitude, longitude: self.userlocation.longitude)
        
        //Calcs distance between driver and passenger
        
        let distance = driverLocations.distance(from: passengerLocations)
        let distanceKm = distance / 1000
        let finalDistance = round(distanceKm)
        
        self.buttonCallUber.backgroundColor = UIColor(displayP3Red: 0.067, green: 0.576, blue: 0.604, alpha: 1)
        self.buttonCallUber.setTitle("Driver \(finalDistance) km away!" , for: .normal)
        
        //Display passenger and driver in map.
        mapView.removeAnnotations(mapView.annotations)
        
        let differenceLat = abs(self.userlocation.latitude - self.driverLocation.latitude) * 300000
        let differenceLon = abs(self.userlocation.longitude - self.driverLocation.longitude) * 300000
        
        //Creating local for display driver and passenger.
        let region = MKCoordinateRegion(center: self.userlocation, latitudinalMeters: differenceLat, longitudinalMeters: differenceLon)
        mapView.setRegion(region, animated: true)
        
        //Display annotation driver
        let driverAnnotation = MKPointAnnotation()
        driverAnnotation.coordinate = self.driverLocation
        driverAnnotation.title = "Motorista"
        mapView.addAnnotation( driverAnnotation )
        
        //Display annotation passenger
        let passengerAnnotation = MKPointAnnotation()
        passengerAnnotation.coordinate = self.userlocation
        passengerAnnotation.title = "Passageiro"
        mapView.addAnnotation( passengerAnnotation )
          
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
                
                self.saveRequest()
                  
            }//end else
             
        }
     
    }//End the method calluber
    
    func saveRequest() {
        
        //creating references of the database
        let database = Database.database().reference()
        //creating references to retrieve user data
        let authentication = Auth.auth()
        //creating node requests
        let request = database.child("requests")
        
        
        if let userId = authentication.currentUser?.uid {
            if let userEmail = authentication.currentUser?.email {
                if let adressDestination = self.fieldAdressDestination.text {
                    if adressDestination != nil {
                    
                        CLGeocoder().geocodeAddressString(adressDestination) { local, erro in
                            
                            if erro == nil {
                                
                                //print for test 'local', return adress street, number, city, postalCode etc...
                                //print("teste local function saveRequest: \(local?.first)")
                                
                                if let localData = local?.first {
                                    
                                    var street = ""
                                    if localData.thoroughfare != nil {
                                    street = localData.thoroughfare!
                                    }
                                    var number = ""
                                    if localData.subThoroughfare != nil {
                                    number = localData.subThoroughfare!
                                    }
                                    var subLocality = ""
                                    if localData.subLocality != nil {
                                    subLocality = localData.subLocality!
                                    }
                                    var locality = ""
                                    if localData.locality != nil {
                                    locality = localData.locality!
                                    }
                                    var postalCode = ""
                                    if localData.postalCode != nil {
                                    postalCode = localData.postalCode!
                                    }
//                                    testing adress
//                                    Horácio lafer, 100
                                    
                                    let fullAdress = "Street: \(street) \n Number: \(number) \n SubLocality: \(subLocality) \n Locality: \(locality) \n PostalCode: \(postalCode)"
                                    //"\(street), + \(number), \(subLocality) - \(locality) - \(postalCode)"
                                    print(street)
                                    print("Testing localData: \(fullAdress)")
                                    
                                    if let latDestination = localData.location?.coordinate.latitude {
                                        if let lonDestination = localData.location?.coordinate.longitude {
                                            
                                            let alert = UIAlertController(title: "Do you confirm your address?", message: fullAdress, preferredStyle: .alert)
                                            
                                            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                            
                                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                //testing...
                                                print("confirmAction")
                                                
                                                //Retrieve name user
                                                let database = Database.database().reference()
                                                //retrive username
                                                let users = database.child("users").child(userId)
                                                
                                                users.observeSingleEvent(of: .value) { snapshot in
                                                    
                                                    let data = snapshot.value as? NSDictionary
                                                    
                                                    let userName = data!["name"] as? String
                                                    
                                                    //Creating request
                                                    //creating an array of dictionary for the registered data of the passing user.
                                                    let dataUser = [
                                                        "latDestination" : latDestination,
                                                        "lonDestination" : lonDestination,
                                                        "e-mail" : userEmail ,
                                                        "name" : userName ,
                                                        "latitude" : self.userlocation.latitude,
                                                        "longitude" : self.userlocation.longitude
                                                    ] as [String : Any]
                                                    
                                                    //Creating automatic ID for requests
                                                    request.childByAutoId().setValue( dataUser )
                                                    
                                                    //Change the color and title of the button when user click cancel.
                                                    self.changeColorButtonCancelUber()
                                                    
                                                }
                                                
                                            }
                                            
                                            alert.addAction(cancelAlert)
                                            alert.addAction(confirmAction)
                                            
                                            self.present(alert, animated: true, completion: nil)
                                             
                                    }//end lonDestination
                                    
                                }//end latDestination
                                    
                                     
                                }//end if localData
                                
                            }//end if erro == nil
                            
                        }//end CLGeocoder
                        
                    }else {
                        
                        print("Field adress destination are empty !!")
                    }
                }
                /*
                //Retrieve name user
                let database = Database.database().reference()
                //retrive username
                let users = database.child("users").child(userId)
                
                users.observeSingleEvent(of: .value) { snapshot in
                    
                    let data = snapshot.value as? NSDictionary
                    
                    let userName = data!["name"] as? String
                    
                    //Creating request
                    //creating an array of dictionary for the registered data of the passing user.
                    let dataUser = [
                        "latDestination" : "",
                        "lonDestination" : "",
                        "e-mail" : userEmail ,
                        "name" : userName ,
                        "latitude" : self.userlocation.latitude,
                        "longitude" : self.userlocation.longitude
                    ] as [String : Any]
                    
                    //Creating automatic ID for requests
                    request.childByAutoId().setValue( dataUser )
                }
                */
                
            }//end if userEmail
            
            
            
            
        }//end if userId
    }//fim function
    
            /*
                
                    
                    
                        
                        
                            
                            
                                
                                
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                
                                  
                                    /*
                                    
                                    
                                    
                               
                                */
                            
                            }//end if erro != nill
                            
                        }
                        
                    }
                    
                }//end adressDestination
                
            
             
            
         */
         
      
                     
                     
                
    
         
    //Method for updating user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Retrieving the coordinates
        if let coordinateRecovered = manager.location?.coordinate {
            
            //configure the current user location
            self.userlocation = coordinateRecovered
            
            if self.uberWay {
                
                self.displayDriverPassenger()
            } else {
                
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
        

               //Check if you already have an uber request.
               let database = Database.database().reference()
               let authentication = Auth.auth()

               if let emailUser = authentication.currentUser?.email {
                   print("entrou no if emailuser display  \(self.buttonCallUber)")
                   let requests = database.child("requests")
                   let requestsConsul = requests.queryOrdered(byChild: "e-mail").queryEqual(toValue: emailUser)

                   //Creates a listener so when the user calls uber he can cancel.
                   requestsConsul.observeSingleEvent(of: .childAdded) { snapshot in
                       if snapshot.value != nil {
                           //Cancels the passenger's run.
                           self.buttonCallUber
                           print("testando funcao display didAper \(snapshot)")
                       //}
                       print("exibe distancia do motorista para usuario: \(snapshot)")
              //            //Creates a listener only when the driver accepts race of the uber.
                              requestsConsul.observeSingleEvent(of: .childChanged) { snapshot in
                                  print("testando listener.. \(snapshot)")
                                  if let data = snapshot.value as? [String: Any] {
                                      print("testando if depois do listener.. \(snapshot)")
                                      if let driverLat = data["DriverLatitude"] {

                                          if let driverLon = data["DriverLongitude"] {
                                              print("chamada da funcao no if longi... \(driverLon)")
                                              self.driverLocation = CLLocationCoordinate2D(latitude: driverLat as! CLLocationDegrees as! CLLocationDegrees, longitude: driverLon as! CLLocationDegrees)
                                              print("chamada da funcao no if... \(self.driverLocation)")
                                              self.displayDriverPassenger()
                                          }
                                      }
                                  }
                              }
                           
                       }
                   }
                   
                   
               }
    }
}
