//
//  AddSubjectViewController.swift
//  100days
//
//  Created by buri on 2018. 7. 5..
//  Copyright © 2018년 tina. All rights reserved.
//

import UIKit

extension UITextField {
    func addUnderline(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

class AddSubjectViewController: UIViewController {

    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var descTextField: UITextField!

    @IBOutlet weak var startDateTextField: UITextField!
    
    let datePicker:UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        subjectTextField.addUnderline(height: 1.0, color: UIColor.darkGray)
//        descTextField.addUnderline(height: 1.0, color: UIColor.darkGray)
        
        createDatePicker();

    }
    func createDatePicker(){
        
        datePicker.datePickerMode = .date
        startDateTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneBtn], animated: true)
        
        startDateTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
