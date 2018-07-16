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

class AddSubjectViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
        }else{
            //ERROR message
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var descTextField: UITextField!

    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var activeSwitch: UISwitch!
    
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
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        Defaults.saveSubjectAndDesc(subjectTextField.text!, descTextField.text!)
        let subject = Defaults.getSubjectAndDesc.subject
        let desc = Defaults.getSubjectAndDesc.desc
        
        print(subject)
        print(desc)
        
    }
    
    struct Defaults {
        
        static let (subjectKey, descKey) = ("subject", "desc")
        static let userSessionKey = "com.save.usersession"
        
        struct Model {
            var subject: String?
            var desc: String?
            
            
            init(_ json: [String: String]) {
                self.subject = json[subjectKey]
                self.desc = json[descKey]
                
            }
        }
        
        static var saveSubjectAndDesc = { (subject: String, desc: String) in
            UserDefaults.standard.set([subjectKey: subject, descKey: desc], forKey: userSessionKey)
        }
        
        static var getSubjectAndDesc = { _ -> Model in
            return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
        }(())
        
        static func clearUserData(){
            UserDefaults.standard.removeObject(forKey: userSessionKey)
        }
    }
    
}
