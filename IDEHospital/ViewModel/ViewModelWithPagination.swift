//
//  ViewModelWithPagination.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

protocol ViewModelWithPaginatioProtocol: class {
    func getDataListCount() -> Int
}

class ViewModelWithPagination<T: PaginationVCProtocol> {
    
    internal weak var view: T?
    internal var dataList = [Codable]()
    
    //Pagination proprties
    internal var page = 1
    internal var hasMorePages = true
    
    func getDataListCount() -> Int {
        return dataList.count
    }
    
}
