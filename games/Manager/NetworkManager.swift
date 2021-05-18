//
//  NetworkManager.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Alamofire

final class NetworkManager {
    private let networkQueue = DispatchQueue(label: "\(AppConfiguration.shared.bundleIdentifier).network.manager.queue", attributes: .concurrent)
    
    @discardableResult
    func request(_ service: NetworkService, completion: ((NetworkResult<Data>) -> Void)?) -> DataRequest? {
        let url: URLConvertible = AppConfiguration.shared.baseUrl + service.path
        let parameters: Parameters? = {
            guard let encodable = service.object else {
                return nil
            }
            
            do {
                let parametersData = try encodable.toJSONData()
                return try JSONSerialization.jsonObject(with: parametersData, options: []) as? Parameters
            } catch {
                let networkError = NetworkError.jsonEncoding(internal: error)
                printError(networkError)
                return nil
            }
        }()
        let encoding: ParameterEncoding = {
            switch service.method {
            case .get: return URLEncoding.default
            default: return JSONEncoding.default
            }
        }()
        
        return Alamofire.Session.default
            .request(url, method: service.method, parameters: parameters, encoding: encoding, headers: service.headers)
            .response(queue: self.networkQueue, completionHandler: dataResponseCompletion(completion))
    }
    
    @discardableResult
    func request<U: Decodable>(_ service: NetworkService, completion: ((NetworkResult<U>) -> Void)?) -> DataRequest? {
        return request(service) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try data.toJSONObject(U.self)
                    completion?(.success(value: decoded))
                } catch {
                    completion?(.failure(error: .jsonDecoding(internal: error)))
                }
            case .failure(let error):
                completion?(.failure(error: error))
            }
        }
    }
    
    @discardableResult
    func requestImageData(urlString: String, completion: ((NetworkResult<Data>) -> Void)?) -> DataRequest? {
        return Alamofire.Session.default
            .request(urlString as URLConvertible)
            .response(queue: self.networkQueue, completionHandler: dataResponseCompletion(completion))
    }
    
    private func dataResponseCompletion(_ completion: ((NetworkResult<Data>) -> Void)?) -> (AFDataResponse<Data?>) -> Void {
        return { defaultDataResponse in
            guard let response = defaultDataResponse.response else {
                completion?(.failure(error: .validateResponse))
                return
            }
            
            guard 200..<300~=response.statusCode else {
                completion?(.failure(error: .statusCode(code: response.statusCode,
                                                        data: defaultDataResponse.data ?? Data())))
                return
            }
            
            completion?(.success(value: defaultDataResponse.data ?? Data()))
        }
    }
}
