//
//  ViewController.swift
//  CoreDataPerson
//
//  Created by Hiếu Nguyễn on 9/25/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit
import os.log

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textAge: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var indexPath: IndexPath!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textName.delegate = self
        
        if indexPath != nil {
            navigationItem.title = DataService.sharedInstance.mocEntity[indexPath.row].name
            textName.text = DataService.sharedInstance.mocEntity[indexPath.row].name
            textAge.text = String(DataService.sharedInstance.mocEntity[indexPath.row].age)
            photoView.image = DataService.sharedInstance.mocEntity[indexPath.row].photo as? UIImage
            
//            navigationItem.title = person.name
//            textName.text = person.name
//            textAge.text = String(person.age)
//            photoView.image = person.photo as? UIImage
            
        }
        updateSaveButtonState()
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Loại bỏ bộ chọn nếu người dùng đã huỷ
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        
        
        photoView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        textName.resignFirstResponder()
//        textAge.resignFirstResponder()
        // UIImagePickerController là một view controller cho phép một người dùng chọn phương tiện từ thư viện ảnh của họ.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        guard let name = textName.text  else {
            return
        }
        guard let age = textAge.text else {
            return
        }
        guard let photo = photoView.image else {return}
//        let context = Person(context: AppDelegate.context)
//        context.name = name
//        context.age = Int16(Int(age) ?? 0 )
//        context.photo = photo
        if person == nil {
            person = Person(context: AppDelegate.context)
        }
        person?.name = name
        person?.age = Int16(Int(age) ?? 0 )
        person?.photo = photo
        
        if indexPath != nil {
            DataService.sharedInstance.edit(at: indexPath.row, and: person!)
        } else {
            DataService.sharedInstance.addData(person: person!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        // Configure the destination view controller only when the save button is pressed.
//        guard let button = sender as? UIBarButtonItem, button === saveButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//
//        let name = textName.text ?? ""
//        let age = textAge.text ?? ""
//        let photo = photoView.image
//
//
//        let context = Person(context: AppDelegate.context)
//        context.name = name
//        context.age = Int16(Int(age) ?? 0)
//        context.photo = photo
//
//        person = context
//    }

    
    
    func updateSaveButtonState()  {
        // Disable the Save button if the text field is empty.
        let text = textName.text ?? ""
        saveButton.isEnabled = !text.isEmpty

    }
    
    
    
    
    
}

