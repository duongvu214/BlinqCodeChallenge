//
//  CongratulationViewController.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 13/8/21.
//

import UIKit

class CongratulationViewController: UIViewController {
    
    // MARK: - add variable
    var timer: Timer?
    var timerCount: Int = 5
    var submitButton = RoundedButton()
    var titleLabel = CustomHeaderLabel()
    var isDismissed: (() -> Void)?
    
    // MARK: - add essential functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addConfettiView()
        configureButton()
        configureTitleLabel()
        // Do any additional setup after loading the view.
    }
    
    // run function when this view is dimissed
    override func viewWillDisappear(_ animated: Bool) {
        self.isDismissed?()
    }
    
    // MARK: - add confettiView
    
    fileprivate func addConfettiView() {
        let confettiView = SwiftConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        confettiView.intensity = 0.75
        confettiView.startConfetti()
    }

    // MARK: - configure Button
    fileprivate func configureButton() {
        submitButton.setTitle("Back to homepage in 5 seconds", for: .normal)
        view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        setButtonConstraints()
        
        //Count down time to auto dismiss view after 5 seconds
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDownTimer), userInfo: nil, repeats: true)
    }
    
    @objc func countDownTimer() {
        timerCount -= 1

        if timerCount <= 0 {
            timer?.invalidate()
            timer = nil
            //Dismiss all view to back to Home Page when time = 0
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        } else {
            //change button text with timercount
            let buttonText = "Back to homepage in \(timerCount) seconds"
            submitButton.setTitle(buttonText, for: .normal)
 
        }
    }
    
    //Dismiss all view to back to Home Page even time > 0
    @objc func closePage(sender: UIButton!) {
         print("Touch Button")
        timer?.invalidate()
        timer = nil
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        submitButton.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive  = true
        submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }
    
    // MARK: - configure Title Label
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive  = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive  = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
    }

}
