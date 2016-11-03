//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import UIKit

class ChatViewController: UIViewController {

    // MARK: Properties

    @IBOutlet private var inputTextfield: UITextField!
    @IBOutlet private var convertButton: UIButton!
    @IBOutlet private var returnTextView: UITextView!
    @IBOutlet private var progressIndicator: UIActivityIndicatorView!
    
    private enum Constants {
        enum Strings {
            static let conversionError = NSLocalizedString("Can't convert to JSON", comment: "Error text")
        }
    }

    // MARK: Lifecycle methods

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        inputTextfield.becomeFirstResponder()
    }

    // MARK: IBActions

    @IBAction func convertButtonTapped(sender: AnyObject) {
        returnTextView.text = ""
        progressIndicator.startAnimating()
        convertButton.enabled = false
        requestConvertedJSON()
    }

    private func requestConvertedJSON() {
        let input = inputTextfield.text ?? ""
        ChatManager.shared.convertChatToJSON(fromInput: input) { [weak self] convertedJSON in
            guard let this = self else { return }
            this.updateView(withText: convertedJSON ?? Constants.Strings.conversionError)
        }
    }

    // MARK: View update methods

    private func updateView(withText text: String?) {
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            guard let this = self else { return }
            this.progressIndicator.stopAnimating()
            this.returnTextView.text = text
            this.convertButton.enabled = true
        }
    }
}
