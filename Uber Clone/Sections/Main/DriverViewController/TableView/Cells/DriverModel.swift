//
//  DriverModel.swift
//  Uber Clone
//
//  Created by Andre Linces on 19/10/21.
//

import UIKit

protocol DriverModelCellCallBack: class {
    
    func acaoCliqueCard( indexPath: IndexPath )
    
}

class DriverModel: tableViewCompatible {
    internal init (delegate: DriverModelCellCallBack, tituloCard: String, distanceDriver: String, imageDriver: String) {
        
        self.delegate = delegate
        self.tituloCard = tituloCard
        self.distanceDriver = distanceDriver
        self.imageDriver = imageDriver
    }
    
    open weak var delegate : DriverModelCellCallBack?
    
    var reuseIdentifier: String {
        return "DriverModelCellIdentifier"
    }
    
    //variáveis de inicialização
    var tituloCard : String
    var distanceDriver: String
    var imageDriver: String
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DriverModelCell {
            
            //inicializando células (design, values, images, etc...)
            cell.setupDesign()
            
            cell.setupValues(tituloCard: tituloCard, distanceCard: distanceDriver )
            
            cell.setupImage(imageDriver: imageDriver)
            
            //Adicionando cliques nos cards
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
