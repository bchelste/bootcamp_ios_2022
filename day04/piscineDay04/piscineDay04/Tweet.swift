//
//  Tweet.swift
//  piscineDay04
//
//  Created by Artem Potekhin on 13.08.2022.
//

import Foundation

let accessKey = "AAAAAAAAAAAAAAAAAAAAAOa9fwEAAAAA9fJ3xQ9HRRgXjtApIcRr25me1BE%3DiV7JGGXUPAJKDsD7fCtmbZeWbQhaNloLRivwwQJqAxDGZ1ML6i"


struct SearchResult: Codable {
    let statuses: [TweetNews]?
}

struct TweetUser: Codable {
    let name: String?
}

struct TweetNews: Codable {
    let createdAt: String?
    let text: String?
    let user: TweetUser?

}

struct Tweet: CustomStringConvertible, Codable {
    var description: String {
        return "\(name)\n\(text)\n"
    }

    let name: String
    let text: String

}

enum TweetError: LocalizedError {
    case creatingURLError
    case emptyDataReply
    case noFindResult
    case JSONDecodeError
    
    
    var errorDescription: String {
        switch self {
        case .creatingURLError:
            return String("creating url error!")
        case .emptyDataReply:
            return String("Twitter empty data error")
        case .noFindResult:
            return String("Keyword has no result")
        case .JSONDecodeError:
            return String("JSONDecoder error")
        }
    }
}
