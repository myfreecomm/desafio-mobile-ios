//
//  PullReqVC.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 23/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class PullReqVC: UITableViewController {
    
    private let cellId = "PullReqCell"
    private var pulls = [PullRequest]()
    var nextUrl = ""
    private var lastUrl = ""
    private var lastPageReached = false
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.isPagingEnabled = true
        
        let nib = UINib(nibName: "PullReqCellNib", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pulls.removeAll(keepingCapacity: true)
        loadData(url: nextUrl)
    }


    // MARK: - Table view pulls source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PullReqCell else{
            return PullReqCell()
        }
        if self.pulls.count > 0{
            let index = indexPath.row
            let pull = pulls[index]
            cell.titleLbl.text = pull.title
            cell.bodyTxt.text = pull.body
            if let avatarUrl = pull.user?.avatarUrl{
                cell.userPic.downloadedFrom(link: avatarUrl)
            }
            cell.userLbl.text = pull.user?.username
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pulls.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: pulls[indexPath.row].url!){
            //TODO: open url on browser
            UIApplication.shared.openURL(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pulls.count * 3/4{
            loadData(url: nextUrl)
        }
    }

    
    
    func loadData(url: String){
        if !lastPageReached{
            let URL = url
            print(URL)
            Alamofire.request(URL).responseArray { (response: DataResponse<[PullRequest]>) in
                
                switch response.result{
                case .success( _) : do {
                    if let value = response.result.value{
                        if value.isEmpty{
                            self.dismissEmptyPullReqList()
                            return
                        }
                    }
                    
                    if let headers = response.response?.allHeaderFields{
                        if self.lastUrl == ""{
                            self.lastUrl = DataService.instance.lastPageLinkFrom(headers: headers)
                        }
                        
                        self.nextUrl = DataService.instance.nextPageLinkFrom(headers: headers)
                        print("next url is: ", self.nextUrl)
                            
                        let pullRequestArray = response.result.value
                        
                        if let pullRequestArray = pullRequestArray {
                            for pullRequest in pullRequestArray {
                                self.pulls.append(pullRequest)
                            }
                        }
                        print("pulls loaded                       >>>", self.pulls.count)
                        self.tableView.reloadData()
                    }
                }
                case .failure(let error) : do{
                    //avoid situation where GitHub API doesn't provide a Link header
                    if error.localizedDescription != "URL is not valid: "{
//                        print(">\(error.localizedDescription).")
                       self.presentConnectionError(message: error.localizedDescription)
                    }
                    }
                }
                
                if URL == self.lastUrl{
                    self.lastPageReached = true
                    print("lastPageReached") //debug
                }
            
                
            }
        }
        
    }
    
    func dismissEmptyPullReqList(){
        let message = "This repository doesn't have pull requests to be shown."
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler:{(action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
        
    func presentConnectionError(message: String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Retry", style: .cancel, handler:{(action: UIAlertAction!) in
            self.loadData(url: self.nextUrl)
        })
        
        alert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}

//MARK: Json Mapping Classes

class PullRequest : Mappable{
    
    var title : String?
    var body : String?
    var user : User?
    var date : String?
    var url : String?
    
    required init?(map: Map) {
        title <- map["title"]
        body <- map["body"]
        user <- map["user"]
        date <- map["created_at"]
        url <- map["html_url"]
    }
    
    func mapping(map: Map) {
        
    }
}
