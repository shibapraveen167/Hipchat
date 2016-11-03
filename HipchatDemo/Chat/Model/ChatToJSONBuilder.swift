//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation
import Kanna

class ChatToJSONBuilder {
    private enum Constants {
        enum JSONKeys {
            static let mentions = "mentions"
            static let emoticons = "emoticons"
            static let links = "links"
            static let linkURL = "url"
            static let linkTitle = "title"
        }
    }
    /// Converts chat object to corresponding JSON string
    static func convertToJSON(input: Chat) -> String? {
        let jsonDictionary = [
            Constants.JSONKeys.mentions : input.mentions,
            Constants.JSONKeys.emoticons : input.emoticons,
            Constants.JSONKeys.links : convert(fromChatLinks: input.links)
        ]
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(jsonDictionary, options: .PrettyPrinted)
            return String(data: data, encoding: NSUTF8StringEncoding)?.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

    private static func convert(fromChatLinks links: [ChatLink]) -> [NSDictionary] {
        var chatLinkDictionaries: [NSDictionary] = []
        for link in links {
            chatLinkDictionaries.append([
                Constants.JSONKeys.linkURL : link.linkURL,
                Constants.JSONKeys.linkTitle : link.pageTitle
                ])
        }
        return chatLinkDictionaries
    }

}
