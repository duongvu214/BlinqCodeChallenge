//
//  ViewController.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 13/8/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - add variable
    var requestButton = RoundedButton()
    var titleLabel = CustomHeaderLabel()
    var middleLabel = UILabel()
    
    let spacingStack: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 100.0 : 50.0
    let sizeMiddleLabel: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 60.0 : 30.0
    
    // MARK: - add essential functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        configureTitleLabel()
        configureMiddleLabel()

    }
    
    // Check if email registered or not and change request button and middle label
    fileprivate func refreshViewState() {
        let userDefault = UserDefaultsItems()
        if userDefault.emailRegistered.isEmpty {
            requestButton.setTitle("Request an invitation", for: .normal)
            middleLabel.text    =  "You don't have an invitation from Broccoli & Co. You can request one now."
        } else {
            requestButton.setTitle("Cancel invite", for: .normal)
            middleLabel.text    =  "You already had an invitation from Broccoli & Co."
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshViewState()
    }
    
    // MARK: - configure Button and change action when tap depend on email registered
    
    fileprivate func configureButton() {
        view.addSubview(requestButton)
        requestButton.addTarget(self, action: #selector(handleInvitation), for: .touchUpInside)
        setButtonConstraints()
    }
    
    func setButtonConstraints() {
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        requestButton.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        requestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive  = true
        requestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        requestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }
    
    @objc func handleInvitation(sender: UIButton!) {
        let userDefault = UserDefaultsItems()
        if userDefault.emailRegistered.isEmpty {
            requestInvitation()
        } else {
            cancelInvitation()
        }

    }
    
    fileprivate func cancelInvitation() {
        print("cancelInvitation")
        
        //Displaying alert with multiple actions and custom font ans size
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)

        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 18.0)!]
        let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 16.0)!]

        let titleAttrString = NSMutableAttributedString(string:  "Are you sure?", attributes: titleFont)
        let msgAttrString = NSMutableAttributedString(string: "If you cancel the invite, you can not access Broccoli & Co service.", attributes: msgFont)

        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(msgAttrString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            DispatchQueue.main.async {
                // delete email registered in userDefault
                var userDefault = UserDefaultsItems()
                userDefault.emailRegistered = ""
                
                // show congratulationView with cancel text
                let vc = CongratulationViewController()
                vc.titleLabel.text = "You successfull canceled invite"
                // check if congratulationView is dimissed to refresh state in Home View
                vc.isDismissed = { [weak self] in
                    print("------cancelInvitation")
                    self?.refreshViewState()
                }
                self.present(vc, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        

    }
    
    fileprivate func requestInvitation() {
        print("requestInvitation")
        let vc = RequestViewController()
        // check if RequestView is dimissed to refresh state in Home View
        vc.isDismissed = { [weak self] in
            print("------requestInvitation")
            self?.refreshViewState()
        }
        self.present(vc, animated: true, completion: nil)
    }

    
    // MARK: - configure Middle Label
    func configureMiddleLabel() {
        view.addSubview(middleLabel)
        
        middleLabel.font    =  UIFont(name: "Avenir-Book", size: sizeMiddleLabel)
        middleLabel.textAlignment = .center
        middleLabel.numberOfLines = 0
        middleLabel.adjustsFontSizeToFitWidth = true
        
        setMiddleLabelConstraints()
    }
    
    func setMiddleLabelConstraints() {
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        middleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        middleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive  = true
        middleLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        middleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive  = true
        middleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive  = true
        middleLabel.bottomAnchor.constraint(lessThanOrEqualTo: requestButton.safeAreaLayoutGuide.topAnchor, constant: -20).isActive  = true
    }
    
    // MARK: - configure Title Label
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text    =  "Broccoli & Co."
        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive  = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }
    
}

