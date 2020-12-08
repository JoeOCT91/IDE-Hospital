//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation

protocol HomeViewModelProtocol {
    
}

class HomeViewModel {
    
    weak var view: HomeViewModelProtocol!
    
    init(view: HomeViewModelProtocol){
        self.view = view
    }
    
}
