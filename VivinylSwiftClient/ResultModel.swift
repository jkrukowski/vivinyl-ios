//
//  ResultModel.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ResultModel {
    
    let dist: Float
    let id: String
    let path: String
    
    init?(_ json: JSON) {
        guard let dist = json["dist"].float else {
            return nil
        }
        self.dist = dist
        guard let id = json["id"].string else {
            return nil
        }
        self.id = id
        guard let path = json["path"].string else {
            return nil
        }
        self.path = path
    }
}
