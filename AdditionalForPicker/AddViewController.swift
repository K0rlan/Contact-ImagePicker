//
//  AddViewController.swift
//  AdditionalForPicker
//
//  Created by Korlan Omarova on 30.11.2020.
//

import UIKit
import ContactsUI
import Realm
import RealmSwift

class AddViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let contactsController = CNContactPickerViewController()
    let pickerController = UIImagePickerController()
    var image: UIImage?
    
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsController.delegate = self
        pickerController.delegate = self
    }
    @IBOutlet weak var phoneA: UILabel!
    @IBOutlet weak var imgA: UIImageView!
    @IBOutlet weak var nameA: UILabel!
    
    @IBAction func chooseContact(_ sender: Any) {
        self.present(contactsController, animated: true, completion: nil)
    }
    @IBAction func chooseImage(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                                      self.takePhotoWithCamera() })
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
        alert.addAction(actLibrary)
        present(alert, animated: true, completion: nil)
    }
    func choosePhotoFromLibrary() {
      pickerController.sourceType = .photoLibrary
      pickerController.delegate = self
      pickerController.allowsEditing = true
      present(pickerController, animated: true, completion: nil)
    }
    
      func takePhotoWithCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
        pickerController.sourceType = .camera
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Fail", message: "There is no camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
      }
    func imagePickerController(_ picker: UIImagePickerController,
         didFinishPickingMediaWithInfo info:
                       [UIImagePickerController.InfoKey : Any]) {
      image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
      if let theImage = image {
        show(image: theImage)
      }
      dismiss(animated: true, completion: nil)
    }
    func show(image: UIImage) {
      imgA.image = image
      imgA.isHidden = false
    }
    
    @IBAction func save(_ sender: Any) {
        let contacts = ContactBook()
        contacts.name = nameA.text ?? ""
        contacts.number = phoneA.text ?? ""
        let img = NSData(data: imgA.image!.jpegData(compressionQuality: 0.5)!)
        contacts.image = img
        try! realm.write {
            realm.add(contacts)
        }
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController, animated: true)
    }
    
    

}

extension AddViewController: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.phoneA.text = contact.phoneNumbers[0].value.stringValue
        self.nameA.text = contact.givenName
    }
}
