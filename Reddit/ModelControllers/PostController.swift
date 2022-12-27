//
//  PostController.swift
//  Reddit
//
//  Created by Mackenzie Wacker on 12/23/22.
//

import UIKit

class PostController {
    
    // MARK: - String Constants
    static let baseURL = URL(string: "https://www.reddit.com")
    static let rComponent = "r"
    static let jsonExtension = "json"
    

    // MARK: - Fetch
    static func fetchPostsWith(searchTerm: String, completion: @escaping (Result<[Post], PostError>) -> Void) {
        //URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let rURL = baseURL.appendingPathComponent(rComponent)
        let searchURL = rURL.appendingPathComponent(searchTerm)
        let finalURL = searchURL.appendingPathExtension(jsonExtension)
        print(finalURL)
        //Data Tasks
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            //Handle error
            if let unwrappedError = error {
                return completion(.failure(.thrownError(unwrappedError)))
            }
            //Handle response
            if let unwrappedResponse = response as? HTTPURLResponse {
                if unwrappedResponse.statusCode != 200 {
                    print("POST STATUS CODE: \(unwrappedResponse.statusCode)")
                }
            }
            //Handle data
            guard let unwrappedData = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: unwrappedData)
                let secondLevelObject = topLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                var arrayOfPosts: [Post] = []
                for dict in thirdLevelObject {
                    let post = dict.data
                    arrayOfPosts.append(post)
                }
                
                return completion(.success(arrayOfPosts))
                
            } catch {
//                return completion(.failure(.thrownError(error)))
                return completion(.failure(.unableToDecode))
            }
            
        }.resume() // URLSession
        
    }
    

    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        guard let thumbnailURL = URL(string: post.thumbnail) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            
            if let unwrappedError = error {
                return completion(.failure(.thrownError(unwrappedError)))
            }

            if let unwrappedResponse = response as? HTTPURLResponse {
                if unwrappedResponse.statusCode != 200 {
                    print("THUMBNAIL STATUS CODE: \(unwrappedResponse.statusCode)")
                }
            }

            guard let unwrappedData = data else { return completion(.failure(.noData)) } // don't need a try catch cause we would already have data
            guard let thumbnail = UIImage(data: unwrappedData) else {return completion(.failure(.unableToDecode)) }
            
            return completion(.success(thumbnail))
            
        }.resume()
        
    }
    
    
    
} // End of class
