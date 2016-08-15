//
//  ViewController.swift
//  SizeToFit-Example
//
//  Created by Igor on 15/08/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let standardTextViewText = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    @IBOutlet weak var textView:UITextView!
    
    @IBOutlet weak var desiredHeightTextField: UITextField!
    @IBOutlet weak var desiredWidthTextField: UITextField!
    
    var size = CGSizeZero

    override func viewDidLoad() {
        super.viewDidLoad()
        
        desiredWidthTextField.delegate = self
        desiredHeightTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions
    
    @IBAction func actionIncreaseFont(sender: AnyObject) {
        if let fontDescriptor = textView.font?.fontDescriptor() {
            textView.font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize + 1.0)
            
        }
    }
    
    @IBAction func actionDecreaseFont(sender: AnyObject) {
        if let fontDescriptor = textView.font?.fontDescriptor() {
            textView.font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize - 1.0)
            
        }
    }
    
    @IBAction func actionAddMoreText(sender: AnyObject) {
        textView.text.appendContentsOf(standardTextViewText)
    }

    @IBAction func actionSizeToFit(sender: AnyObject) {
        print("Size before sizeThatFits() - \(textView.frame)")
    
        textView.sizeToFit()
        
        print("Size after sizeThatFits() - \(textView.frame)")
    }
    
    @IBAction func actionSizeToFitWithPresentedValues(sender: AnyObject) {
        print("Size before sizeToFit() - \(textView.frame)")
        
        let newSize = textView.sizeThatFits(size)
        print("\(size)")
        
        var frame = textView.frame
        frame.size = newSize
        textView.frame = frame
        
        print("Size after sizeToFit() - \(textView.frame)")
    }
    
    @IBAction func printSizeThatFits(sender: AnyObject) {
        let maxSize = CGSizeMake(CGRectGetWidth(textView.frame), CGFloat.max)
        print(textView.sizeThatFits(maxSize))
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(desiredHeightTextField) {
            //check if there is text
            if let text = textField.text {
                //establish newsize
                if let height = NSNumberFormatter().numberFromString(text) {
                    size.height = CGFloat(height.floatValue)
                }
            } else {
                size.height = 0.0
            }
        }
        
        //for width do the same
        if textField.isEqual(desiredWidthTextField) {
            
            if let text = textField.text {
                
                if let width = NSNumberFormatter().numberFromString(text) {
                    size.width = CGFloat(width.floatValue)
                }
            } else {
                size.width = 0.0
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}

