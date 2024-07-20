//
//  BaseUIViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 10.09.2023.
//

import Foundation
import UIKit
import Network

class BaseUIViewController:UIViewController, PrimaryNavBarViewDelegate{

    var basePresenter:BaseUIViewPresenterProtocol!
    var baseTitle:String = ""
    
    enum NavBarType{
        case primary
        case withBackButton
        case none
    }
    
    var navBarType:NavBarType!
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       fatalError("required init?(coder: NSCoder) is not implemented")
    }
    
    init(navBar:NavBarType, title:String = "", backgroundColor:UIColor = .white, tintColor:UIColor = .clear) {
        super.init(nibName: nil, bundle: nil)
        self.basePresenter = BaseUIViewPresenter(view: self)
        
        self.navigationItem.title = nil
        self.baseTitle = title
        self.navBarType = navBar
        switch navBar {
        case .primary:
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.setUpCustomTitle(title: title))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.setUpUserProfilePhotoButton())
        case .withBackButton:
            self.navigationItem.hidesBackButton = false
            self.navigationItem.titleView = self.setUpCustomTitle(title: title)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.setUpBackButton(backgroundColor: backgroundColor))
        case .none:
            break
        }
        
        setUpMonitor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navBarType == .primary{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.setUpUserProfilePhotoButton())
        }
    }
        
    func setUpCustomTitle(title:String)->UILabel{
        let titleView = UILabel()
        titleView.text = title
        titleView.font = UIFont.SFProDisplay(weight: .bold, ofSize: 22)
        return titleView
    }
    
    func setUpUserProfilePhotoButton()->UIView{
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        customView.backgroundColor = .clear
        customView.layer.cornerRadius = 15
        customView.layer.masksToBounds = true
        // Create a custom image view or any other subviews within the custom view
        
        let userProfileButton = UIButton(type: .custom)
        
        if let imageData = self.basePresenter.getUserPhoto(){
            userProfileButton.setImage(UIImage(data: imageData)!, for: .normal)
        }else{
            userProfileButton.setImage(UIImage(resource: .avatar), for: .normal)
        }
        
        userProfileButton.setImage(UIImage(resource: .petDetail), for: .normal)
        userProfileButton.imageView?.contentMode = .scaleAspectFit
        userProfileButton.contentMode = .scaleAspectFit
        userProfileButton.frame = customView.bounds
        
        customView.addSubview(userProfileButton)
        
        userProfileButton.addAction(UIAction(handler: { _ in
            let profileVc = MainBuilder.createProfilePage()
            self.present(profileVc, animated: true)
        }), for: .touchUpInside)
        
        return customView
        
    }
    func setUpBackButton(backgroundColor:UIColor = .clear)->UIView{
        let customBackView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        customBackView.layer.cornerRadius = 22
        customBackView.layer.masksToBounds = true
        customBackView.backgroundColor = backgroundColor
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .darkGray
        backButton.backgroundColor = backgroundColor
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.frame = customBackView.frame
        customBackView.addSubview(backButton)
        
        backButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        return customBackView
    }
    
    public func setNewTitle(newTitle:String){
        switch self.navBarType {
        case .primary:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.setUpCustomTitle(title: newTitle))
        case .withBackButton:
            self.navigationItem.titleView = self.setUpCustomTitle(title: newTitle)
        case .none?:
            break
        default: break
        }
    }
    public func hideUserProfileButton(){
        self.navigationItem.rightBarButtonItem = nil
    }
        
    private func setUpMonitor(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.async {
//                    self.primaryNavBar?.setTitle()
//                    self.navBarWithBack?.setTitle()
                }
                
            } else {
                DispatchQueue.main.async {
//                    self.primaryNavBar?.setNotConnection()
//                    self.navBarWithBack?.setNotConnection()
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    func openUserProfile() {
        let vc = MainBuilder.createProfilePage()
        self.present(vc, animated: true)
    }
}

extension BaseUIViewController:BaseUIViewProtocol{
    
}

