//
//  SearchVC.swift
//  Versi-app
//
//  Created by pop on 4/18/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchVC: UIViewController,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var mytableview: UITableView!
    @IBOutlet weak var searchField: RoundBorderTextField!
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BindElements()
        mytableview.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    
    func BindElements(){
        let SearchResultOnservable = searchField.rx.text
            .orEmpty
            .debounce(0.5,scheduler: MainScheduler.instance)
            .map{
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }.flatMap { (query) -> Observable<[Repo]> in
                if query == ""{
                    return Observable<[Repo]>.just([])
                }else{
                    let query = SearchUrl + query + startDesc
                    var searchRepoArray = [Repo]()
                    return URLSession.shared.rx.json(url: URL(string: query)!).map{
                        let results = $0 as? AnyObject
                        let items = results?.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                        for item in items{
                            guard let name = item["name"] as? String,
                                let description = item["description"] as? String,
                                let forks_count = item["forks_count"] as? Int,
                                let language = item["language"] as? String,
                                let repoUrl = item["html_url"] as? String else{
                                    continue
                            }
                            let repo = Repo(image: UIImage(named: "demo")!, name: name, description: description, numberOfForks: forks_count, languages: language, numberOfContributors: 0, repoUrl: repoUrl)
                            searchRepoArray.append(repo)
                        }
                        return searchRepoArray
                    }
                }
        }.observeOn(MainScheduler.instance)
        SearchResultOnservable.bind(to: mytableview.rx.items(cellIdentifier: "SearchCell")){(row,repo:Repo,cell:SearchCell) in
            cell.configureCell(repo: repo)
        }.addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mytableview.cellForRow(at: indexPath) as? SearchCell
        let url = cell?.repoUrl
        presentSafariVC(url: url!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

}
