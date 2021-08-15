//
//  underlineTextField.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 13/8/21.
//

import UIKit
import TKFormTextField

class CustomTextField: TKFormTextField {
    
    //set sizeOfFont depend on ipad or iphone
    let sizeOfFont: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 22.0 : 16.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setupTextField()
        super.layoutSubviews()
    }
    
    func setupTextField() {
        self.enablesReturnKeyAutomatically = true
        self.returnKeyType = .next
        self.clearButtonMode = .whileEditing
        self.placeholderFont = UIFont(name: "Avenir-Book", size: sizeOfFont)
        self.font = UIFont(name: "Avenir-Book", size: sizeOfFont)


        // TKFormTextField properties: floating placeholder title
        self.titleLabel.font = UIFont(name: "Avenir-Book", size: sizeOfFont)

        self.titleColor = UIColor.lightGray
        self.selectedTitleColor = UIColor.gray
        // TKFormTextField properties: underline
        self.lineColor = UIColor.gray
        self.selectedLineColor = UIColor.black
        
        // TKFormTextField properties: bottom error label
        self.errorLabel.font = UIFont(name: "Avenir-Book", size: sizeOfFont)
        self.errorColor = UIColor.red // this color is also used for the underline on error state
    }

}
