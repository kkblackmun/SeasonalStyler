//
//  ColorPickerViewController.swift
//  SeasonalStyler
//
//  Created by Kiyomi Blackmun on 4/23/24.
//

import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var eyeColorSwatch: UIView!
    @IBOutlet weak var skinColorSwatch: UIView!
    @IBOutlet weak var hairColorSwatch: UIView!
    
    
    
    @IBOutlet weak var selfieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //create the eyedropper navigation button:
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "eyedropper"), style: .plain, target: self, action: #selector(openColorPicker))
        //round the corners of the color swatches
        eyeColorSwatch.layer.cornerRadius = 12
        eyeColorSwatch.layer.masksToBounds = true
        
        skinColorSwatch.layer.cornerRadius = 12
        skinColorSwatch.layer.masksToBounds = true
        
        hairColorSwatch.layer.cornerRadius = 12
        hairColorSwatch.layer.masksToBounds = true

        if let userImage = UserDefaultsManager.shared.loadImage(forKey: "userFaceImageData") {
            selfieImage.image = userImage
        }
        // Do any additional setup after loading the view.
    }
    
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Background Color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        self.present(colorPicker, animated: true)
      }

    @objc func openColorPicker() {
        presentColorPicker()
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

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    // Implement any necessary delegate methods if needed
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            let selectedColor = viewController.selectedColor
            updateSwatch(with: selectedColor)
        }
    
    private func updateSwatch(with color: UIColor) {
        // Update the next swatch view with the selected color
        if eyeColorSwatch.backgroundColor == nil {
            eyeColorSwatch.backgroundColor = color
        } 
        else if skinColorSwatch.backgroundColor == nil {
            skinColorSwatch.backgroundColor = color
        } 
        else if hairColorSwatch.backgroundColor == nil {
            hairColorSwatch.backgroundColor = color
        }
    }
}
