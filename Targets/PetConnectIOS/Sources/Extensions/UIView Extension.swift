//
//  UIView Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 18.08.2023.
//

import UIKit
import SwiftUI

extension UIView{
    
    /// set Opacity to view
    /// - Parameters:
    ///   - opacity: opacity value
    ///   - animated: is animate 
    func setOpacity(opacity:Float, animated:Bool){
        if animated{
            UIView.animate(withDuration: 0.3) {
                self.layer.opacity = opacity
            }
        }else{
            self.layer.opacity = opacity
        }
    }
}

extension UIView {
    public class func findByAccessibilityIdentifier(identifier: String) -> UIView? {
        
        guard let window = UIApplication.shared.keyWindow else {
            return nil
        }
        
        func findByID(view: UIView, _ id: String) -> UIView? {
            if view.accessibilityIdentifier == id { return view }
            for v in view.subviews {
                if let a = findByID(view: v, id) { return a }
            }
            return nil
        }
        
        return findByID(view: window, identifier)
    }
}

extension UIImageView {
    
    func makeRounded() {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}

extension UIView {
    /**
    Set x Position

    :param: x CGFloat
    */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
    Set y Position

    :param: y CGFloat
    */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
    Set Width

    :param: width CGFloat
    */
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
    Set Height

    :param: height CGFloat
    */
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

extension UIView {
    // enable preview for UIKit
    // source: https://dev.to/gualtierofr/preview-uikit-views-in-xcode-3543
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        // inject self (the current UIView) for the preview
        Preview(view: self)
    }
}


extension UIView {

  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
