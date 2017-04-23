//
//  UploadInteractor.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON


protocol UploadInteractorInputs {
    func load()
    func configure(with image: UIImage)
}

protocol UploadInteractorOutputs {
    var result: Observable<[ResultModel]> { get }
}

protocol UploadInteractorType: UploadInteractorInputs, UploadInteractorOutputs {
    var inputs: UploadInteractorInputs { get }
    var outputs: UploadInteractorOutputs { get }
}

final class UploadInteractor {
    // output
    let result: Observable<[ResultModel]>
    // input
    fileprivate let resultInput = PublishSubject<[ResultModel]>()
    fileprivate let imageInput = PublishSubject<UIImage>()
    
    fileprivate var image: UIImage?
    fileprivate var disposeBag = DisposeBag()
    
    init() {
        result = resultInput
        imageInput.flatMapLatest { image -> Observable<JSON> in
            Networking.find(with: image)
        }
        .map { json -> [ResultModel] in
            let result = json["result"].array ?? []
            return result.flatMap(ResultModel.init)
        }
        .subscribe(onNext: { [weak self] result in
            self?.resultInput.onNext(result)
        })
        .addDisposableTo(disposeBag)
    }
}

// MARK: UploadInteractorType

extension UploadInteractor: UploadInteractorType {
    var inputs: UploadInteractorInputs {
        return self
    }
    var outputs: UploadInteractorOutputs {
        return self
    }
}

// MARK: UploadInteractorInputs

extension UploadInteractor: UploadInteractorInputs {
    func load() {
        guard let image = self.image else {
            return
        }
        imageInput.onNext(image)
    }
    func configure(with image: UIImage) {
        self.image = image
    }
}

// MARK: UploadInteractorOutputs

extension UploadInteractor: UploadInteractorOutputs {
}
