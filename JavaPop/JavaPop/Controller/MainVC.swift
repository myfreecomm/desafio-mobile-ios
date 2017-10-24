//
//  ViewController.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 20/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import UIKit

class MainVC: UITableViewController{
    private let cellId = "RepositoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RepositoryCellNib", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MainVCPullReqVC", sender: self)
    }


}

