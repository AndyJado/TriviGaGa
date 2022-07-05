//
//  StackViewModel.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/17.
//

import SwiftUI
import CloudKit
import Combine
import AsyncCloudKit



class CKStackViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var inCards: [CKCard] = []
    @Published var isFetching = false
    
    
    
    @AppStorage("LovedOneName") var lovedOneName :String = ""
    @AppStorage("MiddleCode") var middleCode :String = ""
    @AppStorage("UserName") var userName: String = "reopen the sheet to refresh"
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func asyncFetch() async throws {
        Task{ @MainActor in
            self.isFetching.toggle()
        }
        
        let messageCode = lovedOneName + middleCode + userName
        let predicate = NSPredicate(format: "name = %@", argumentArray: [messageCode])
        let recordType = RecordType.OneWayMessage.rawValue
        let database = CKContainer.default().publicCloudDatabase
        
        for try await record in database
            .performQuery(ofType: recordType, where: predicate, orderBy: [NSSortDescriptor(key: "creationDate", ascending: false)]) {
            
            if let card = CKCard(record: record) {
                Task { @MainActor in
                    self.inCards.append(card)
                }
            }
        }
        
        Task{ @MainActor in
            self.isFetching.toggle()
        }
        
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let item = inCards[index]
        inCards.remove(at: index)
        CloudKitUtility.delete(item: item)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { success in
                print("DELETE IS: \(success)")
            }
            .store(in: &cancellables)
        
    }
    
}


