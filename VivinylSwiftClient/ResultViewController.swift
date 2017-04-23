//
//  ResultViewController.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources


final class ResultViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    fileprivate let interactor: ResultInteractorType = ResultInteractor()
    fileprivate var disposeBag = DisposeBag()
    
    static func instantiate(_ data: [ResultModel]) -> ResultViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        controller.interactor.configure(with: data)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        interactor.viewDidLoad()
    }
    
    fileprivate func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<TableSection, ResultModel>>()
        
        dataSource.configureCell = { _, tableView, indexPath, result in
            
        }
        
        interactor.result
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
    }
}

// MARK: UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
}
