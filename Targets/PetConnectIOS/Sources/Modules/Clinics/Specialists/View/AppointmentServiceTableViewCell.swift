//
//  AppointmentServiceTableViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit
import SnapKit

protocol AppointmentServiceTableViewCellDelegate: AnyObject {
    func buttonPressed()
}

class AppointmentServiceTableViewCell: UITableViewCell {
    
    weak var delegate: AppointmentServiceTableViewCellDelegate?
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name nameLable: String) {
        title.text = nameLable
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
}





