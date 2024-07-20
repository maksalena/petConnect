//
//  NavBarWithBackButton.swift
//  PetConnect
//
//  Created by SHREDDING on 28.08.2023.
//

import Foundation
import UIKit

//protocol PrimaryNavBarViewDelegate: AnyObject {
//    
//    /// Open user profile
//    func openUserProfile()
//}

final class NavBarWithBackButton: UIView {
    
    var titleString:String?
    var notConnection:String = "Соединение..."
    var updating:String = "Обновление..."
    
    private lazy var title: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: "on-surface")
        element.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    public lazy var backButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(avatarPressed), for: .touchUpInside)
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 14
        
        element.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        element.tintColor = UIColor(named: "on-surface")
        return element
    }()
    
    public var navigationController:UINavigationController?
    
    /// Set up views
    /// - Parameter frame: view frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    /// Error handling
    /// - Parameter coder: NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Add subviews
    private func setViews() {
        backgroundColor = .clear
        
        addSubview(title)
        addSubview(backButton)
    }
    
    /// Add constraints to the view
    private func layoutViews() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
        ])
    }
    
    /// Trigger the delegate function
    @objc func avatarPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Configure Primary Tab Bar
    /// - Parameters:
    ///   - text: nav bar title
    ///   - image: nav bar image
    func configure(with text: String, _ navigationController: UINavigationController?) {
        title.text = text
        titleString = text
        self.navigationController = navigationController
    }
    
    func setNotConnection(){
        self.title.text = self.notConnection
    }
    
    func setUpdating(){
        self.title.text = self.updating
    }
    
    func setTitle(){
        self.title.text = self.titleString
    }
}
