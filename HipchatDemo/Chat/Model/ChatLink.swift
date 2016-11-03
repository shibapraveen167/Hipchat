//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation

struct ChatLink {
    let linkURL: String
    let pageTitle: String
    init (url: String, pageTitle: String) {
        self.linkURL = url
        self.pageTitle = pageTitle
    }
}
