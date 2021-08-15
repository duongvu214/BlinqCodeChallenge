//
//  RoundedButton.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 13/8/21.
//

import UIKit

class RoundedButton: UIButton {

    //set sizeOfFont depend on ipad or iphone
    let sizeOfFont: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40.0 : 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setupButton()
        super.layoutSubviews()
    }
    
    func setupButton(){
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        backgroundColor     = .red
        titleLabel?.font    = UIFont(name: "Avenir-Book", size: sizeOfFont)
        layer.cornerRadius  = 10
    }
    
}
