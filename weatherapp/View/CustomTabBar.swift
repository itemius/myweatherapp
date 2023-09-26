//
//  CustomTabBar.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import Foundation

import UIKit

class CustomTabBar: UITabBar {
    
    public var didTapButton: (() -> ())?
    
    public lazy var middleButton: UIButton! = {
        let middleButton = UIButton()
        
        middleButton.frame.size = CGSize(width: 80, height: 80)
        
        let image = UIImage(systemName: "plus")!
        middleButton.setImage(image, for: .normal)
        middleButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        middleButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        middleButton.tintColor = .white
        middleButton.layer.cornerRadius = 40
        
        middleButton.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
        
        self.addSubview(middleButton)
        
        return middleButton
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        middleButton.center = CGPoint(x: frame.width / 2, y: 16)
    }
    
    @objc func middleButtonAction(sender: UIButton) {
        didTapButton?()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        
        return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
    }
}
