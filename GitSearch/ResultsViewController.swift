//
//  ResultsViewController.swift
//  GitSearch
//
//  Created by Jonas Boateng on 30/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class RepoTableViewCell : UITableViewCell {
    @IBOutlet weak var createdLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descLabel: UILabel?
    @IBOutlet weak var langLabel: UILabel?
    @IBOutlet weak var avatar: UIImageView?
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var placeImg: UIImage?
    var url : URL?
    var repo = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "repoCell")
        self.title = "Top Results"
        placeImg = UIImage(named:"github.png")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RepoTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "repoCell") as! RepoTableViewCell
        
        cell.nameLabel?.text = self.repo[indexPath.row].fullName
        cell.descLabel?.text = self.repo[indexPath.row].repDescription
        cell.createdLabel?.text = self.repo[indexPath.row].created
        cell.langLabel?.text = self.repo[indexPath.row].language
        url = URL(string: self.repo[indexPath.row].imageURL!)
        cell.avatar?.af_setImage(withURL: url!, placeholderImage: placeImg)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailController = storyBoard.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        
        detailController.fullName = self.repo[indexPath.row].fullName;
        detailController.desc = self.repo[indexPath.row].repDescription;
        detailController.created = self.repo[indexPath.row].created;
        detailController.language = self.repo[indexPath.row].language;
        
        detailController.repoID = self.repo[indexPath.row].repoID;
        detailController.htmlURL = self.repo[indexPath.row].htmlURL;
        detailController.issues = self.repo[indexPath.row].issues;
        detailController.watchers = self.repo[indexPath.row].watchers;
        detailController.forks = self.repo[indexPath.row].forks;
        detailController.imageURL = self.repo[indexPath.row].imageURL;
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
