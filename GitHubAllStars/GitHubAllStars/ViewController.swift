//
//  ViewController.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DataManager.sharedInstance.getStarsRepositories(language: "Java", page: 0) { (error, message, repositories) in
            if !error {
                if let repos = repositories {
                    for repo in repos {
                        print(repo.name)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

