//
//  CustomHeaderLabel.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 14/8/21.
//

import UIKit

class CustomHeaderLabel: UILabel {

    //set sizeOfFont depend on ipad or iphone
    let sizeOfFont: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 80.0 : 40.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setup()
        super.layoutSubviews()
    }
    
    func setup(){
        
        self.font    =  UIFont(name: "Avenir-Black", size: sizeOfFont)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        
    }
    

}
