//
//  UIViewController+showProgress.swift
//  SwiftArchitecture2
//
//  Created by makoto on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func showProgress() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
}
