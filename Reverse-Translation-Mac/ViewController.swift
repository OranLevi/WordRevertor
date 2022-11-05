//
//  ViewController.swift
//  Reverse-Translation-Mac
//
//  Created by Oran Levi on 04/11/2022.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    @IBOutlet weak var originalTextView: NSTextField!
    @IBOutlet weak var pasteButton: NSButton!
    @IBOutlet weak var clearButton: NSButton!
    @IBOutlet weak var resulteTextView: NSTextField!
    @IBOutlet weak var reverseStringButton: NSButton!
    @IBOutlet weak var sortButton: NSButton!
    @IBOutlet weak var lowerCaseButton: NSButton!
    @IBOutlet weak var copyButton: NSButton!
    
    var service = Service.shared
    
    var reversText = false
    var sortButtonDoubleTapped = false
    var lowerButtonDoubleTapped = false
    var selectedTranslation: [(String,String)] = hebrewToEnglish
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegment = 0
        setupButtons()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func setupButtons(){
        reverseStringButton.layer?.cornerRadius = 10
        sortButton.layer?.cornerRadius = 10
        lowerCaseButton.layer?.cornerRadius = 10
        copyButton.layer?.cornerRadius = 10
        pasteButton.layer?.cornerRadius = 10
        clearButton.layer?.cornerRadius = 10
        
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        
        switch segmentedControl.selectedSegment{
        case 0:
            selectedTranslation = hebrewToEnglish
        case 1:
            return selectedTranslation = englishToHebrew
        default:
            break
        }
        
    }
    
    @IBAction func pasteButton(_ sender: Any) {
        let pasteboard = NSPasteboard.general
           let copiedString = pasteboard.string(forType: .string)
        originalTextView.stringValue = "\(copiedString ?? "Error")"
    }
        
    @IBAction func clearButton(_ sender: Any) {
        originalTextView.stringValue = ""
    }
    
    @IBAction func reversStringButton(_ sender: Any) {
        service.str = originalTextView.stringValue
        service.reversesWords(lang: selectedTranslation)
        if reversText {
            resulteTextView.stringValue = String(service.str.reversed())
        } else {
            resulteTextView.stringValue = service.str
        }
    }
    
    @IBAction func sortString(_ sender: Any) {
        
        var resulteString = ""
        resulteString = resulteTextView.stringValue
        resulteTextView.stringValue = String(resulteString.reversed())
        sortButtonDoubleTapped = !sortButtonDoubleTapped
        sortButton.title = sortButtonDoubleTapped ? "סדר מההתחלה לסוף" : "סדר מהסוף להתחלה"
    }
    
    @IBAction func lowercaseButton(_ sender: Any) {
        var resulteString = ""
        
        if !lowerButtonDoubleTapped {
            lowerCaseButton.title = "Upper case"
            resulteString = resulteTextView.stringValue.lowercased()
            resulteTextView.stringValue = resulteString
            lowerButtonDoubleTapped = true
        } else {
            lowerCaseButton.title = "lower case"
            resulteString = resulteTextView.stringValue.uppercased()
            resulteTextView.stringValue = resulteString
            lowerButtonDoubleTapped = false
        }
    }
    
    @IBAction func copyButton(_ sender: Any) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(resulteTextView.stringValue, forType: .string)
        copyButton.title = "הועתק"
        copyButton.image = NSImage(systemSymbolName: "checkmark", accessibilityDescription: nil)
        copyButton.imagePosition = NSControl.ImagePosition.imageRight
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.copyButton.title = "העתק"
            self.copyButton.image = NSImage(named: "")
        }
    }
}





