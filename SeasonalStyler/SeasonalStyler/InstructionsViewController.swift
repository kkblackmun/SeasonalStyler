//
//  InstructionsViewController.swift
//  SeasonalStyler
//
//  Created by Kiyomi Blackmun on 4/22/24.
//

import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var instructionsText: UITextView!
    @IBOutlet weak var disclaimerText: UITextView!
    @IBOutlet weak var selfieImage: UIImageView!
    
    @IBOutlet weak var confirmImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the confirmation button to hidden initially
        //unhide after image is selected
        confirmImageButton.isHidden = true
        // Round the corners of the text view
        disclaimerText.layer.cornerRadius = 10
        disclaimerText.layer.masksToBounds = true
        
        instructionsText.layer.cornerRadius = 10 // Adjust the corner radius value as needed
        instructionsText.layer.masksToBounds = true

        // Do any additional setup after loading the view.
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
