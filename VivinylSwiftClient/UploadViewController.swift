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
            .subscribe(onNext: { [weak self] json in
                self?.showResult(title: "Result", message: json.rawString() ?? "")
                self?.indicator.stopAnimating()
            }, onError: { [weak self] error in
                self?.showResult(title: "Error", message: "\(error)")
                self?.indicator.stopAnimating()
            }).addDisposableTo(disposeBag)
    }
    
    fileprivate func showResult(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
