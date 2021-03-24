//
//  ProfileApi.swift
//  TheNameGame
//
//  Created by Lynk on 3/23/21.
//

import Foundation

enum ProfileError: Error {
    case urlInvalid
}

struct ProfileApi {
    
    private let profileUrlString = "https://namegame.willowtreeapps.com/api/v1.0/profiles"
    
    func getProfiles(_ onCompletion: @escaping (Result<[Profile],Error>) -> Void) {
        
        guard let url = URL(string: profileUrlString) else {
            onCompletion(.failure(ProfileError.urlInvalid))
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.cachePolicy = .useProtocolCachePolicy
        
        //check cache for data and load if exists
        if let cacheResponse = session.configuration.urlCache?.cachedResponse(for: request) {
            switch decodeData(data: cacheResponse.data) {
            case let .success(profiles):
                onCompletion(.success(profiles))
            case let .failure(error):
                onCompletion(.failure(error))
            }
        } else {
            //if no cache, make call to endpoint
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                    switch self.decodeData(data: data) {
                    case let .success(profiles):
                        onCompletion(.success(profiles))
                    case let .failure(error):
                        onCompletion(.failure(error))
                    }
                    
                } else if let error = error {
                    onCompletion(.failure(error))
                }
            }
            dataTask.resume()
        }
    }
    
    
    
    //helper function to decode data
    //remove specific entires due to some profiles having a generic picture such as willow tree logo
    //game seemed unfair and unpolished if there was a choice without a headshot
    private func decodeData(data:Data) -> Result<[Profile],Error> {
        let decoder = JSONDecoder()
        do {
            let profiles = try decoder.decode([Profile].self, from: data)
            let fileteredProfiles = profiles.filter{$0.headshot.url != nil && $0.lastName != "Staff" && $0.fullName != "Andrew Morgan" && $0.fullName != "Jack Ross"}
            return .success(fileteredProfiles)
        } catch {
            return .failure(error)
        }
        
    }
}
