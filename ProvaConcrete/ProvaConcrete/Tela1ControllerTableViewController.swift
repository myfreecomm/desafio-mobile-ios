//
//  Tela1ControllerTableViewController.swift
//  ProvaConcrete
//
//  Created by MacBook Pro i7 on 01/08/17.
//  Copyright © 2017 Claudio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class Tela1ControllerTableViewController: UITableViewController {
    let BaseUrl = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    
    var dados = [Repositorio]()
    
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var nameRep: String = ""
    var criador: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub JavaPop"
        UIApplication.shared.statusBarStyle = .lightContent

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Tratamento para submeter a url
        Alamofire.request(BaseUrl).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["items"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                    
                }
            }
        }
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrRes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReposTableViewCell
        
        // Configure the cell...
        
        var dict = arrRes[indexPath.row]
        cell.nomeRepos?.text = dict["full_name"] as? String
        cell.descrRepos?.text = dict["description"] as? String
        if (dict["stargazers_count"] != nil) {
            cell.numeroEstrelas!.text = "*" + String(describing: dict["stargazers_count"]!)
        }
        if (dict["forks_count"] != nil) {
            cell.numeroForks!.text = "P" + String(describing: dict["forks_count"]!)
        }
        
        let url1 = URL(string: dict["owner"]?["avatar_url"] as! String)

        let task = URLSession.shared.dataTask(with: url1!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.sync() {
                cell.fotoAutor.image = UIImage(data: data)
            }
        }
        
        task.resume()
        
        if (dict["owner"]?["login"] != nil) {
            var temp1: String!
            temp1 = dict["owner"]?["login"] as! String
            print (temp1)
            cell.nomeUsuario!.text = temp1
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "pull", sender: self)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pull"{
            if let indexPath = tblJSON.indexPathForSelectedRow {
                let indexNumber = indexPath.row
                let vc = segue.destination as! Tela2ControllerTableViewController
                vc.criador = arrRes[indexNumber]["full_name"] as! String
                vc.repositorio = arrRes[indexNumber]["name"] as! String

            }
        }
    }
 

}
