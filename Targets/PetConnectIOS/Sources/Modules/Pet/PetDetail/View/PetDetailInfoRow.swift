//
//  PetDetailInfoRow.swift
//  PetConnect
//
//  Created by Егор Завражнов on 22.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import UIColorExtensions

final class PetDetailInfoRow:UIView{
    
    private lazy var HStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 13)
        
        label.text = "title:"
        label.textColor = UIColor(hexString: "6D7A75")
        return label
    }()
    
    lazy var value:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        
        label.text = "VALUE"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(HStack)
        HStack.addArrangedSubview(title)
        HStack.addArrangedSubview(value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        HStack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().labeled("HStack")
        }
        
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    PetDetailInfoRow().showPreview()
})
#endif
