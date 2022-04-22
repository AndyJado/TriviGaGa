//
//  ContentView.swift
//  SwiftCamera
//
//  Created by Rolando Rodriguez on 10/15/20.
//

import SwiftUI
import Combine
import AVFoundation

final class CameraModel: ObservableObject {
    private let service = CameraService()
    
    @Published var photo: Photo!
    
    @Published var showAlertError = false
    
    @Published var isFlashOn = false
    
    @Published var willCapturePhoto = false
    
    var alertError: AlertError!
    
    var session: AVCaptureSession
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo = pic
        }
        .store(in: &self.subscriptions)
        
        service.$shouldShowAlertView.sink { [weak self] (val) in
            self?.alertError = self?.service.alertError
            self?.showAlertError = val
        }
        .store(in: &self.subscriptions)
        
        service.$willCapturePhoto.sink { [weak self] (val) in
            self?.willCapturePhoto = val
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        service.checkForPermissions()
        service.configure()
    }
    
    func capturePhoto() {
        service.capturePhoto()
    }
    
    func flipCamera() {
        service.changeCamera()
    }

}

struct CameraView: View {
    
    @StateObject var model = CameraModel()
    @State private var CurrentCamFlag:Bool = true
    var flipCameraButton: some View {
        Button(action: {
            model.flipCamera()
            CurrentCamFlag.toggle()
        }) {
            Circle()
                .foregroundColor(Color.black.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: CurrentCamFlag ? "eyes" : "person")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Theme.wheat.mainColor))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                SmallPhotoView(photo: $model.photo)
                Spacer()
                ToggleButton(action: {model.capturePhoto()})
                    .onAppear { model.configure()}
                    .alert(isPresented: $model.showAlertError, content: {
                        Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                            model.alertError.primaryAction?()
                        }))
                    })
                Spacer()
                flipCameraButton
                
            }
            .padding(.horizontal, 30)
            

        }
    }
}

struct CameraView_Preview: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
