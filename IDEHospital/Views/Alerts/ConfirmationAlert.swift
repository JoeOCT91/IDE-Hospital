//
//  ConfirmationAlert.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 20/12/2020.
//

import UIKit

@objc protocol ConfirmationAlertDelgate {
    func confirmPressed(id: Int)
}

class ConfirmationAlert: UIViewController {
    
    var delgate: ConfirmationAlertDelgate?
    
    private var Id: Int!
    private var message: String!
    
    private let containerView = UIView()
    
    private let messageLabel = HospitalCellLabel(textAlignment: .right, fontSize: 15, font: UIFont(font : FontFamily.PTSans.bold, size: 15))
    private let agreeButton = HospitalButton(frame: .zero, tittle: "Yes", color: ColorName.darkRoyalBlue)
    private let discardButton = HospitalButton(frame: .zero, tittle: "No", color: ColorName.richPurpleTwo)
    let buttonWidth = (UIScreen.main.bounds.width -  (40)) / 4
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(id: Int, message: String ){
        super.init(nibName: nil, bundle: nil)
        self.Id = id
        self.message = message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView()
        configreContainerView()
        configureMessageLabel()
        configureAgreeButton()
        ConfigureDiscardButton()
    }
    
    private func configreView(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.addSubview(containerView)
    }
    
    private func configreContainerView(){
        containerView.addSubview(messageLabel)
        containerView.addSubview(agreeButton)
        containerView.addSubview(discardButton)
        
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
    
    private func configureMessageLabel(){
        messageLabel.numberOfLines = 2
        messageLabel.minimumScaleFactor = 0.9
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor(named: ColorName.darkRoyalBlue)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
    private func  ConfigureDiscardButton(){
        
        discardButton.titleLabel?.font = discardButton.titleLabel?.font.withSize(15)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discardButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -20),
            discardButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            discardButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            discardButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: (buttonWidth / 2) + 10 )
            
        ])
        discardButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    private func configureAgreeButton() {
        
        agreeButton.titleLabel?.font = discardButton.titleLabel?.font.withSize(15)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            agreeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -20),
            agreeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            agreeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            agreeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -(buttonWidth / 2) - 10 )
        ])
        
        agreeButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
    }
    
    @objc private func dismissAlert(){
        self.dismiss(animated: true)
    }
    @objc private func confirmPressed(){
        delgate?.confirmPressed(id: Id)
        self.dismiss(animated: true)
    }
}
