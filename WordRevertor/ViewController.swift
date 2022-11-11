//
//  ViewController.swift
//  WordRevertor
//
//  Created by Oran Levi on 31/10/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var reverseStringButton: UIButton!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var lowerCaseButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var resulteTextView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var service = Service.shared
    
    var reversText = false
    var sortButtonDoubleTapped = false
    var lowerButtonDoubleTapped = false
    var selectedTranslation: [(String,String)] = hebrewToEnglish
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        setupButton()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupButton(){
        reverseStringButton.layer.cornerRadius = 10
        sortButton.layer.cornerRadius = 10
        lowerCaseButton.layer.cornerRadius = 10
        copyButton.layer.cornerRadius = 10
        pasteButton.layer.cornerRadius = 10
        selectAllButton.layer.cornerRadius = 10
        clearButton.layer.cornerRadius = 10

    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedTranslation = hebrewToEnglish
        case 1:
            selectedTranslation = englishToHebrew
        default:
            break
        }
    }
    
    @IBAction func pasteButton(_ sender: Any) {
        let pasteboard = UIPasteboard.general.string
        originalTextView.text = pasteboard
    }
    

    @IBAction func selectAllButton(_ sender: Any) {
        originalTextView.selectAll(self)
    }
    
    @IBAction func clearButton(_ sender: Any) {
        originalTextView.text = nil
    }

    @IBAction func reversStringButton(_ sender: Any) {
        service.str = originalTextView.text
        service.reversesWords(lang: selectedTranslation)
        if reversText {
            resulteTextView.text = String(service.str.reversed())
        } else {
            resulteTextView.text = service.str
        }
    }
    
    @IBAction func sortString(_ sender: Any) {
        var resulteString = ""
        resulteString = resulteTextView.text
        resulteTextView.text = String(resulteString.reversed())
        sortButtonDoubleTapped = !sortButtonDoubleTapped
        sortButton.setTitle(sortButtonDoubleTapped ? "סדר מההתחלה לסוף" : "סדר מהסוף להתחלה", for: .normal)
    }
    
    @IBAction func lowercaseButton(_ sender: Any) {
        var resulteString = ""
      
        if !lowerButtonDoubleTapped {
            lowerCaseButton.setTitle("Upper case", for: .normal)
            resulteString = resulteTextView.text.lowercased()
            resulteTextView.text = resulteString
            lowerButtonDoubleTapped = true
        } else {
            lowerCaseButton.setTitle("lower case", for: .normal)
            resulteString = resulteTextView.text.uppercased()
            resulteTextView.text = resulteString
            lowerButtonDoubleTapped = false
        }
    }
    

    @IBAction func copyButton(_ sender: Any) {
        let copyBoard = UIPasteboard.general
        copyBoard.string = resulteTextView.text
        copyButton.setTitle("הועתק", for: .normal)
        copyButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.copyButton.setTitle("העתק", for: .normal)
            self.copyButton.setImage(UIImage(), for: .normal)
        }
    }
}


