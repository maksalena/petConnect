//
//  UIViewController + ext.swift
//  PetConnect
//
//  Created by Andrey on 13.08.2023.
//

import UIKit
import SwiftUI

extension UIViewController {
    
    /// Configure Primary Nav Bar
    /// - Parameters:
    ///   - text: nav bar title
    ///   - image: nav bar image
    func configurePrimaryNavBar(with text: String, image: UIImage?) -> PrimaryNavBarView{
        
        let navBar = PrimaryNavBarView()
        navBar.configure(with: text, image: image)
        
//        navigationController?.navigationBar.isHidden = true
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 64),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10)
        ])
        return navBar
    }
    
    func configureNavBarWithBackButton(with text:String, backgroundColor:UIColor = .white, tintColor:UIColor = .clear) -> NavBarWithBackButton {
        let navBar = NavBarWithBackButton()
        navBar.backgroundColor = backgroundColor
        navBar.backButton.backgroundColor = tintColor
        navBar.configure(with: text, self.navigationController)
        
//        navigationController?.navigationBar.isHidden = true
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        if backgroundColor == .clear && text.isEmpty{
            NSLayoutConstraint.activate([
                navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navBar.heightAnchor.constraint(equalToConstant: 64),
                navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
                navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.frame.width / 4)
            ])
        }else{
            NSLayoutConstraint.activate([
                navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navBar.heightAnchor.constraint(equalToConstant: 64),
                navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
                navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10)
            ])
        }

        return navBar
    }
}

extension UIViewController {
    // enable preview for UIKit
    // source: https://fluffy.es/xcode-previews-uikit/
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}
