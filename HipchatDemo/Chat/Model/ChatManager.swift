//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation
import Kanna

typealias ChatConversionCompletion = (String?) -> Void

class ChatManager {

    static let shared = ChatManager()
    private let htmlService = HTMLService()

    func convertChatToJSON(fromInput input: String, completion: ChatConversionCompletion) {
        let mentions = input.filterMentions()
        let emoticons =  input.filterEmoticons()
        let links = input.filterLinks()
        var linksWithTitle: [ChatLink] = []
        let linkRequestGroup = dispatch_group_create()
        for link in links {
            var title = ""
            if let encodedLink = link.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()),
                linkURL = NSURL(string: encodedLink) {
                dispatch_group_enter(linkRequestGroup)
                    self.htmlService.requestHTMLString(forURL: linkURL) { htmlString in
                        title = Kanna.HTML(html: htmlString, encoding: NSUTF8StringEncoding)?.title ?? ""
                        linksWithTitle.append(ChatLink(url: link, pageTitle: title))
                        dispatch_group_leave(linkRequestGroup)
                    }
            }
        }
        dispatch_group_notify(linkRequestGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let convertedChat = ChatToJSONBuilder.convertToJSON(Chat(mentions: mentions, emoticons: emoticons, links: linksWithTitle))
            completion(convertedChat)
        }
    }
}
