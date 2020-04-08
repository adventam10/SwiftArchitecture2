//
//  XibLoadView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public class XibLoadView: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    private func loadNib() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
