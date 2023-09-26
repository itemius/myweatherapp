//
//  CustomTabBarController.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        delegate = self
        
        let leftVC = self.storyboard?.instantiateViewController(withIdentifier: "weatherVC") as! CurrentWeatherViewController
        
        let rightVC = self.storyboard?.instantiateViewController(withIdentifier: "forecastVC") as! ForecastViewController
        
        let middleVC = self.storyboard?.instantiateViewController(withIdentifier: "cityVC") as! SelectCityViewController
        
        
        leftVC.tabBarItem = UITabBarItem(title: "Weather", image: nil, selectedImage: nil)
        
        rightVC.tabBarItem = UITabBarItem(title: "Forecast", image: nil, selectedImage: nil)
        
        middleVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16)], for: .normal)

        let viewControllers = [leftVC, middleVC, rightVC]
        self.setViewControllers(viewControllers, animated: false)
        
        
        guard let tabBar = self.tabBar as? CustomTabBar else { return }
        
        tabBar.didTapButton = { [unowned self] in
            self.selectCity()
        }
    }
    
    func selectCity() {
        let middleVC = self.storyboard?.instantiateViewController(withIdentifier: "cityVC") as! SelectCityViewController
        middleVC.modalPresentationCapturesStatusBarAppearance = true
        self.present(middleVC, animated: true, completion: nil)
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        if selectedIndex == 1 {
            return false
        }
        
        return true
    }
}
