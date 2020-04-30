//
//  Downloadservices.swift
//  Versi-app
//
//  Created by pop on 4/21/20.
//  Copyright © 2020 pop. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Downloadservice{
    static let instance = Downloadservice()
    
    func downloadRepoDictionaryArray(completion : @escaping (_ repoDict : [Dictionary<String,Any>])->()){
        var trendingReposArray = [Dictionary<String, Any>]()
        Alamofire.request(TrendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else{fatalError("print error in json ")}
            guard let repoDictArray = json["items"] as? [Dictionary<String, Any>]else{return}
            for repo in repoDictArray{
                if trendingReposArray.count <= 3{
                    guard let name = repo["name"] as? String,
                        let description = repo["description"] as? String,
                        let forks_count = repo["forks_count"] as? Int,
                        let language = repo["language"] as? String,// null
                        let repoUrl = repo["html_url"] as? String,
                    let contributorUrl = repo["contributors_url"] as? String,
                        let owner = repo["owner"] as? Dictionary<String, Any>,
                        let avataUrl = owner["avatar_url"] as? String else{
                            continue
                    }
                        let repoDict:Dictionary<String, Any> = ["name":name,"description":description,"forks_count":forks_count,"language":language,"repoUrl":repoUrl,"contributorUrl":contributorUrl,"avataUrl":avataUrl]
                        trendingReposArray.append(repoDict)
                }else{
                    break
                }
            }
             completion(trendingReposArray)
        }
    }
    
    
    func downladTrendRepos(completion : @escaping(_ repoArr : [Repo])-> ()){
        var repoArray = [Repo]()
        downloadRepoDictionaryArray { (repoDictArr) in
            for dict in repoDictArr{
                self.downladTrendRepoOne(repoDict: dict, completion: { (returndRepo) in
                    if repoArray.count < 3 {
                        repoArray.append(returndRepo)
                    }else{
                        let sortedArray = repoArray.sorted(by: { (repoA, repoB) -> Bool in
                            if repoA.numberOfForks > repoB.numberOfForks{
                                return true
                            }else{
                                return false
                            }
                        })
                        completion(sortedArray)
                    }
                })
            }
        }
    }
    
    func downladTrendRepoOne(repoDict dict:Dictionary<String, Any>, completion:@escaping(_ repo:Repo)->()){
        guard let avataUrl = dict["avataUrl"] as? String else{fatalError("coulnot find avatar url")}
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let forks_count = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let Contrib_url = dict["contributorUrl"] as! String
        let repoUrl = dict["repoUrl"] as! String
        DownloadImage(avatar_url: avataUrl) { (returnedImag) in
            self.DownloadContributorCount(contributor_url: Contrib_url, completion: { (returnedCount) in
                  let repo = Repo(image:returnedImag , name: name, description: description, numberOfForks: forks_count, languages:language, numberOfContributors: returnedCount, repoUrl: repoUrl)
                 completion(repo)
            })
        }
    }
    
    func DownloadImage(avatar_url:String,completion:@escaping (_ image:UIImage)->() ){
        Alamofire.request(avatar_url).responseImage { (Imgresponse) in
            guard let image = Imgresponse.result.value else{return}
            completion(image)
        }
    }
    
    func DownloadContributorCount(contributor_url : String,completion:@escaping(_ count:Int)->()){
        Alamofire.request(contributor_url).responseJSON { (response) in
            guard let json = response.result.value as? [Dictionary<String, Any>] else{return}
            if !json.isEmpty{
                let contrib_count = json.count
                completion(contrib_count)
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
