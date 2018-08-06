//
//  ViewController.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = RepositoryService()
        service.getRepository(page: 1) { (lista, total) in
            print(lista)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

