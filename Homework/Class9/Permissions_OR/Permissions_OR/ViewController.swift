//
//  ViewController.swift
//  Permissions_OR
//
//  Created by Oscar Rivera on 5/22/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
    }
    
    private let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func imageButtonPressed(_ sender: UIButton) {
//        imageView.backgroundColor = .yellow
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let takeAPhotoAction = UIAlertAction(title: "Take a Photo", style: .default) { [weak self] (_) in
            
//            self?.presentLibraryPhotoPicker(sourceType: UIImagePickerControllerSourceType.camera)
            self?.handleTakeAPhoto(sourceType: UIImagePickerControllerSourceType.camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] (_) in
            self?.presentLibraryPhotoPicker(sourceType: UIImagePickerControllerSourceType.photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(takeAPhotoAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func handleTakeAPhoto(sourceType: UIImagePickerControllerSourceType){
        if hasDeniedCameraAccess {
            presentCameraSettingsAlert()
        } else {
            presentLibraryPhotoPicker(sourceType: sourceType)
        }
    }
    
    private func presentLibraryPhotoPicker(sourceType: UIImagePickerControllerSourceType) {
        picker.allowsEditing = true
        picker.sourceType = sourceType
        if sourceType == UIImagePickerControllerSourceType.camera {
            picker.cameraCaptureMode = .photo
        }
        present(picker, animated: true, completion: nil)
    }
    
    private func presentCameraSettingsAlert() {
        let alert = UIAlertController(title: "Grand Access to Camera", message: "Would you like to jump?", preferredStyle: .alert)
        
        let sureAction = UIAlertAction(title: "Sure", style: .default) { [weak self](_) in
            self?.takeUserToSettings()
        }
        
        let noThanksAction = UIAlertAction(title: "No Thanks", style: .cancel, handler: nil)
        
        alert.addAction(sureAction)
        alert.addAction(noThanksAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func takeUserToSettings(){
        
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString){
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        imageView.image = originalImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController {
    
    var cameraPermissionStatus: AVAuthorizationStatus {
        let cameraMediaType = AVMediaType.video
        return AVCaptureDevice.authorizationStatus(for: cameraMediaType)
    }
    
    var hasDeniedCameraAccess: Bool {
        return cameraPermissionStatus == .denied
    }
    
}
