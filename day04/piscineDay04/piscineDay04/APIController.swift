//
//  APIController.swift
//  piscineDay04
//
//  Created by Artem Potekhin on 13.08.2022.
//

import Foundation

class APIController {
    
    weak var delegate: APITwitterDelegate?
    
    let token: String
    let amount = 25
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func fetchTweets(src: String) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.twitter.com"
        urlComponents.path = "/1.1/search/tweets.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: src),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "result_type", value: "recent"),
            URLQueryItem(name: "count", value: "\(amount)")
        ]
        
        guard let url = urlComponents.url else {
            self.delegate?.errorTweetsHandle(error: TweetError.creatingURLError as NSError)
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let replyError = error {
                self.delegate?.errorTweetsHandle(error: replyError as NSError)
                return
            }
            
            guard let data = data else {
                self.delegate?.errorTweetsHandle(error: TweetError.emptyDataReply as NSError)
                return
            }
//            let reseivedData = String(data: data, encoding: .utf8)
//            print(reseivedData)
            do {
//                if let tweets = (try decoder.decode(SearchResult.self, from: data)).statuses, tweets.count != 0 {
                if let tweets = (try decoder.decode(SearchResult.self, from: data)).statuses {
                    self.delegate?.receiveTweets(array: tweets)
                } else {
                    self.delegate?.errorTweetsHandle(error: TweetError.noFindResult)
                }
            } catch {
                self.delegate?.errorTweetsHandle(error: TweetError.JSONDecodeError)
            }
        }
        task.resume()
    }
}
