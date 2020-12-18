//
//  AppointmentsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import UIKit

protocol AppointmentsVCProtocol: class {
    
}


class AppointmentsVC: UIViewController {
    
    @IBOutlet var appointmentsView: AppointmentsView!
    private var viewModel: AppointmentsVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.shared().token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMWE4OTQ3YTEwMTM0ODIyM2ZjZDYyYzg0OGFkZDdlMmZmYzhiMzllZDAwMjdiODU4MzE3M2RiMjA2YmM0MmYzMjUyMjQzYmNkNjQ2YzUwZmYiLCJpYXQiOjE2MDQ0OTMzNDMsIm5iZiI6MTYwNDQ5MzM0MywiZXhwIjoxNjM2MDI5MzQzLCJzdWIiOiI0NSIsInNjb3BlcyI6W119.iYhEyw4yRfd5UNhmzR9F2xzhIYZktHEKT_vKXaaiBgEGx1bQ-oyiEq0nC5dYrJGCirPK86J4MNg-yHidl1wpLEeRUE-YROerT5irXwJkEP9dWVsosIItvMdG0msv4w7G4m3wZVSpaVaaJk2y-6KqZ1BphmuDieNqx4xQqHW1Y8NAu3Dh09lMX6xzMKZwu8kB_MEzv7G10b8n5VwktV31eu8MrBDJhZmwriP2MVM8NVKIgbCdAq3o-xThbqmG479ViS1O3ijJ047ZjkkduZsQuh92NHhrkj2wj5UBpjlYEjLlcKwFvFJcQFA5A0B_ackIJLQktDfw9DGFLLOGEzoi2nVj8tINCG9TbI4-5Y-G8h8kMJCzxybNl1UA-LsMoonM3rY3smQdentBVyM53FYkAbgy9yqAl7Od6A-3D2baEZncCHHq2sZe8eUdS_X07qrOEj1Ip-pc5kLwzwD6vM5y8ptFG_sWmszJo1rNOV6ZoacKD0p_KZU21c9DPjei4VP5Y6y_tilEDxLKfK3wCD_80fmhKjAR5BVpRqHmlWnA1laGx0hGxthXHeg6-5URONR4h0Yiw-ZhzxehIrRmG6vDsofg9jeqSbO4WnTTysCd21xhK1gEvj67DgwwY4Tq_iaZDgRQvKzjRDJpGMysFOS6f4MfbQDAwms7X3EyxmfJk_I"
        navigationController?.setViewControllerTitle(to: "Fav")
        appointmentsView.setup()
        navigationController?.setViewControllerTitle(to: "Appointments")
        appointmentsView.setupTableView(delgate: self, dataSource: self)
        viewModel.getAppointments()
    }
    
    // Public Methods
    class func create() -> AppointmentsVC {
        let appointmentsVC: AppointmentsVC = UIViewController.create(storyboardName: Storyboards.appointments, identifier: ViewControllers.appointmentsVC)
        let viewModel = AppointmentsVM(view: appointmentsVC)
        appointmentsVC.viewModel = viewModel
        return appointmentsVC
    }


}

extension AppointmentsVC: AppointmentsVCProtocol {
    
}
extension AppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: Cells.appointment, for: indexPath) as! AppoinmentCell
        //cell.setupData(cellData: <#T##CellData#>)
        return cell
    }
    
    
}
