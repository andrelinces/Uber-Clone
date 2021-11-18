//
//  DriverModel.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit
import FirebaseDatabase

protocol DriverModelCellCallBack: class {
    
    func acaoCliqueCard( indexPath: IndexPath )
    
}

class DriverModel: tableViewCompatible {
    internal init (delegate: DriverModelCellCallBack, tituloCard: String, distanceDriver: Double, imageDriver: String, phonePassenger: Int ) {
        
        self.delegate = delegate
        self.tituloCard = tituloCard
        self.distanceDriver = distanceDriver
        self.imageDriver = imageDriver
        self.phonePassenger = phonePassenger
    }
    
    open weak var delegate : DriverModelCellCallBack?
    
    var reuseIdentifier: String {
        return "DriverModelCellIdentifier"
    }
    
    //variáveis de inicialização
    var tituloCard : String
    var distanceDriver: Double
    var imageDriver: String
    var phonePassenger: Int
    
    var requisitionList : [DataSnapshot] = []
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DriverModelCell {
            
            //inicializando células (design, values, images, etc...)
            cell.setupDesign()
            
            cell.setupValues(tituloCard: tituloCard, distanceCard: distanceDriver )
            
            cell.setupImage(imageDriver: imageDriver)
             
//            let snapshot = self.requisitionList[ indexPath.row ]
//
//            if let data = snapshot.value as? [String: Any] {
//
//                //Configure the cell
//
//                cell.setupValues(tituloCard: data["e-mail"] as! [DataSnapshot], distanceCard: distanceDriver)
//
//            }
            
            //adding clicks to cards
            let gestureCliqueCard = myTapCustom(target: self, action: #selector(acaoCliqueCardView))
            gestureCliqueCard.indexPath = indexPath
            
            cell.cardView.addGestureRecognizer(gestureCliqueCard)
            
            return cell
            
        }else{
            print("teste cell...")
            
            return UITableViewCell()
        }
        
    }
    
    @objc func acaoCliqueCardView(sender: myTapCustom ) {
        
        delegate?.acaoCliqueCard(indexPath: sender.indexPath!)
        
    }
    
    class myTapCustom: UITapGestureRecognizer {
        
        var indexPath : IndexPath?
        
    }
    
}
