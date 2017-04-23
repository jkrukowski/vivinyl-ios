//
//  ViewController.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 22/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func didTapPhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraFlashMode = .off
        imagePicker.cameraCaptureMode = .photo
        imagePicker.cameraDevice = .rear
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(imagePicked, nil, nil, nil)
        dismiss(animated: true) { [weak self] in
            let controller = UploadViewController.instantiate(imagePicked)
            controller.didUpload = { [weak self] data in
                let resultController = ResultViewController.instantiate(data)
                self?.navigationController?.pushViewController(resultController, animated: true)
            }
            self?.present(controller, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

