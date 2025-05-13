//
//  ImageCaptureViewController.swift
//  JSZindigi
//
//  Created by Umar Awais on 19/09/2023.
//

import UIKit

enum ImageCaptureMode: Equatable {
//    case cnicFront
//    case cnicBack
//    case parentCnicFront
//    case parentCnicBack
//    case formB
    case selfie
    case general(title: String = "")
}

class ImageCaptureViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var captureButton: UIButton! {
        didSet {
            captureButton.isEnabled = false
            captureButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        }
    }
    
    var captureMode: ImageCaptureMode!
    var completion: ((UIImage?) -> Void)!
    var onBack: (() -> Void)!
    private var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIData()
    }
    
    @IBAction func backAction() {
        onBack()
    }
}

// MARK: UI Methods
extension ImageCaptureViewController {
    private func setupUIData() {
        overlayImageView.isHidden = false
        switch captureMode {
        case .selfie:
            overlayImageView.isHidden = true
            titleLabel.text = "Capture"
        case .general(let title):
            overlayImageView.isHidden = true
            titleLabel.text = title
        case .none:
            break
        }
        setupCamera()
    }

    private func setupCamera() {
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerController.CameraDevice.rear) {
            captureButton.isEnabled = true
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = captureMode == .selfie ? .front : .rear
            imagePicker.showsCameraControls = false
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            cameraContainerView.addSubview(imagePicker.view)
            imagePicker.view.frame = cameraContainerView.bounds
            cameraContainerView.clipsToBounds = true
            let screenBounds = view.window?.screen.bounds.size ?? view.bounds.size
            let scale = screenBounds.height / screenBounds.width
            imagePicker.cameraViewTransform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            
            Utility.showWarningAlert(message: "Camera is not avealable")
//            Task.delayed(byTimeInterval: 0.5) { [weak self] in
//                await MainActor.run { [weak self] in
//                    self?.showAlert(title: Constants.errorTitle, message: "Camera is unavailable.", titleAnimation: LottieFile.error.rawValue) { [weak self] in
//                        self?.onBack()
//                    }
//                }
//            }
        }
    }
    
    @objc func captureImage() {
        imagePicker.takePicture()
    }
}

// MARK: ImagePicker Delegate
extension ImageCaptureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        completion(info[.originalImage] as? UIImage)
    }
}
