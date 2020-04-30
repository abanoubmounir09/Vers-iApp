//
//  SearchCell.swift
//  Versi-app
//
//  Created by pop on 4/23/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescrition: UILabel!
    @IBOutlet weak var forksCountLB: UILabel!
    @IBOutlet weak var languageLB: UILabel!
    @IBOutlet weak var backView: UIView!
    
    public private(set) var repoUrl:String?
    func configureCell(repo:Repo){
        repoName.text = repo.name
        repoDescrition.text = repo.description
        forksCountLB.text = String(repo.numberOfForks)
        languageLB.text = repo.languages
        repoUrl = repo.repoUrl
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }



}
