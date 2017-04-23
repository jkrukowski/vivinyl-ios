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
import RxDataSources


enum TableSection: String {
    case data = "data"
}

protocol ResultInteractorInputs {
    func viewDidLoad()
    func configure(with data: [ResultModel])
}

protocol ResultInteractorOutputs {
    var result: Observable<[SectionModel<TableSection, ResultModel>]> { get }
}

protocol ResultInteractorType: ResultInteractorOutputs, ResultInteractorInputs {
    var inputs: ResultInteractorInputs { get }
    var outputs: ResultInteractorOutputs { get }
}

final class ResultInteractor {
    // output
    let result: Observable<[SectionModel<TableSection, ResultModel>]>
    // input
    let resultInput = PublishSubject<[SectionModel<TableSection, ResultModel>]>()
    
    fileprivate var data = [ResultModel]()
    
    init() {
        result = resultInput
    }
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
        resultInput.onNext([SectionModel(model: TableSection.data, items: data)])
    }
    func configure(with data: [ResultModel]) {
        self.data = data
    }
}

// MARK: ResultInteractorOutputs

extension ResultInteractor: ResultInteractorOutputs {
}
