//
//  Place.swift
//  Baecation
//
//  Created by Rachel Hyman on 1/2/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift
import SwiftyJSON

class Place: Object {
    dynamic var id:Int64 = 0
    dynamic var name:String = ""
    dynamic var desc:String = ""
    dynamic var tags:String = ""
    dynamic var address:String = ""
    dynamic var lat:Double = 0.0
    dynamic var lon:Double = 0.0
    
    class func fromJSON(json:JSON) -> Place {
        var dict = json.dictionaryObject!
        dict["tags"] = "," + json["tags"].arrayValue.map({ $0.stringValue }).joinWithSeparator(",") + ","
        return Place(value: dict)
    }
    
}

extension Place: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(self.lat, self.lon)
        }
    }
    
    var title: String? {
        get {
            return self.name
        }
    }
    
    var subtitle: String? {
        get {
            return self.address
        }
    }
}
