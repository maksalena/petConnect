//
//  CustomStart.swift
//  PetConnect
//
//  Created by SHREDDING on 27.10.2023.
//

import Foundation
import UIKit

class CustomStar: UIView {
    private let starLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStarLayer()
        setupGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStarLayer()
        setupGradientLayer()
    }
    
    private func setupStarLayer() {
        // Создаем путь для звезды,
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 50, y: 0))
        starPath.addLine(to: CGPoint(x: 61.8, y: 38.3))
        starPath.addLine(to: CGPoint(x: 100, y: 46.2))
        starPath.addLine(to: CGPoint(x: 75, y: 75))
        starPath.addLine(to: CGPoint(x: 85.5, y: 100))
        starPath.addLine(to: CGPoint(x: 50, y: 85))
        starPath.addLine(to: CGPoint(x: 14.5, y: 100))
        starPath.addLine(to: CGPoint(x: 25, y: 75))
        starPath.addLine(to: CGPoint(x: 0, y: 46.2))
        starPath.addLine(to: CGPoint(x: 38.2, y: 38.3))
        starPath.close()
        
        // Настроим CAShapeLayer с путем звезды
        starLayer.path = starPath.cgPath
        starLayer.lineWidth = 2.0
        starLayer.strokeColor = UIColor.yellow.cgColor
        starLayer.fillColor = UIColor.clear.cgColor
        
        // Добавим CAShapeLayer в слой UIView
        layer.addSublayer(starLayer)
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // Добавим градиентный слой как маску для CAShapeLayer
        starLayer.mask = gradientLayer
    }
    
    // Метод для установки процента заполнения от 0.0 до 1.0
    func setFillPercentage(_ percentage: CGFloat) {
        gradientLayer.locations = [NSNumber(value: 1.0 - percentage), NSNumber(value: 1.0)]
    }
}
