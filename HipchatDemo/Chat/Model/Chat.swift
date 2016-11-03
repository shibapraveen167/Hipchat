//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation

struct Chat {
    let mentions: [String]
    let emoticons: [String]
    let links: [ChatLink]
    init(mentions: [String], emoticons: [String], links: [ChatLink]) {
        self.mentions = mentions
        self.emoticons = emoticons
        self.links = links
    }
}