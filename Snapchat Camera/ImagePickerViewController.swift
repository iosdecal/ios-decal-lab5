//
//  ImagePickerViewController.swift
//  Snapchat Camera Lab
//
//  Created by Paige Plander on 3/11/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

// TODO: you'll need to import a library here
import UIKit

// TODO: you'll need to edit this line to make your class conform to the AVCapturePhotoCaptureDelegate protocol
class ImagePickerViewController: UIViewController {

    @IBOutlet weak var imageViewOverlay: UIImageView!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var sendImageButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // The image to send as a Snap
    var selectedImage = UIImage()
    
    // TODO: add your instance methods for photo taking here
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // TODO: call captureNewSession here
        
        toggleUI(isInPreviewMode: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide the navigation bar while we are in this view
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectImage(_ image: UIImage) {
        //The image being selected is passed in as "image".
        selectedImage = image
    }
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        // TODO: Replace the following code as per instructions in the spec.
        // Instead of sending a squirrel pic every time, here we will want
        // to start the process of creating a photo from our photoOutput
        if let squirrelImage = UIImage(named: "squirrel") {
            selectedImage = squirrelImage
            toggleUI(isInPreviewMode: true)
        }
    }
    
    
    /// If the front camera is being used, switches to the back camera,
    /// and vice versa
    ///
    /// - Parameter sender: The flip camera button in the top left of the view
    @IBAction func flipCamera(_ sender: UIButton) {
        // TODO: allow user to switch between front and back camera
        // you will need to create a new session using 'captureNewSession'
    }

    
    
    /// Toggles the UI depending on whether or not the user is
    /// viewing a photo they took, or is currently taking a photo.
    ///
    /// - Parameter isInPreviewMode: true if they just took a photo (and are viewing it)
    func toggleUI(isInPreviewMode: Bool) {
        if isInPreviewMode {
            imageViewOverlay.image = selectedImage
            takePhotoButton.isHidden = true
            sendImageButton.isHidden = false
            cancelButton.isHidden = false
            flipCameraButton.isHidden = true
            
        }
        else {
            takePhotoButton.isHidden = false
            sendImageButton.isHidden = true
            cancelButton.isHidden = true
            imageViewOverlay.image = nil
            flipCameraButton.isHidden = false
        }
        
        // Makes sure that all of the buttons appear in front of the previewLayer
        view.bringSubview(toFront: imageViewOverlay)
        view.bringSubview(toFront: sendImageButton)
        view.bringSubview(toFront: takePhotoButton)
        view.bringSubview(toFront: flipCameraButton)
        view.bringSubview(toFront: cancelButton)
    }
    
    @IBAction func cancelButtonWasPressed(_ sender: UIButton) {
        selectedImage = UIImage()
        toggleUI(isInPreviewMode: false)
    }
    
    @IBAction func sendImage(_ sender: UIButton) {
        performSegue(withIdentifier: "imagePickerToChooseThread", sender: nil)
    }
    
    // Called when we unwind from the ChooseThreadViewController
    @IBAction func unwindToImagePicker(segue: UIStoryboardSegue) {
        toggleUI(isInPreviewMode: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
        let destination = segue.destination as! ChooseThreadViewController
        destination.chosenImage = selectedImage
        toggleUI(isInPreviewMode: false)
    }
}
