//
//  UIViewController+showProgress.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    func showProgress() {
        HUD.show(.progress)
    }
    
    func hideProgress() {
        HUD.hide()
    }
}
