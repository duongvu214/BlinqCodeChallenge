//
//  RequestViewController.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 14/8/21.
//

import UIKit
import JGProgressHUD
import TKFormTextField

class RequestViewController: UIViewController {

    // MARK: - add variable
    var sendButton = RoundedButton()
    var titleLabel = CustomHeaderLabel()
    var stackView  = UIStackView()
    var nameTextField = CustomTextField()
    var emailTextField = CustomTextField()
    var confirmEmailTextField = CustomTextField()
    var isDismissed: (() -> Void)?
    
    // call variable link to APIManager
    var apiManager = APIManager()
    
    let hud = JGProgressHUD()
    
    // set spacing among elemtns in stack depend on iPhone/iPAd
    let spacingStack: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 80.0 : 20.0
    
    // MARK: - add essential functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // set delegate to receive data from APIManager
        apiManager.delegate = self
        
        configureButton()
        configureTextField()
        configureTitleLabel()
        configureStackView()

        hud.textLabel.font = UIDevice.current.userInterfaceIdiom == .pad ? UIFont(name: "Avenir-Book", size: 22.0) : UIFont(name: "Avenir-Book", size: 16.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.isDismissed?()
    }
    
    // MARK: - configure Send Button
    fileprivate func configureButton() {
        sendButton.setTitle("Send", for: .normal)
        view.addSubview(sendButton)
        
        sendButton.addTarget(self, action: #selector(submitData), for: .touchUpInside)
        setButtonConstraints()
    }
    
    @objc func submitData(sender: UIButton!) {
         print("Touch Button")
        let nameString = nameTextField.text!
        let emailString = emailTextField.text!
        let confirmEmailString = confirmEmailTextField.text!
        
        //check email, name and confirm email and send it to apiManager to get data from server
        if (emailString.isValidEmail) && (nameString.count > 2) && (emailString == confirmEmailString) {
            let waitString = "Sending your information..."
            self.hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
            self.hud.textLabel.text = waitString
            self.hud.show(in: self.view)
            // parse data to apiManager to submit to server and get result
            apiManager.getData(for: nameTextField.text!, email: emailString)
        } else {
            // check error depend on name, email, confirm and show text on hud error
            var errorString = "Please check and enter again."
            if nameString.count < 3 {
               errorString = "You must enter the name with at least 3 characters long. Please check and enter again!"
           } else if !emailString.isValidEmail {
                errorString = "Wrong Email Format. Please check and enter again!"
           } else if emailString != confirmEmailString {
                errorString = "The confirm email is not match with email. Please check and enter again!"
           }
            self.hud.textLabel.text = errorString
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 4.0)

        }

    }
    
    
    fileprivate func setButtonConstraints() {
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        sendButton.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive  = true
        sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }
    
    // MARK: - configure uitextfield
    
    fileprivate func configureTextField() {
        // Do any additional setup after loading the view.
        nameTextField.placeholder = "👤 Enter your full name"
        // TKFormTextField properties: update error message
        nameTextField.addTarget(self, action: #selector(checkNameError), for: .editingChanged)
        
        emailTextField.placeholder = "✉️ Enter your email"
        // TKFormTextField properties: update error message
        emailTextField.addTarget(self, action: #selector(checkMailError), for: .editingChanged)
        
        confirmEmailTextField.placeholder = "✉️ Confirm your email"
        // TKFormTextField properties: update error message
        confirmEmailTextField.addTarget(self, action: #selector(checkConfirmMailError), for: .editingChanged)

    }
    //check name error and show under name text field
    @objc func checkNameError(textField: TKFormTextField) {
        guard let text = textField.text, (text.count > 2) else {
        textField.error = "At least 3 characters" // to show error message in errorLabel
        return
      }
      textField.error = nil // to remove the error message
    }
    
    //check mail error and show under mail text field
    @objc func checkMailError(textField: TKFormTextField) {
        guard let text = textField.text, text.isValidEmail else {
        textField.error = "Email is invalid" // to show error message in errorLabel
        return
      }
      textField.error = nil // to remove the error message
    }
    
    //check confirm mail error and show under confirm mail text field
    @objc func checkConfirmMailError(textField: TKFormTextField) {
        guard let text = textField.text, text == emailTextField.text else {
        textField.error = "Confirm email is not match" // to show error message in errorLabel
        return
      }
      textField.error = nil // to remove the error message
    }
    
    // MARK: - configure Title Label
    
    fileprivate func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text    =  "Enter Your Information"
        setTitleLabelConstraints()
    }
    
    fileprivate func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
//        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive  = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }
    
    // MARK: - configure Stack View
    fileprivate func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = spacingStack
        
        addTextFieldToStackView()
        setStackViewConstraints()
    }
    
    // add 3 uitextfields to stack view to auto layout
    fileprivate func addTextFieldToStackView() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(confirmEmailTextField)
    }
    
    fileprivate func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // set height of Stack View > 220 and < 500
        stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 500).isActive = true
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220).isActive = true
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive  = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive  = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: sendButton.safeAreaLayoutGuide.topAnchor, constant: -10).isActive  = true
    }
    
}

//MARK: - APIManagerDelegate

extension RequestViewController: APIManagerDelegate {
    // if api request fail, show error on hub
    func didFailWithError(error: String) {
        DispatchQueue.main.async {
            print("error: \(error)")
            self.hud.textLabel.text = error
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.dismiss(afterDelay: 5.0)
        }

    }
    
    // if connect and register success, open congratulation view and save email to user default
    func didUpdateData(result: String) {
        DispatchQueue.main.async {
            self.hud.dismiss()
            print("result: \(result)")
            print("email: \(self.emailTextField.text!)")
            // save email to userdefault
            var userDefault = UserDefaultsItems()
            userDefault.emailRegistered = self.emailTextField.text!
            // present congratulation view
            let vc = CongratulationViewController()
            vc.titleLabel.text = "You are successfully registered"
            self.present(vc, animated: true, completion: nil)
        }
        
    }

}

//MARK: - check email input is valid or not 
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
