//
//  ViewController.swift
//  Versi-app
//
//  Created by pop on 4/18/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage

class TrendingFeedVC: UIViewController{
  
    @IBOutlet weak var myTableView: UITableView!
    
    var dataSource = PublishSubject<[Repo]>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
       dataSource.bind(to: myTableView.rx.items(cellIdentifier: "CustomTableCell")){(row,repo:Repo,cell:CustomTableCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
    }

    func fetchData(){
        Downloadservice.instance.downladTrendRepos { (repoArr) in
            self.dataSource.onNext(repoArr)
           // print(repoArr[0].name,repoArr[0].description,repoArr[0].numberOfForks)
        }
    }
    
}

