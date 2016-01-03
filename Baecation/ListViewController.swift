//
//  ListViewController.swift
//  Baecation
//
//  Created by Rachel Hyman on 12/17/15.
//  Copyright © 2015 Rachel Hyman. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var places:Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        places = realm.objects(Place)
        
        NSNotificationCenter.defaultCenter().addObserverForName("dataLoaded", object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] _ in
            self!.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let p = places {
            return p.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ListTableViewCell))
        let cell:ListTableViewCell = c as! ListTableViewCell
        
        cell.nameLabel.text = places![indexPath.row].name
        
        return cell
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
