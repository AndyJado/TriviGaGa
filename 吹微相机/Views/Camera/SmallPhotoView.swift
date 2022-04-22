//
//  SmallPhotoView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/19.
//

import SwiftUI
import CloudKit

struct SmallPhotoView: View {
    
    @Binding var photo: Photo?
    
    @AppStorage("LovedOneName") var lovedOneName :String = ""
    @AppStorage("MiddleCode") var middleCode :String = ""
    @AppStorage("UserName") var userName: String = "defaultUserNameUndifined"
    
    
    let manager = PhotoModelFileManager.instance
    
    var body: some View {
        Group {
            if let img = photo?.thumbnailImage {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.white)
                    .opacity(0.1)
            }
        }
        .onChange(of: photo) { newValue in
            guard let photo = newValue else {
                return
            }
            let takeTime = Date()
                .formatted(date: .omitted, time: .standard)
                .description
//            manager.add(key: "\(takeTime)", value: img)
            manager.addCompressed(key: "\(takeTime)", value: photo)
            DispatchQueue.global(qos: .utility).async {
                guard let url = manager.getImagePath(key: takeTime) else {return}
                
                let outCKname = userName + middleCode + lovedOneName
                let recordName = RecordType.OneWayMessage.rawValue
                CloudKitUtility.add(item: CKCard(name: outCKname, imageURL: url, recordName: recordName)!) { result in
                    switch result {
                        case.success(let bool):
                            bool ? HapticManager.instance.notification(type: .success) : HapticManager.instance.notification(type: .warning)
                        case.failure(let error):
                            HapticManager.instance.notification(type: .error)
                            print("ADD CLOUD ERROR: \(error)")
                            
                    }
                    
                }
            }
        }
    }
}

struct SmallPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SmallPhotoView(photo: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
