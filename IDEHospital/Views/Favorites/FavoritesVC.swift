//
//  FavoritesVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import UIKit

protocol FavoritesVCProtocol: class {
    func setCellImage(image: Data, indexPath: IndexPath)
    func reloadTableview()
}

class FavoritesVC: UIViewController {
    
    @IBOutlet var favoritesView: FavoritesView!
    private var viewModel: FavoritesVMProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.setup()
        favoritesView.setupTableView(delgate: self, dataSource: self)
        UserDefaultsManager.shared().token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMWE4OTQ3YTEwMTM0ODIyM2ZjZDYyYzg0OGFkZDdlMmZmYzhiMzllZDAwMjdiODU4MzE3M2RiMjA2YmM0MmYzMjUyMjQzYmNkNjQ2YzUwZmYiLCJpYXQiOjE2MDQ0OTMzNDMsIm5iZiI6MTYwNDQ5MzM0MywiZXhwIjoxNjM2MDI5MzQzLCJzdWIiOiI0NSIsInNjb3BlcyI6W119.iYhEyw4yRfd5UNhmzR9F2xzhIYZktHEKT_vKXaaiBgEGx1bQ-oyiEq0nC5dYrJGCirPK86J4MNg-yHidl1wpLEeRUE-YROerT5irXwJkEP9dWVsosIItvMdG0msv4w7G4m3wZVSpaVaaJk2y-6KqZ1BphmuDieNqx4xQqHW1Y8NAu3Dh09lMX6xzMKZwu8kB_MEzv7G10b8n5VwktV31eu8MrBDJhZmwriP2MVM8NVKIgbCdAq3o-xThbqmG479ViS1O3ijJ047ZjkkduZsQuh92NHhrkj2wj5UBpjlYEjLlcKwFvFJcQFA5A0B_ackIJLQktDfw9DGFLLOGEzoi2nVj8tINCG9TbI4-5Y-G8h8kMJCzxybNl1UA-LsMoonM3rY3smQdentBVyM53FYkAbgy9yqAl7Od6A-3D2baEZncCHHq2sZe8eUdS_X07qrOEj1Ip-pc5kLwzwD6vM5y8ptFG_sWmszJo1rNOV6ZoacKD0p_KZU21c9DPjei4VP5Y6y_tilEDxLKfK3wCD_80fmhKjAR5BVpRqHmlWnA1laGx0hGxthXHeg6-5URONR4h0Yiw-ZhzxehIrRmG6vDsofg9jeqSbO4WnTTysCd21xhK1gEvj67DgwwY4Tq_iaZDgRQvKzjRDJpGMysFOS6f4MfbQDAwms7X3EyxmfJk_I"
        navigationController?.setViewControllerTitle(to: "Fav")
        viewModel.getFavoritesList()
    }
    
    // Public Methods
    class func create() -> FavoritesVC {
        let favoritesVC: FavoritesVC = UIViewController.create(storyboardName: Storyboards.favorites, identifier: ViewControllers.favoritesVC)
        let viewModel = FavoritesVM(view: favoritesVC)
        favoritesVC.viewModel = viewModel
        return favoritesVC
    }
}

extension FavoritesVC: FavoritesVCProtocol {
    func reloadTableview(){
        favoritesView.favoritesTableView.reloadData()
    }
    
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFavoritesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.favorites, for: indexPath) as! FavoritesCell
        cell.setupData(cellData: viewModel.getCellData(indexPath: indexPath))
        cell.delgate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getDoctorImage(indexPath: indexPath)
    }
    
    internal func setCellImage(image: Data, indexPath: IndexPath) {
        guard let cell = favoritesView.favoritesTableView.cellForRow(at: indexPath) as? FavoritesCell else { return }
        cell.setdoctorImage(image: image)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        print("offsetY: \(offsetY)")
        print("contentHeight: \(contentHeight)")
        print("height: \(height)")

    }
    
}
extension FavoritesVC: FavoritesCellDelgate{
    
    @objc func deleteFavorite(doctorID : Int) {
        self.presentAlertOnMainThread()
    }
    
    @objc func viewDoctorProfile(doctorID: Int) {
        self.presentAlertOnMainThread()
    }
    
    
}
