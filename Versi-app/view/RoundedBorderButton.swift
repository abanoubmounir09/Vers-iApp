//
//  RoundedBorderButton.swift
//  Versi-app
//
//  Created by pop on 4/18/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit

class RoundedBorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 5
        layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
