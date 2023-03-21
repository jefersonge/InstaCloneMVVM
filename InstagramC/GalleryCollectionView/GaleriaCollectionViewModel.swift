//
//  GaleriaCollectionViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 26/12/22.
//

import Foundation


class GaleriaCollectionViewModel {
    var data: Dictionary<String, Any>
    
    init(data: Dictionary<String, Any>) {
        self.data = data
    }
    
    var getDescricao : String {
        return self.data["descricao"] as? String ?? ""
    }
    
    var getUrl : String {
        return self.data["url"] as? String ?? ""
    }
}
