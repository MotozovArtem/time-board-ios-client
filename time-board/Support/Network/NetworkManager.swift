//
//  NetworkManager.swift
//  time-board
//
//  Created by Tianid on 05.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

enum RequestType: String {
    case GET, POST, PUT, DELETE, UPDATE
}

class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    
    
    // MARK: - Init
    
    // MARK: - Functions
    func makeRequest<T: Codable>(model: T?,
                                 components: URLComponents,
                                 request: RequestType,
                                 complition: @escaping (Result<Bool, CustomEventMessages>) -> Void) {
        CUDOpearions(model: model, components: components, request: request, complition: complition)
    }
    
    func makeRequest<T: Codable>(of type: T.Type = T.self,
                                 components: URLComponents,
                                 requestType: RequestType,
                                 successor: @escaping (T) -> (),
                                 failure: @escaping (CustomEventMessages?) -> ()) {
        //        let path: String!
        //        if let id = id { path = String(format: apiPath, id) }
        //        else { path = apiPath }
        ROperation(components: components, requestType: requestType, successor: successor, failure: failure)
    }
    
    
    //MARK: - Backend  CRUD operations
    //C - Create; U - Update D - Delete operations
    private func CUDOpearions<T: Codable>(model: T?,
                                          components: URLComponents,
                                          request: RequestType,
                                          complition: @escaping (Result<Bool, CustomEventMessages>) -> Void) {
        
        guard var request = getRequest(components: components, requestType: request) else {
            complition(.failure(.CantCreateRequest))
            TBLog(messageType: .CantCreateRequest, typeOfLog: .Error)
            return
        }
        
        if let model = model {
            guard let body = getBody(model: model, complition: complition) else { return }
            request.httpBody = body
        }
        
        let task = requestTask(request: request, complition: complition)
        task?.resume()
    }
    
    
    // R - Read operation
    private func ROperation<T: Codable>(components: URLComponents,
                                        requestType: RequestType,
                                        successor: @escaping (T) -> (),
                                        failure: @escaping (CustomEventMessages?) -> ()) {
        
        guard let request = getRequest(components: components, requestType: requestType) else {
            failure(.CantCreateRequest)
            TBLog(messageType: .CantCreateRequest, typeOfLog: .Error)
            return
        }
        guard let task = modelTask(request: request, successor: successor, failure: failure) else {
            failure(.CantCreateTask)
            TBLog(messageType: .CantCreateTask, typeOfLog: .Error)
            return
        }
        
        TBLog(messageType: .StartLoading, typeOfLog: .Info)
        task.resume()
        
    }
    
    //MARK: - supported functions
    private func getRequest(components: URLComponents, requestType: RequestType) -> URLRequest? {
        guard let url = components.url else {
            TBLog(messageType: .CantCreateURL, typeOfLog: .Error)
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func getBody<T: Codable>(model: T, complition: (Result<Bool, CustomEventMessages>) -> Void)  -> Data? {
        do {
            let body = try serialize(model: model)
            return body
        } catch {
            complition(.failure(.JsonEncoderError(error)))
            TBLog(messageType: .JsonEncoderError(error), typeOfLog: .Error)
            return nil
        }
    }
    
    private func serialize<T: Codable>(model: T) throws -> Data {
        let data = try JSONEncoder().encode(model)
        return data
    }
    
    private func deserialize<T: Codable>(of type: T.Type = T.self, data: Data) throws -> T {
        let dataObject = try JSONDecoder().decode(T.self, from: data)
        return dataObject
    }
    
    func getComponents(id: String? = nil, host: String, scheme: String, port: Int, path: String) -> URLComponents?{
        var components = URLComponents()
        components.host = host
        components.scheme = scheme
        components.port = port
        if let id = id {
            components.path = String(format: path, id)
        } else {
            components.path = path
        }
        return components
    }
    
    //MARK: -  tasks
    private func modelTask<T: Codable>(request: URLRequest,
                                       successor: @escaping (T) -> (),
                                       failure: @escaping (CustomEventMessages?) -> ()) -> URLSessionDataTask? {
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard error == nil else {
                failure(.ConnectionError(error))
                TBLog(messageType: .ConnectionError(error), typeOfLog: .Error)
                return
            }
            
            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (200...299):
                do {
                    let dataObject = try self!.deserialize(of: T.self, data: data)
                    successor(dataObject)
                    TBLog(messageType: .LoadingSuccess, typeOfLog: .Verbose)
                    TBLog(messageType: .EndLoading, typeOfLog: .Info)
                } catch {
                    failure(.JsonDecoderError(error))
                    TBLog(messageType: .JsonDecoderError(error), typeOfLog: .Error)
                }
            case (400...499):
                failure(.ClientSiteError(error))
                TBLog(messageType: .ClientSiteError(error), typeOfLog: .Error)
            case (500...599):
                failure(.ServerSiteError(error))
                TBLog(messageType: .ServerSiteError(error), typeOfLog: .Error)
            default:
                break
            }
        }
        return task
    }
    
    private func requestTask(request: URLRequest,
                             complition: @escaping (Result< Bool, CustomEventMessages>) -> Void) -> URLSessionDataTask? {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                complition(.failure(.ConnectionError(error)))
                TBLog(messageType: .ConnectionError(error), typeOfLog: .Error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (200...299):
                complition(.success(true))
            case (400...499):
                complition(.failure(.ClientSiteError(error)))
            case (500...599):
                complition(.failure(.ServerSiteError(error)))
            default:
                break
            }
        }
        return task
    }
}
