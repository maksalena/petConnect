//
//  AppointmentTableViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit
import SnapKit

protocol AppointmentTableViewCellDelegate: AnyObject {
    func buttonPressed()
}

class AppointmentTableViewCell: UITableViewCell {
    
    weak var delegate: AppointmentTableViewCellDelegate?
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "test"
        
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .add
        
        return image
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        
        addSubview(image)
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name nameLable: String, type typeLable: String) {
        title.text = nameLable
        image.image = UIImage(named: typeLable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(6)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
}

#if DEBUG
import SwiftUI
#Preview(body: {
    AppointmentTableViewCell().showPreview()
})
#endif




