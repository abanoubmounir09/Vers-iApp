//
//  Repo.swift
//  Versi-app
//
//  Created by pop on 4/21/20.
//  Copyright © 2020 pop. All rights reserved.
//

import UIKit

class Repo{
    public private(set)var image:UIImage
    public private(set)var name:String
    public private(set)var description:String
    public private(set)var numberOfForks:Int
    public private(set)var languages:String
    public private(set)var numberOfContributors:Int
    public private(set)var repoUrl:String
    
init(image:UIImage,name:String,description:String,numberOfForks:Int,languages:String,numberOfContributors:Int,repoUrl:String){
        self.image = image
        self.name = name
        self.description = description
        self.numberOfForks = numberOfForks
        self.languages = languages
        self.numberOfContributors = numberOfContributors
        self.repoUrl = repoUrl
    }
    
}
