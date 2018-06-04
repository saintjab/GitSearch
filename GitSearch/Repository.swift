//
//  Repository.swift
//  GitSearch
//
//  Created by Jonas Boateng on 30/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import UIKit

class Repository: NSObject {
    var fullName: String
    var repDescription: String?
    var language: String?
    var created: String
    var repoID: String
    var htmlURL: String
    var issues: String
    var watchers: String
    var forks: String
    var imageURL: String?
    
    init(fullName: String, repDescription: String, language:String, created: String, repoID:String, htmlURL:String, issues:String,                                                         watchers:String, forks:String, imageURL:String) {
        self.fullName = fullName
        self.repDescription = repDescription
        self.language = language
        self.created = created
        self.repoID = repoID;
        self.htmlURL = htmlURL;
        self.forks = forks;
        self.issues = issues;
        self.watchers = watchers;
        self.imageURL = imageURL;
    }
}
