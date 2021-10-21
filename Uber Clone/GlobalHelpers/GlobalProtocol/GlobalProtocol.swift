//
//  GlobalProtocol.swift
//  Uber Clone
//
//  Created by Andre Linces on 18/10/21.
//

import UIKit

//Protocolo tem a função de definir qual método será usado. Para o model funcionar, células modelo da tableView
protocol tableViewCompatible {
    
    var reuseIdentifier : String {get}

    func cellForTableView ( tableView: UITableView, atIndexPath indePath: IndexPath ) -> UITableViewCell
    
}

//Protocolo tem a função de definir qual método será usado. Para o model funcionar, células modelo do collectionView.
protocol collectionViewCompatible {
    
    var reuseIdentifier :  String {get}
    
    func cellForCollectionView ( collectionView: UICollectionView, atindexPath indePath: IndexPath ) -> UICollectionView
    
    
    
    }
    

