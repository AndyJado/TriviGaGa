//
//  AsyncCamView.swift
//  TriviGaGa
//
//  Created by Andy Jado on 2022/7/1.
//

import SwiftUI

struct AsyncCamView: View {
    
    @StateObject private var model = CamDataModel()
    @State private var CurrentCamFlag:Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ThumbNailView(photo: $model.thumbnailImage, imageData: $model.ImageData)
                Spacer()
                TakeButton
                Spacer()
                flipCameraButton
                
            }
            .padding(.horizontal, 30)
        }
        .task {
            await model.camera.start()
        }
    }
}

extension AsyncCamView {
    
    var flipCameraButton: some View {
        Button(action: {
            model.camera.switchCaptureDevice()
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
    
    var TakeButton: some View {
        Button(action: {model.camera.takePhoto()}) {
                Circle()
                .foregroundColor(Theme.wheat.mainColor)
                    .frame(width: 80, height: 80, alignment: .center)
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.8), lineWidth: 2)
                            .frame(width: 65, height: 65, alignment: .center)
                    )
        }
    }
    
    
}



struct AsyncCamView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncCamView()
    }
}
