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
                self?.showData(data)
            }
            self?.present(controller, animated: true)
        }
    }
    
    fileprivate func showData(_ data: [ResultModel]) {
        guard !data.isEmpty else {
            showEmpty()
            return
        }
        let resultController = ResultViewController.instantiate(data)
        navigationController?.pushViewController(resultController, animated: true)
    }
    
    fileprivate func showEmpty() {
        let alert = UIAlertController(title: "Empty", message: "Did not find anything", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

