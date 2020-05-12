//
//  NetworkManager.swift
//  time-board
//
//  Created by Tianid on 05.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    
    
    // MARK: - Init
    
    // MARK: - Functions
    
    func profileFromBackend() -> Profile {
        // MARK: STAB
        return Profile()
    }
    
    func getAboutAccount<T: Codable>(of type: T.Type = T.self,
                                     id: String? = nil,
                                     apiPath: String,
                                     scheme: String,
                                     successor: @escaping (T) -> (),
                                     failure: @escaping (CustomErrors?) -> ()) {
        let path: String!
        if let id = id { path = String(format: apiPath, id) }
        else { path = apiPath }
        getModelFromBackend(apiPath: path, scheme: scheme, successor: successor, failure: failure)
        
        
    }
    
    private func getModelFromBackend<T: Codable>(apiPath: String,
                                                 scheme: String,
                                                 successor: @escaping (T) -> (),
                                                 failure: @escaping (CustomErrors?) -> ()) {
        
        guard let url = getUrl(apiPath: apiPath, scheme: scheme) else {
            failure(.CantCreateURL)
            return
        }
        guard let task = getTask(url: url, successor: successor, failure: failure) else {
            failure(.CantCreateTask)
            return
        }
        task.resume()
        
    }
    
    private func getUrl(apiPath: String, scheme: String) -> URL? {
        var components = URLComponents(string: apiPath)
        components?.scheme = scheme
        return components?.url
    }
    
    //MARK: - Account tasks
    //MARK: For single account or for all accounts
    private func getTask<T: Codable>(url: URL,
                                             successor: @escaping (T) -> (),
                                             failure: @escaping (CustomErrors?) -> ()) -> URLSessionDataTask? {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                failure(.ConnectionError(error))
                return
            }
            
            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (200...299):
                do {
                    let account = try JSONDecoder().decode(T.self, from: data)
                    successor(account)
                } catch {
                    failure(.JsonDecoderError(error))
                }
            case (400...499):
                failure(.ClienSiteError(error))
            case (500...599):
                failure(.ServerSiteError(error))
            default:
                break
            }
            
        }
        return task
    }
}
