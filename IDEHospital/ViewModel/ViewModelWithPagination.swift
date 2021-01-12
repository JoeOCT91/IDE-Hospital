//
//  ViewModelWithPagination.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation
import SDWebImage

protocol ViewModelWithPaginatioProtocol: PaginationChild {
    func getDataListCount() -> Int
    func scrollObserve(cellCount: Int)
    func clearData()
}

protocol PaginationChild: class {
    func getData()
}

class ViewModelWithPagination<T: PaginationVCProtocol> {
    
    weak var child: PaginationChild?
    
    internal weak var view: T?
    internal var dataList = [Codable]()
    
    //Pagination proprties
    internal var page = 1
    internal var hasMorePages = true
    
    func getDataListCount() -> Int {
        return dataList.count
    }
    
    internal func scrollObserve(cellCount: Int){
        if didScrollToEnd(cellCount: cellCount) && hasMorePages {
            child?.getData()
        }
    }
    
    private func didScrollToEnd(cellCount: Int) -> Bool {
        return cellCount + 1  == dataList.count ? true : false
    }
    
    internal func isHasMorePages(pagesCount: Int) {
        pagesCount > page ? (hasMorePages = true) : (hasMorePages = false)
    }
    
    //Clear all data in list View
    internal func clearData(){
        self.page = 1
        self.hasMorePages = true
        dataList.removeAll()
        view?.reloadTableview()
    }
}
