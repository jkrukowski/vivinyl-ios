//
//  ResultViewController.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import UIKit


final class ResultViewController: UIViewController {
    
    fileprivate let interactor: ResultInteractorType = ResultIn
    
    static func instantiate(_ data: [ResultModel]) -> ResultViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        return controller
    }
}
