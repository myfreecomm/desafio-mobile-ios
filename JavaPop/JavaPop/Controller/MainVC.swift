//
//  ViewController.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 20/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class MainVC: UITableViewController{
    private let cellId = "RepositoryCell"
    private var repos = [Repository]()
    private var nextUrl = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    private var lastUrl : String?
    private var info = ["", ""]
    private var lastPageReached = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.rowHeight = 150
        tableView.isPagingEnabled = true
        
        loadData(url: nextUrl)
        
        let nib = UINib(nibName: "RepositoryCellNib", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RepositoryCell else{
            return UITableViewCell()
        }
        
        if repos.count > 0{
            let index = indexPath.row
            let repo = repos[index]
            cell.nameLbl.text = repo.name
            cell.descTxt.text = repo.description
            cell.userLbl.text = repo.owner?.username
            if let forks = repo.forks{
                cell.setForks(value: forks)
            }else{
                cell.setForks(value: 0)
            }
            
            if let stars = repo.stargazers_count{
                cell.setStars(value: stars)
            }else{
                cell.setStars(value: 0)
            }
            
            if let link = repo.owner?.avatarUrl{
                cell.userImg.downloadedFrom(link: link)
            }
            
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repo = repos[indexPath.row].name{
            self.info[0] = repo
        }
        if let name = repos[indexPath.row].owner?.username{
            self.info[1] = name
        }
        
        
        self.performSegue(withIdentifier: "MainVCPullReqVC", sender: info)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= repos.count * 3/4{
            loadData(url: nextUrl)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PullReqVC{
            if let info = sender as? [String]{
                destination.nextUrl = "https://api.github.com/repos/\(info[1])/\(info[0])/pulls"
            }
            
        }
    }
    
    func loadData(url : String){
        if !lastPageReached{
            let URL = url
            print("URL: \(URL) | LastURL: \(lastUrl)")
            Alamofire.request(URL).responseObject { (response: DataResponse<SearchResponse>) in
                switch response.result{
                case .success( _) : do {
                    if let headers = response.response?.allHeaderFields{
                        if self.lastUrl == nil{
                            self.lastUrl = DataService.instance.lastPageLinkFrom(headers: headers)
                        }
                        self.nextUrl = DataService.instance.nextPageLinkFrom(headers: headers)
                        let searchResponse = response.result.value
                        if let searchItems = searchResponse?.items{
                            for item in searchItems {
                                self.repos.append(item)
                            }
                        }
                        self.tableView.reloadData()
                    }
                        }
                case .failure(let error) : do {
                    self.presentConnectionError(message: error.localizedDescription)
                    }
                }
                
            }
            if let lastUrl = self.lastUrl{
                if URL == lastUrl{
                    self.lastPageReached = true
                    print("lastPageReached") //debug
                }
            }
            print("repos loaded                        >>>", self.repos.count) //debug
        }
    }
    
    func nextPageLinkFrom(headers: [AnyHashable : Any]) -> String{
        var res = String()
        if let link = headers["Link"] as? String{
            let linkArr = link.components(separatedBy: " ")
            res = linkArr[0]
            res.removeFirst()
            res.removeLast()
            res.removeLast()
        }
        return res
    }
    
    func presentConnectionError(message: String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Retry", style: .cancel, handler:{(action: UIAlertAction!) in
            self.loadData(url: self.nextUrl)
        })
        
        alert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
//MARK: Methods for Unit Testing
    
    func isInLastPage() -> Bool{
        if lastPageReached{
            return true
        }else{
            return false
        }
    }
    
    func setLastUrl(url : String){
        self.lastUrl = url
    }

}

//MARK: JSON Mapping Classes

class SearchResponse : Mappable{
    
    var items : [Repository]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
    
}


class Repository : Mappable{
    var name : String?
    var owner : User?
    var description : String?
    var forks : Int?
    var stargazers_count : Int?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        owner <- map["owner"]
        forks <- map["forks"]
        description <- map["description"]
        stargazers_count <- map["stargazers_count"]
    }
}

class User : Mappable{
    
    var username : String?
    var avatarUrl : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map["login"]
        avatarUrl <- map["avatar_url"]
    }
}

