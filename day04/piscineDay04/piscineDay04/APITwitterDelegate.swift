//
//  APITwitterDelegate.swift
//  piscineDay04
//
//  Created by Artem Potekhin on 14.08.2022.
//

import Foundation

protocol APITwitterDelegate: AnyObject {
    
//    func receiveTweets(array: [Tweet])
    func receiveTweets(array: [TweetNews])
    
    func errorTweetsHandle(error: NSError)
    func errorTweetsHandle(error: TweetError)
}
