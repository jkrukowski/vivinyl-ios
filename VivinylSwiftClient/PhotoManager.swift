//
//  PhotoManager.swift
//  VivinylSwiftClient
//
//  Created by Janek Krukowski on 22/04/2017.
//  Copyright © 2017 Janek Krukowski. All rights reserved.
//

import Foundation
import UIKit


final class PhotoViewController: UIViewController {
    
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(imagePicked, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
