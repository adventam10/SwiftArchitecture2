//
//  UIViewController+showPopover.swift
//  SwiftArchitecture
//
//  Created by am10 on 2019/01/03.
//  Copyright © 2019年 am10. All rights reserved.
//

import UIKit

extension UIViewController {
    func showPopover(viewController: UIViewController,
                     sourceView: UIView,
                     direction: UIPopoverArrowDirection,
                     delegate: UIPopoverPresentationControllerDelegate?) {
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = viewController.view.frame.size
        
        let presentationController = viewController.popoverPresentationController
        presentationController?.delegate = delegate
        presentationController?.permittedArrowDirections = direction
        presentationController?.sourceView = sourceView
        presentationController?.sourceRect = sourceView.bounds
        
        present(viewController, animated: true, completion: nil)
    }
    
    func showPopover(viewController: UIViewController,
                     sourceView: UIView,
                     viewSize: CGSize,
                     direction: UIPopoverArrowDirection,
                     delegate: UIPopoverPresentationControllerDelegate?) {
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = viewSize
        
        let presentationController = viewController.popoverPresentationController
        presentationController?.delegate = delegate
        presentationController?.permittedArrowDirections = direction
        presentationController?.sourceView = sourceView
        presentationController?.sourceRect = sourceView.bounds
        
        present(viewController, animated: true, completion: nil)
    }
}
