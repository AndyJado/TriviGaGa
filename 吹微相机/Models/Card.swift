//
//  Card.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/9.
//

import Foundation
import SwiftUI
import CloudKit

struct CKCard: Hashable,CloudKitableProtocol {
    
    let name: String
    let imageURL: URL?
    let record: CKRecord
    
    init?(record: CKRecord) {
        guard let name = record["name"] as? String else { return nil }
        self.name = name
        let imageAsset = record["image"] as? CKAsset
        self.imageURL = imageAsset?.fileURL
        self.record = record
    }
    
    init?(name: String, imageURL: URL?,recordName:String) {
        let record = CKRecord(recordType: recordName)
        record["name"] = name
        if let url = imageURL {
            let asset = CKAsset(fileURL: url)
            record["image"] = asset
        }
        self.init(record: record)
    }
    
}

struct Card {
    let name: String
    let picture: Image
    
    static let example = Card(name: "小王", picture: Image(systemName: "sunrise.fill"))
    
    
}

extension Card {
    static func cardGen(total i:Int) -> [Card] {
        var cards: [Card] = []
        for k in 1...i {
            cards.append(Card(name:"\(i)", picture: Image(systemName: "\(k).circle")))
        }
        return cards
            
    }
}

struct UrlCard {
    let name: String
    let imageURL: URL
    
    init?(record: CKRecord) {
        guard let name = record["name"] as? String else { return nil }
        self.name = name
        guard
            let imageAsset = record["image"] as? CKAsset,
            let url = imageAsset.fileURL
        else { return nil }
        self.imageURL = url
    }
    
    init(name: String, url: URL) {
        self.name = name
        self.imageURL = url
    }
    
}

extension UrlCard {
    
    static let exampleUrlCard = UrlCard(name: "TestUrlCard", url: URL(string: "https://via.placeholder.com/600/92c952")!)
}

