//
//  SideMenuVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit
protocol SideMenuVCProtocol: class {
    func editProfilePressed()
    func termsAndConditionsPressed()
    func favoritesPressed()
}

class SideMenuVC: UIViewController {
    
    @IBOutlet var sideMenuView: SideMenuView!
    
    private var viewModel: SideMenuVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.setupTableView(delgate: self, dataSource: self)
    }
    
    // Public Methods
    class func create() -> SideMenuVC {
        let sideMenuVC: SideMenuVC = UIViewController.create(storyboardName: Storyboards.sideMenu, identifier: ViewControllers.sideMenu)
        let viewModel = SideMenuVM(view: sideMenuVC)
        sideMenuVC.viewModel = viewModel
        return sideMenuVC
    }
}
extension SideMenuVC: SideMenuVCProtocol {
    func editProfilePressed() {
        
    }
    func favoritesPressed() {
        print("favoritesPressed")
        self.tabBarController?.selectedIndex = 1
    }
    
    func bookedAppointmentsPressed() {
        
    }
    func termsAndConditionsPressed(){
        let termsAndConditionsVC = TermsAndConditionsVC.create()
        navigationController?.pushViewController(termsAndConditionsVC, animated: true)
    }
    
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMenuItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.sideMenu, for: indexPath) as! SideMenuCell
        cell.setupCell(item: viewModel.getMenuItem(index: indexPath.row))
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuCell
        print( cell.tag)
        viewModel.navigateTo(index: cell.tag)
    }
}
