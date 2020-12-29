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
    func logoutPressed()
    func logoutSuccess()
    func loginPressed()
}

class SideMenuVC: UIViewController {
    
    @IBOutlet var sideMenuView: SideMenuView!
    
    private var viewModel: SideMenuVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaultsManager.shared().token)
        sideMenuView.setupTableView(delgate: self, dataSource: self)
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenuView.sideMenuTableView.reloadData()
    }
    
    private func configureNavigationBar(){
        setupNavigationBar(backgroundColor: ColorName.darkRoyalBlue.color)
        setViewControllerTitle(to: "SETTING", fontColor: ColorName.white.color)
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
        let alert = AlertVC()
        presentAlertOnMainThread(alertVC: alert)
    }
    
    func favoritesPressed() {
        self.tabBarController?.selectedIndex = 1
        self.navigationController?.popViewController(animated: false)
    }
    
    func bookedAppointmentsPressed() {
        let appointmentsVC = AppointmentsVC.create()
        navigationController?.pushViewController(appointmentsVC, animated: true)
    }
    
    func termsAndConditionsPressed(){
        let termsAndConditionsVC = TermsAndConditionsVC.create()
        navigationController?.pushViewController(termsAndConditionsVC, animated: true)
    }
    func logoutPressed(){
        let alert = ConfirmationAlert(id: 0, message: "Are you sure to logout!")
        alert.delgate = self
        presentAlertOnMainThread(alertVC: alert)
    }
    
    func logoutSuccess(){
        self.dismiss(animated: true)
    }
    
    func loginPressed(){
        let signinVC = SignInVC.create()
        navigationController?.pushViewController(signinVC, animated: true)
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

extension SideMenuVC: ConfirmationAlertDelgate {
    func confirmPressed(id: Int) {
        viewModel.logout()
    }
    
    
}
