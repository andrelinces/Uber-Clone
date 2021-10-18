//
//  GlobalExtension.swift
//  Uber Clone
//
//  Created by Andre Linces on 18/10/21.
//

import UIKit

extension UIView {
    //modifica o design da view, do card exibido na tabela.
    func modificaDesignView( cornerRadius: CGFloat, shadow: CGSize, shadowOpacity: Float ) {
        
        self.layer.cornerRadius = cornerRadius
        
        self.layer.shadowOffset = shadow
        
        self.layer.shadowOpacity = shadowOpacity
        
    }
    
    func modificaDesignView( cornerRadius: CGFloat ) {
        
        self.layer.cornerRadius = cornerRadius
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        self.layer.shadowOpacity = 0.3
        
    }
    
    
}
