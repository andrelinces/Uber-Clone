//
//  DriverModelCell.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit
import FirebaseDatabase

class DriverModelCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelDriverName: UILabel!
    @IBOutlet weak var labelDriverDistance: UILabel!
    @IBOutlet weak var imageViewDriver: UIImageView!
    
    func setupDesign () {
        
        cardView.modificaDesignView(cornerRadius: 28)
        
    }
    
    func setupValues (tituloCard: String, distanceCard: String) {
        
        labelDriverName.text = tituloCard 
        labelDriverDistance.text = distanceCard
        
    }
    
    func setupImage (imageDriver: String) {
        
       imageViewDriver.image = UIImage(named: imageDriver)
        
    }
     
}
