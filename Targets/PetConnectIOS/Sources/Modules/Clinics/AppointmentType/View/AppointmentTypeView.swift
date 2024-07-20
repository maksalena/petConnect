//
//  AppointmentTypeView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit
import SnapKit

class AppointmentTypeView: UIView {
    
    // MARK: - Arrows Images
    
    var title: [String] = ["Выбрать врача", "Выбрать специализацию"]
    var type: [String] = ["medicalWorker", "tool"]
    
    lazy var appointmentTypeTableView: UITableView = {
        let table = UITableView()
        table.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "AppointmentTypeCell")
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
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AppointmentTypeView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        AppointmentTypeView().showPreview()
    }
}
#endif
