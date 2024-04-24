//
//  InstructionsViewController.swift
//  SeasonalStyler
//
//  Created by Kiyomi Blackmun on 4/22/24.
//

import UIKit
import PhotosUI

class InstructionsViewController: UIViewController {

    @IBOutlet weak var instructionsTitle: UILabel!
    @IBOutlet weak var instructionsText: UITextView!
    @IBOutlet weak var disclaimerText: UITextView!
    @IBOutlet weak var selfieImage: UIImageView!
    
    @IBOutlet weak var confirmImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding the tab bar button to the right hand corner to allow users to add a picture
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pickImage))
        //set the confirmation button to hidden initially
        //unhide after image is selected
        confirmImageButton.isHidden = true
        // Round the corners of the text view
        disclaimerText.layer.cornerRadius = 10
        disclaimerText.layer.masksToBounds = true
        
        instructionsText.layer.cornerRadius = 10 // Adjust the corner radius value as needed
        instructionsText.layer.masksToBounds = true
        
        // Round the corners of the image view
        selfieImage.layer.cornerRadius = 10 // Adjust the corner radius value as needed
        selfieImage.layer.masksToBounds = true

        // Do any additional setup after loading the view.
        //ensure the image is displayed as you navigate through different pages
        if let userImage = UserDefaultsManager.shared.loadImage(forKey: "userFaceImageData") {
            selfieImage.image = userImage
            confirmImageButton.isHidden = false
        }
        //bug-- this user Image persisting causes the Instruction title to disappear
    }
    
    func configureImagePicker(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
        //.delegate does? just allows
    }
    
    @objc func pickImage(){
        configureImagePicker()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension InstructionsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            if let itemprovider = results.first?.itemProvider{
              
                if itemprovider.canLoadObject(ofClass: UIImage.self){
                   
                    itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                        if let selectedImage = image as? UIImage{
                            DispatchQueue.main.async {
                                self.selfieImage.image = selectedImage
                                self.confirmImageButton.isHidden = false
                                UserDefaultsManager.shared.saveImage(selectedImage, forKey: "userFaceImageData")
                            }
                        }
                    }
                }
            }
        }
}

