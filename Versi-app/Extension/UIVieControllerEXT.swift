//
//  UIVieControllerEXT.swift
//  Versi-app
//
//  Created by pop on 4/25/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentSafariVC(url:String){
        let ReadMEurl = URL(string:url + ReadMeSegment)
        let safarivc = SFSafariViewController(url: ReadMEurl!)
        present(safarivc, animated: true, completion: nil)
    }
}
