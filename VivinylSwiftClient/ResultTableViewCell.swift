//
//  ResultTableViewCell.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import UIKit


final class ResultTableViewCell: UITableViewCell {
    static let cellId = "ResultTableViewCell"
    
    func configureCell(_ result: ResultModel) {
        textLabel?.text = result.id
    }
}


