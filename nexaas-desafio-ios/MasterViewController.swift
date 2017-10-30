//
//  MasterViewController.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    var repositories: Repositories?
    
    var page: Int = 0
    var loadingMore : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Service.shared.startReachabilityMonitoring()
        
        self.managedObjectContext = CoreDataStackManager.shared.managedObjectContext
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh(_:)))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(notification:)), name: NSNotification.Name(rawValue: "ReachabilityStatusChangedNotification"), object: nil)
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        if Service.shared.isConnected() {
            self.getRepositoriesInfo()
        }
        
        //getRepositoriesInfo()
    }
    
    /*........................................................................*/
    /* Reachability */
    
    func reachabilityChanged(notification: Notification) {
        
        let isReachable = notification.object as! Bool
        let refreshButton = self.navigationItem.rightBarButtonItem
        
        if isReachable {
            refreshButton?.isEnabled = true
        } else {
            //refreshButton?.isEnabled = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh(_ sender: Any) {
        
        self.page = 0
        self.loadingMore = false
        
        self.getRepositoriesInfo()
    }
    
    func getRepositoriesInfo(completion: ((_ finished: Bool) -> Void)? = nil) {

        self.loadingMore = true
        self.page += 1
        
        print("\(#function) - page: \(self.page)")
        
        let searchString = "language:Java"
        
        _ = Service.shared.getRepositories(searchString, "stars", self.page) { (finished, repositories) in
            
            if finished && repositories?.total_count != nil {
                
                if self.page == 1 {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                    // Create batch delete request and set the result type to .resultTypeObjectIDs so that we can merge the changes                    
                    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    batchDeleteRequest.resultType = .resultTypeObjectIDs

                    do {
                        let batchDeleteResult = try self.managedObjectContext?.execute(batchDeleteRequest) as? NSBatchDeleteResult
                        
                        if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey : deletedObjectIDs],
                                                                into: [self.managedObjectContext!])
                        }
                    }
                    catch {
                        print("Error: \(error)\nCould not batch delete existing records.")
                    }
                }
                
                // Save the context.
                do {
                    for repo in (repositories?.items!)! {
                        
                        let entity = NSEntityDescription.entity(forEntityName: "Item", in: self.managedObjectContext!)
                        let item = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext!)
                        
                        item.setValue(repo.id               , forKey: "id"       )
                        item.setValue(repo.name             , forKey: "name"     )
                        item.setValue(repo.full_name        , forKey: "full_name")
                        item.setValue(repo.owner_login      , forKey: "owner_login")
                        item.setValue(repo.owner_id         , forKey: "owner_id")
                        item.setValue(repo.owner_avatar_url , forKey: "owner_avatar_url")
                        item.setValue(repo.owner_url        , forKey: "owner_url")
                        item.setValue(repo.owner_type       , forKey: "owner_type")
                        item.setValue(repo.itemDescription  , forKey: "itemDescription")
                        item.setValue(repo.stargazers_count , forKey: "stargazers_count")
                        item.setValue(repo.watchers_count   , forKey: "watchers_count")
                        item.setValue(repo.forks_count      , forKey: "forks_count")
                        item.setValue(repo.open_issues_count, forKey: "open_issues_count")
                        item.setValue(repo.forks            , forKey: "forks")
                        item.setValue(repo.open_issues      , forKey: "open_issues")
                        item.setValue(repo.watchers         , forKey: "watchers")
                        
                    }
                    
                    try self.managedObjectContext?.save()
                    //self.tableView.reloadData()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                
            } else {
                //self.alertUser(message: "Timeout")
            }
            self.loadingMore = false
            completion?(finished)
        }
        
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueRepositoryPulls" {
            
            let repositoryPullsViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            let item = sender as! Item
            repositoryPullsViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            repositoryPullsViewController.navigationItem.leftItemsSupplementBackButton = true
            repositoryPullsViewController.item = item
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        print("sectionInfo.numberOfObjects: \(sectionInfo.numberOfObjects)")
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTableViewCell
        let item = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withItem: item)
        
        if (indexPath.row == (self.fetchedResultsController.fetchedObjects?.count)! - 1 && !self.loadingMore) {
            if self.page == 0 {self.page = 1}
            //print("MasterViewController \(#function) - self.getRepositoriesInfo() - page: \(self.page) - indexPath.row: \(indexPath.row) - fetchedObjects?.count: \((self.fetchedResultsController.fetchedObjects?.count)!)")
            self.getRepositoriesInfo()
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func configureCell(_ cell: RepositoryTableViewCell, withItem item: Item) {
        //cell.textLabel!.text = event.timestamp!.description
        
        cell.imageViewPhoto.imageFromUrl(link: (item.owner_avatar_url!))
        cell.labelUsername.text = item.owner_login!
        cell.labelType.text = (item.owner_type == nil) ? "" : item.owner_type
        cell.labelRespositoryName.text = item.full_name!
        cell.labelRespositoryDescription.text = (item.itemDescription == nil) ? "" : item.itemDescription!
        cell.labelStars.text = "\(item.stargazers_count)"
        cell.labelForks.text = "\(item.forks_count)"
        
        //print("repositoryCell \(#function) - page: \(self.page) - fetchedObjects?.count: \((self.fetchedResultsController.fetchedObjects?.count)!) - self.loadingMore: \(self.loadingMore) ")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let item = self.fetchedResultsController.object(at: indexPath)
        
        self.performSegue(withIdentifier: "segueRepositoryPulls", sender: item)
    }
    
    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Item> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 30
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "stargazers_count", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Item>? = nil

//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//            case .insert:
//                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//            case .delete:
//                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//            default:
//                return
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//            case .insert:
//                tableView.insertRows(at: [newIndexPath!], with: .fade)
//            case .delete:
//                tableView.deleteRows(at: [indexPath!], with: .fade)
//            case .update:
//                configureCell(tableView.cellForRow(at: indexPath!) as! RepositoryTableViewCell, withItem: anObject as! Item)
//            case .move:
//                configureCell(tableView.cellForRow(at: indexPath!) as! RepositoryTableViewCell, withItem: anObject as! Item)
//                tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        }
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }

    
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     //func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
 

}

