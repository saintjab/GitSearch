//
//  DetailViewController.swift
//  GitSearch
//
//  Created by Jonas Boateng on 30/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    var progressIndc: UIActivityIndicatorView?
    var repo = [Repository]()
    var dateFor: DateFormatter = DateFormatter()
    var fullName: String?
    var language: String?
    var desc: String?
    var created: String?
    var repoID: String?
    var htmlURL: String?
    var issues: String?
    var watchers: String?
    var forks: String?
    var imageURL: String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createdLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descLabel: UILabel?
    @IBOutlet weak var langLabel: UILabel?
    @IBOutlet weak var watchersLabel: UILabel?
    @IBOutlet weak var forksLabel: UILabel?
    @IBOutlet weak var issuesLabel: UILabel?
    @IBOutlet weak var readmeButton: UIButton?
    @IBOutlet weak var avatar: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detailed"
        //https://api.github.com/repositories/{rep_id} - repo search using repo id
        //{html_url}/blob/master/README.md -- repo readMe
        
        progressIndc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, placeInTheCenterOf: self.view)
        progressIndc?.startAnimating()
        
        self.loadRepo()
    }
    
    func loadRepo(){
        self.nameLabel?.text = self.fullName;
        self.descLabel?.text = self.desc;
        self.createdLabel?.text = self.created;
        self.langLabel?.text = self.language;
        self.issuesLabel?.text = self.issues;
        self.watchersLabel?.text = self.watchers;
        self.forksLabel?.text = self.forks;
        
        let url = URL(string: self.imageURL!)
        let placeholderImage = UIImage(named: "github.png")!
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: (self.avatar?.frame.size)!,
            radius: 10.0
        )
        avatar?.af_setImage(
            withURL: url!,
            placeholderImage: placeholderImage,
            filter: filter,
            imageTransition: .crossDissolve(0.2)
        )
        progressIndc?.stopAnimating();
    }
    
    @IBAction func viewReadMe(_ sender: Any) {
        if self.htmlURL == "NA"{
            let alertView = UIAlertController(title: "Sorry", message: "No ReadMe for this Repo", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
        }
        else{
            //{html_url}/blob/master/README.md -- repo readMe
            
            let url = NSURL(string:htmlURL!+"/blob/master/README.md")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let readController = storyBoard.instantiateViewController(withIdentifier: "readView") as! ReadMeViewController
            
            readController.readmeUrl = url;
            self.navigationController?.pushViewController(readController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
