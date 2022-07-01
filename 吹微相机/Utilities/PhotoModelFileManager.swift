//
//  PhotoModelFileManager.swift
//  吹微相机
//
//  Created by Andy Jado on 2022/4/19.
//
import Foundation
import SwiftUI
import CoreMedia

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    
    let folderName = "downloaded_photos"
    
    private init() {
        creatFolderIfNeeded()
    }
    
    private func creatFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("created folder!")
            } catch let error {
                print("ERROR CREATING FOLRDER: \(error)")
            }
        }
        
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {return nil}
        
        return folder.appendingPathComponent(key + ".jpeg")
            
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.jpegData(compressionQuality: 0.5),
            let url = getImagePath(key: key)
        else {
            return
        }
        
        do {
            try data.write(to: url)
            print("saved to: \(url)")
        } catch let error {
            print("Error adding data to file:\(error)")
        }
    }
    
    func addImageData(key: String, data: Data?) {
        guard
            let data = data,
            let url = getImagePath(key: key)
        else {
            return
        }
        
        do {
            try data.write(to: url)
            print("saved to: \(url)")
        } catch let error {
            print("Error adding data to file:\(error)")
        }
    }
    
    func addCompressed(key: String, value: Photo!) {
        guard
            let data = value.compressedData,
            let url = getImagePath(key: key)
        else {
            return
        }
        
        do {
            try data.write(to: url)
            print("saved to: \(url)")
        } catch let error {
            print("Error adding data to file:\(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
        else {return nil}
        
        return UIImage(contentsOfFile: url.path)
    }
    
}
