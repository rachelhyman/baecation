//
//  PrefsViewController.swift
//  Baecation
//
//  Created by Rachel Hyman on 1/2/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class PrefsViewController: UIViewController {

    @IBAction func didHitDownloadData(sender: AnyObject) {
        let filePath: String! = NSBundle.mainBundle().pathForResource("server_info", ofType: "json")
        let fileData: NSData! = NSData(contentsOfFile: filePath)
        let serverJson = JSON(data: fileData)
        let serverURL = serverJson["url"].stringValue
        
        let placesData: NSData! = NSData(contentsOfURL: NSURL(string:serverURL)!)
        let json = JSON(data: placesData)
        let places:[Place] = json.arrayValue.map{ Place.fromJSON($0)}
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            realm.add(places)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("dataLoaded", object: nil)
    }
}
