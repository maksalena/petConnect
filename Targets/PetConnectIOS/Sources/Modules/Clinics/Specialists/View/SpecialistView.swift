//
//  SpecialistView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit
import SnapKit

class SpecialistView: UIView {
    
    // MARK: - Arrows Images
    
    lazy var appointmentTypeTableView: UITableView = {
        let table = UITableView()
        table.register(AppointmentServiceTableViewCell.self, forCellReuseIdentifier: "AppointmentCell")
        table.backgroundColor = .clear
        
        return table
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(appointmentTypeTableView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        appointmentTypeTableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SpecialistView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        ServiceView().showPreview()
    }
}
#endif


