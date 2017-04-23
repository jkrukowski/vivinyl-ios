//
//  ResultInteractor.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
//import RxD


protocol ResultInteractorInputs {
    func viewDidLoad()
    func configure(with data: [ResultModel])
}

protocol ResultInteractorOutputs {
//    var result: Observable<[AnimatableSectionModel<CatalogTableSection, ResultModel>]> { get }
}

protocol ResultInteractorType: ResultInteractorOutputs, ResultInteractorInputs {
    var inputs: ResultInteractorInputs { get }
    var outputs: ResultInteractorOutputs { get }
}

final class ResultInteractor {
    fileprivate var data = [ResultModel]()
}

// MARK: UploadInteractorType

extension ResultInteractor: ResultInteractorType {
    var inputs: ResultInteractorInputs {
        return self
    }
    var outputs: ResultInteractorOutputs {
        return self
    }
}

// MARK: ResultInteractorInputs

extension ResultInteractor: ResultInteractorInputs {
    func viewDidLoad() {
        
    }
    func configure(with data: [ResultModel]) {
        self.data = data
    }
}

// MARK: ResultInteractorOutputs

extension ResultInteractor: ResultInteractorOutputs {
}
