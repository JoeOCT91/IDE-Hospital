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
    func bookedAppointmentsPressed()
    func aboutUsPressed()
    func contactUsPressed()
    func sharePressed()
}

class SideMenuVC: UIViewController {
    
    @IBOutlet var sideMenuView: SideMenuView!
    
    private var viewModel: SideMenuVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.setupTableView(delgate: self, dataSource: self)
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
        sideMenuView.sideMenuTableView.reloadData()
    }
    
    private func configureNavigationBar(){
        setupNavigationBar(backgroundColor: ColorName.darkRoyalBlue.color)
        setViewControllerTitle(to: "SETTING", fontColor: ColorName.white.color)
        setupBackWithDismiss()
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
        let favoritesVC = FavoritesVC.create()
        pushToNavigation(VC: favoritesVC)
    }
    
    func bookedAppointmentsPressed() {
        let appointmentsVC = AppointmentsVC.create()
        appointmentsVC.setupBackWithPopup()
        pushToNavigation(VC: appointmentsVC)
    }
    
    func aboutUsPressed() {
        let aboutUs = AboutVC.create()
        pushToNavigation(VC: aboutUs)
    }
    
    func contactUsPressed() {
        let contactUs = ContactUsVC.create()
        pushToNavigation(VC: contactUs)
    }
    
    func sharePressed() {
        let alert = AlertVC()
        presentAlertOnMainThread(alertVC: alert)
    }
    
    func termsAndConditionsPressed(){
        let termsAndConditionsVC = TermsAndConditionsVC.create()
        pushToNavigation(VC: termsAndConditionsVC)
    }
    
    func logoutPressed(){
        let alert = ConfirmationAlert(id: 0, message: "Are you sure to logout!")
        alert.delgate = self
        presentAlertOnMainThread(alertVC: alert)
    }
    
    func logoutSuccess(){
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func loginPressed(){
        let signinVC = SignInVC.create()
        pushToNavigation(VC: signinVC)
    }
    
    private func pushToNavigation(VC: UIViewController){
        self.navigationController?.pushViewController(VC, animated: true)
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
        viewModel.navigateTo(index: cell.tag)
    }
}

extension SideMenuVC: ConfirmationAlertDelgate {
    func confirmPressed(id: Int) {
        viewModel.logout()
    }
}
