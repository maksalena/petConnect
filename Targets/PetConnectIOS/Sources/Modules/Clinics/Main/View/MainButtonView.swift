//
//  MainButtonView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 01.02.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class MainButtonView: UIView {
    
    private lazy var imgageView: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "clinic")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Выбрать ветклинику"
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var chevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        
        return image
    }()
    
    public var image:UIImage?{
        didSet{
            self.imgageView.image = image
        }
    }
    
    public var title:String?{
        didSet{
            self.titleLabel.text = title
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = UIColor(named: "surface")
        addSubview(imgageView)
        addSubview(titleLabel)
        addSubview(chevron)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgageView.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        chevron.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing)
        }
    }

}

#if DEBUG
import SwiftUI
#Preview(body: {
    MainButtonView().showPreview()
})
#endif
