//
//  CustomTableCell.swift
//  Versi-app
//
//  Created by pop on 4/21/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomTableCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var headerTXTF: UILabel!
    @IBOutlet weak var descriptionTXTF: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var txticon1: UILabel!
    @IBOutlet weak var txticon2: UILabel!
    @IBOutlet weak var txticon3: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ReadMeButton: RoundedBorderButton!
    
    public private(set) var repoUrl:String?
    
    override func layoutSubviews() {
        backView!.layer.cornerRadius = 15
        backView?.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func configureCell(repo:Repo){
        myimage.image = repo.image
        headerTXTF.text = repo.name
        descriptionTXTF.text = repo.description
        txticon1.text = String(describing: repo.numberOfForks)
        txticon2.text = repo.languages
        txticon3.text = String(describing: repo.numberOfContributors)
        repoUrl = repo.repoUrl
        ReadMeButton.rx.tap.subscribe(onNext:{
            self.window?.rootViewController?.presentSafariVC(url: self.repoUrl!)
        }).disposed(by: disposeBag)
        
    }
}
