//
//  DetailViewController.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var item: Item? {
        didSet {
            self.getPullRequests()
        }
    }
    var pullArray: [Pull] = []
    
    var page: Int = 0
    var loadingMore : Bool!
    
    let dateFormatter = DateFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .none
        self.dateFormatter.timeZone = NSTimeZone.default
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = self.item?.full_name!
        
//        self.getPullRequests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueWebView" {
            
//            let webViewController = segue.destination as! WebViewController
//            let pull = sender as! Pull
//            webViewController.pull = pull
        }
        
    }
    
    func getPullRequests(completion: ((_ finished: Bool) -> Void)? = nil) {
        
        self.loadingMore = true
        self.page += 1
        
        _ = Service.shared.getRepositoryPulls(owner: (self.item?.owner_login)!, repo: (self.item?.name)!, page: self.page) { (finished, pullRequests, message) in
            
            if finished && pullRequests != nil {
                
                if (pullRequests?.count)! > 0 {
                    
                    self.pullArray.append(contentsOf: pullRequests!)
                    self.tableView.reloadData()
                }
                
                
            } else if !(message?.isEmpty)! {
                
                let alert = UIAlertController(title: "Error", message: message!, preferredStyle: .alert)
                alert.addAction(
                    UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                        self?.dismiss(animated: true, completion: nil)
                    }
                )
                self.present(alert, animated: true)
            }
            self.loadingMore = false
            
            completion?(finished)
        }
        
    }

}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.pullArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pullCell", for: indexPath) as! PullTableViewCell
        let pull = self.pullArray[indexPath.row]
        
        cell.imageViewPhoto.imageFromUrl(link: pull.user_avatar_url!)
        cell.labelUsername.text = pull.user_login!
        cell.labelTitle.text = (pull.title == nil) ? "" : pull.title
        cell.labelDate.text = "Criado em " + self.dateFormatter.string(from: pull.created_at!)
        cell.labelBody.text = pull.body
        
        print("pullCell \(#function) - page: \(self.page) - indexPath.row: \(indexPath.row) - pullArray.count: \(self.pullArray.count) - self.loadingMore: \(self.loadingMore) ")
        
        if (indexPath.row == self.pullArray.count - 1 && !self.loadingMore) {
            if self.page == 0 {self.page = 1}
            print("pullCell \(#function) - getPullRequests() - page: \(self.page) - indexPath.row: \(indexPath.row) - pullArray.count: \(self.pullArray.count)")
            self.getPullRequests()
        }
        
        return cell
    }
}

//extension DetailViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(#function)
//        let pull = self.pullArray[indexPath.row]
//        
//        self.performSegue(withIdentifier: "segueWebView", sender: pull)
//    }
//}
