//
//  TabBarVC.swift
//  TabBarVC
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let VCs = [UINavigationController(rootViewController: ViewController1.shared), UINavigationController(rootViewController: ViewController2.shared)]
        
        let tabBarItem1 = UITabBarItem.init(title: "11", image: nil, selectedImage: nil)
        let tabBarItem2 = UITabBarItem.init(title: "22", image: nil, selectedImage: nil)
        
        VCs[0].tabBarItem = tabBarItem1
        VCs[1].tabBarItem = tabBarItem2
        
        self.setViewControllers(VCs, animated: true)
    
    }


}
