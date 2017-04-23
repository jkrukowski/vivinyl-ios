//
//  UploadViewController.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 22/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


final class UploadViewController: UIViewController {
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    var didUpload: ([ResultModel]) -> () = { _ in }
    
    fileprivate let uploadInterator: UploadInteractorType = UploadInteractor()
    fileprivate var disposeBag = DisposeBag()
    
    static func instantiate(_ image: UIImage) -> UploadViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UploadViewController") as! UploadViewController
        controller.uploadInterator.configure(with: image)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        uploadInterator.load()
        indicator.startAnimating()
    }
    
    fileprivate func bindViewModel() {
        uploadInterator.result
            .subscribe(onNext: { [weak self] result in
                self?.indicator.stopAnimating()
                self?.dismiss(animated: true) {
                    self?.didUpload(result)
                }
            }, onError: { [weak self] error in
                self?.showResult(title: "Error", message: "\(error)")
                self?.indicator.stopAnimating()
            }).addDisposableTo(disposeBag)
    }
    
    fileprivate func showResult(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
