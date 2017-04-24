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
import RxOptional
import SafariServices


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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    fileprivate func setupLayout() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    fileprivate func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<TableSection, ResultModel>>()
        
        dataSource.configureCell = { _, tableView, indexPath, result in
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.cellId, for: indexPath) as! ResultTableViewCell
            cell.configureCell(result)
            return cell
        }
        
        interactor.result
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected
            .map { [weak self] indexPath in
                self?.interactor.model(atIndex: indexPath.row)
            }
            .filterNil()
            .map(Networking.url)
            .subscribe(onNext: { [weak self] url in
                let controller = SFSafariViewController(url: url)
                self?.navigationController?.pushViewController(controller, animated: true)
            }).addDisposableTo(disposeBag)
    }
}

// MARK: UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
}
