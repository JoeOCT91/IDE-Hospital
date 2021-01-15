//
//  AlertVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 17/12/2020.
//

import UIKit

@objc protocol AlertVcDelegate: class {
    func okButtonPressed()
}

enum AlertType {
    case withSuccess
    case withFaliure
}

class AlertVC: UIViewController {
    
    private let containerView = UIView()
    private var alertImage = UIImageView(image: Asset.alertError.image)
    private let messageLabel = HospitalCellLabel(textAlignment: .right, fontSize: 15, font: UIFont(font : FontFamily.PTSans.bold, size: 15))
    private let actionButton = HospitalButton(frame: .zero, tittle: "OK", color: ColorName.darkRoyalBlue)
    private var alertType: AlertType!
    weak var alertDelegate: AlertVcDelegate?
    
    init(message: String = "Default message", alertType:AlertType = .withFaliure) {
        
        super.init(nibName: nil, bundle: nil)
        messageLabel.text = message
        self.alertType = alertType
        
        switch alertType {
        case .withSuccess:
            alertImage = UIImageView(image: Asset.alertConfirmation.image)
        default:
            alertImage = UIImageView(image: Asset.alertError.image)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configreContainerView()
        configureAlertImage()
        configureMessageLabel()
        configureActionButton()
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.addSubview(containerView)
    }
    
    private func configreContainerView() {
        containerView.addSubview(alertImage)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let containerWidth: CGFloat = screenWidth * 0.85
        
        containerView.layer.borderWidth = 0
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: containerWidth)
        ])
    }
    
    private func configureAlertImage(){
        alertImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            alertImage.bottomAnchor.constraint(equalTo: messageLabel.topAnchor),
            alertImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func configureMessageLabel(){
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor(named: ColorName.darkRoyalBlue)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10)
        ])
    }
    
    private func configureActionButton(){
        actionButton.titleLabel?.font = actionButton.titleLabel?.font.withSize(15)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 55),
            actionButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    @objc private func dismissAlert(){
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.alertDelegate?.okButtonPressed()
        }
    }
}
