//
//  EditProfileView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import UIKit

protocol EditProfileDelegate: class {
    func cancelPressed()
    func savePressed(edittedData: EditedData)
}

class EditProfileView: UIView {
    
    //Delegate
    weak var delegate: EditProfileDelegate?
    
    private let padding: CGFloat = 25
    private var userNameTextField = IDEAHopitalTextField()
    private var emailTextField = IDEAHopitalTextField()
    private var phoneNumberTextField = IDEAHopitalTextField()
    private var oldPassTextField = IDEAHopitalTextField()
    private var newPassTextField = IDEAHopitalTextField()
    private var confirmPassTextField = IDEAHopitalTextField()
    private var buttonContainer = UIView()
    private let cancelButton = HospitalButton()
    private let saveButton = HospitalButton()

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    //MARK:- Public Methods
    func setUserrData(userData: UserData){
        userNameTextField.text = userData.name
        phoneNumberTextField.text = userData.mobile
        emailTextField.text = userData.email
        oldPassTextField.text = ""
        newPassTextField.text = ""
        confirmPassTextField.text = ""
    }
    
    //MARK:- Private Methods
    private func setupViews(){
        //username
        userNameTextField = creatTextField()
        self.addSubview(userNameTextField)
        configureUserNameTextField()
        //email
        emailTextField = creatTextField()
        self.addSubview(emailTextField)
        configureEmailTextField()
        //phone number
        phoneNumberTextField = creatTextField()
        self.addSubview(phoneNumberTextField)
        configurePhoneNumberTextField()
        //old password
        oldPassTextField = creatTextField()
        self.addSubview(oldPassTextField)
        configureOldPassTextField()
        //new password
        newPassTextField = creatTextField()
        self.addSubview(newPassTextField)
        configureNewPassTextField()
        //confirm password
        confirmPassTextField = creatTextField()
        self.addSubview(confirmPassTextField)
        configureConfirmPassTextField()
        
        self.addSubview(buttonContainer)
        configureButtonContainer()
    }
    
    private func creatTextField() -> IDEAHopitalTextField{
        let textField = IDEAHopitalTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let bootomLine = createBottomLine()
        textField.addSubview(bootomLine)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 36),
            bootomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            bootomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            bootomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
        return textField
    }
    
    private func createBottomLine() -> UIView{
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.white
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: 2)
        ])
        return bottomLine
    }
    
    private func configureUserNameTextField() {
        let topConstant = UIScreen.main.bounds.height * 0.25
        userNameTextField.setup(leftImage: Asset.nameIcon.image, placeholder: L10n.nameTextFieldPlaceholder)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: topConstant),
            userNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            userNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.setup(leftImage: Asset.emailIcon.image, placeholder: L10n.emailTextFieldPlaceholder)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: padding),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configurePhoneNumberTextField() {
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.setup(leftImage: Asset.phoneIcon.image, placeholder: L10n.nameTextFieldPlaceholder)
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    private func configureOldPassTextField() {
        oldPassTextField.setup(leftImage: Asset.passwordIcon.image, placeholder: L10n.oldPassword)
        oldPassTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            oldPassTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: padding),
            oldPassTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            oldPassTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureNewPassTextField() {
        newPassTextField.setup(leftImage: Asset.passwordIcon.image, placeholder: L10n.newPassword)
        newPassTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            newPassTextField.topAnchor.constraint(equalTo: oldPassTextField.bottomAnchor, constant: padding),
            newPassTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            newPassTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureConfirmPassTextField() {
        confirmPassTextField.setup(leftImage: Asset.passwordIcon.image, placeholder: L10n.confirmPassword)
        confirmPassTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            confirmPassTextField.topAnchor.constraint(equalTo: newPassTextField.bottomAnchor, constant: padding),
            confirmPassTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            confirmPassTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
        ])
    }
    
    private func configureButtonContainer() {
        let PaddingConstatnt = UIScreen.main.bounds.width * 0.18
        let bottomPadding = UIScreen.main.bounds.width * 0.10
        
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PaddingConstatnt),
            buttonContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -PaddingConstatnt),
            buttonContainer.heightAnchor.constraint(equalToConstant: 25),
            buttonContainer.topAnchor.constraint(equalTo: confirmPassTextField.bottomAnchor, constant: bottomPadding)

            //buttonContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomPadding)
        ])
        
        buttonContainer.addSubview(saveButton)
        buttonContainer.addSubview(cancelButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: buttonContainer.centerXAnchor, constant: -18),
            cancelButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonContainer.centerXAnchor, constant: 18),
            cancelButton.heightAnchor.constraint(equalToConstant: 25),
            saveButton.heightAnchor.constraint(equalToConstant: 25)

        ])
        
        saveButton.setTitle(L10n.save, for: .normal)
        cancelButton.setTitle(L10n.cancel, for: .normal)
        cancelButton.backgroundColor = ColorName.richPurple.color
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    @objc private func savePressed(){
        let edditedData = EditedData(name: userNameTextField.text,
                                      email: emailTextField.text,
                                      mobile: phoneNumberTextField.text,
                                      oldPass: oldPassTextField.text,
                                      newPass: newPassTextField.text,
                                      confirmPass: confirmPassTextField.text)
        
        delegate?.savePressed(edittedData: edditedData)
    }
    
    @objc private func cancelPressed(){
        delegate?.cancelPressed()
    }
}
