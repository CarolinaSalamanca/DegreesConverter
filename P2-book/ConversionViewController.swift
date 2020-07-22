//
//  ViewController.swift
//  P2-book
//
//  Created by Carolina Salamanca on 7/10/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

import UIKit

// its a subclass of UIViewController and conforms to UITextFieldDelegate protocol
// The controller now performs the role of UITextField delegate
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    /*override func viewDidLoad() {
     super.viewDidLoad()
     print("Conversion view controller loaded its view")
     
     /* Useful little things
     // a cgrect works as a frame to define the size and position attributes of a view :)
     let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150) // this is the frame for the next view (first view) x and y are represented in Points not pixels
     let firstView = UIView(frame: firstFrame) // we specify the sixe and position of the new view
     firstView.backgroundColor = UIColor.blue
     view.addSubview(firstView)
     
     // Just adding another subview, this time to the previous subview
     let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
     let secondView = UIView(frame: secondFrame)
     secondView.backgroundColor = UIColor.green
     firstView.addSubview(secondView)*/
     }*/
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    // Computed property
    // to calculate the conversion from fharenheit to celsius
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        } else{
            return nil
        }
    }
    
    // This is a closure, to format the number of shown digits
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    //This property is optional because the user might not have typed in a number. (
    // once the variable changes its value (each time the editField changes) an observer to tha variable updtaes the label with the conversion to celsius
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    
    func updateCelsiusLabel(){
        // Literal expressions to debug (Very useful)
        // the break point also can be edited to do actions like logs or sounds
        //print("Method: \(#function) in file: \(#file) line: \(#line) called.")

        if let celsiusValue = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }else{
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    // When the editField is edited a variable converts the text to a Measurement object and assigns)
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        // This no longer works because it doesnt suppor i18n
        //(what if someone from other regin types 1,25 for 1.25, this approach wont work)
       /* if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }*/
        
        // Use this method just to know how to debug (inserting a global breakpoint)
        buggyMethod()
        
        // we use number fomater because its aware of the locale
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func buggyMethod(){
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        // Go one step too far emptying the array (notice the range change):
        for _ in 0...10 {
            array.removeObject(at: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    // we use the current local to know the format of digits in the user region
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // it can be . or ,
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."

        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)

        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}

