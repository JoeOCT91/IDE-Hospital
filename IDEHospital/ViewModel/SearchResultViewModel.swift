//
//  SearchResultViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import Foundation
protocol SearchResultViewModelProtocol {
    func bringSortArrCount() -> Int
    func bringSortArrValues(row:Int) -> String
    func itemSelected(tag: Int, row: Int)

}
class SearchResultViewModel{
    private weak var view:SearchResultVCProtocol!
    private let sortArr:[String] = [L10n.fees,L10n.rating]
    init(view:SearchResultVCProtocol) {
        self.view = view
    }
}
extension SearchResultViewModel:SearchResultViewModelProtocol{
    func bringSortArrValues(row: Int) -> String {
        return self.sortArr[row]
    }
    
    func bringSortArrCount() -> Int {
        return self.sortArr.count
    }
    
    func itemSelected(tag: Int, row: Int) {
        view.addSelectedItem(tag: tag, item: self.sortArr[row])
             
    }
    
    
}
