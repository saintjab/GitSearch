//
//  SearchViewController.swift
//  GitSearch
//
//  Created by Jonas Boateng on 29/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    //let progressIndc = UIActivityIndicatorView()
    var progressIndc: UIActivityIndicatorView?
    
    var searchTerm: String?
    var repo = [Repository]()
    var dateFor: DateFormatter = DateFormatter()
    var fullName: String?
    var language: String?
    var desc: String?
    var stringToDate: NSDate?
    var created: String?
    var repoID: String?
    var htmlURL: String?
    var issues: String?
    var watchers: String?
    var forks: String?
    var imageURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"
        
        progressIndc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, placeInTheCenterOf: self.view)
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDate(dateString:NSString) -> NSDate{
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: dateString as String)
        return date! as NSDate;
    }
    
    func cleanUp(){
        self.searchField.isEnabled = true
        self.searchField.text = ""
        self.btnSearch.isEnabled = true
        self.btnSearch.setTitle("Search",for: .normal)
        self.progressIndc?.stopAnimating()
    }
    
    func search() {
        Alamofire.request("https://api.github.com/search/repositories?q="+searchTerm!+"&sort=stars&order=desc").validate().responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    //print("JSON: \(json)")
                    let jsonX = JSON(json)
                    
                    if let items = jsonX["items"].array {
                        for item in items {
                            if let repoFull = item["full_name"].string{
                                self.fullName = repoFull
                            }
                            else {
                                self.fullName = "NO Name for Repo"
                            }
                            
                            if let repoLingual = item["language"].string{
                                self.language = "Written in: "+repoLingual
                            }
                            else {
                                self.language = "NA"
                            }
                            
                            if let repoDesc = item["description"].string{
                                self.desc = repoDesc
                            }
                            else {
                                self.desc = "NO Description for Repo"
                            }
                            
                            if let repoDate = item["created_at"].string{
                                self.stringToDate = self.getDate(dateString: repoDate as NSString)
                                self.created = self.dateFor.string(from: self.stringToDate! as Date)
                            }
                            else {
                                self.created = "NO Date"
                            }
                            
                            if let repoURL = item["html_url"].string{
                                self.htmlURL = repoURL
                            }
                            else {
                                self.htmlURL = "NA"
                            }
                            
                            if let imgURL = item["owner"]["avatar_url"].string{
                                self.imageURL = imgURL
                            }
                            else {
                                self.imageURL = "NA"
                            }
                            
                            self.issues = item["open_issues_count"].stringValue
                            self.forks = item["forks_count"].stringValue
                            self.watchers = item["watchers_count"].stringValue
                            self.repoID = item["id"].stringValue
                            
                            //populate my model
                            let rep = Repository(fullName: self.fullName!, repDescription: self.desc!, language:self.language!, created: self.created!, repoID:self.repoID!, htmlURL:self.htmlURL!, issues:self.issues!,                                                         watchers:self.watchers!, forks:self.forks!, imageURL:self.imageURL!)
                            self.repo.append(rep)
                        }
                    }
                    self.cleanUp()
                    if (self.repo.count > 0){
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let repoController = storyBoard.instantiateViewController(withIdentifier: "repoView") as! ResultsViewController
                        repoController.repo = self.repo;
                        self.navigationController?.pushViewController(repoController, animated: true)
                    }
                    else{
                        let alertView = UIAlertController(title: "Sorry", message:"No repository was found for your search term", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertView, animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                print(error)
                let alertView = UIAlertController(title: "Sorry, error", message: error.localizedDescription, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
                self.cleanUp()
            }
        }
    }
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBAction func search(_ sender: Any) {
        if (searchField.text!.isEmpty){
            let alertView = UIAlertController(title: "Sorry", message: "You need to type a word to search", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
        }
        else{
            searchTerm = searchField.text
            searchField.isEnabled = false
            btnSearch.isEnabled = false
            btnSearch.setTitle("Please wait..",for: .normal)
            self.view.addSubview(progressIndc!)
            progressIndc?.startAnimating()
            
            dateFor.dateFormat = "dd-MM-yyyy"
            
            //I needed to clear the model so I can start on a clean slate when I use the back key
            if (repo.count > 0){
                repo.removeObjectsInArray(array: repo)
            }
            
            self.search();
        }
    }
}

