//
//  ViewController2.swift
//  TabBarVC
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    static let shared = ViewController2()
    
    let btn = UIButton.init(frame: CGRect.init(x: 50, y: 100, width: 60, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        view.addSubview(btn)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnTapped), for: UIControl.Event.touchUpInside)
    }

    @objc func btnTapped() {
        let vc = subVc2()
        navigationController?.pushViewController(vc, animated: true)
    }
}
