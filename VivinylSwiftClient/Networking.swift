//
//  Networking.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 23/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import RxAlamofire
import Alamofire


final class Networking {

    static let url = URL(string: "http://139.59.133.215:8000/find")!
    
    static func find(with image: UIImage) -> Observable<JSON> {
        let request = try! URLRequest(url: url, method: .post)
        let data = UIImageJPEGRepresentation(image, 1.0)!
        return RxAlamofire.upload(data, urlRequest: request)
            .flatMap { request -> Observable<Data> in
                let data = request
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                
                return data.rx.data()
            }
            .map { data -> JSON in
                JSON(data: data)
            }
    }
}
