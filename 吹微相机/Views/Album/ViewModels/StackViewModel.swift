//
//  StackViewModel.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/17.
//

import SwiftUI
import CloudKit
import Combine




class CKStackViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var inCards: [CKCard] = []
    
    @AppStorage("LovedOneName") var lovedOneName :String = ""
    @AppStorage("MiddleCode") var middleCode :String = ""
    @AppStorage("UserName") var userName: String = "reopen the sheet to refresh"
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
//        fetchItems()
        
    }
    
    func fetchItems() {
//        let predicate = NSPredicate(value: true)
        let messageCode = lovedOneName + middleCode + userName
        let predicate = NSPredicate(format: "name = %@", argumentArray: [messageCode])
        let recordType = RecordType.OneWayMessage.rawValue
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType,sortDescriptions: [NSSortDescriptor(key: "creationDate", ascending: false)])
            .receive(on: DispatchQueue.main)
            .sink { res in
                switch res {
                    case .failure(let error):
                        print("CKFETCH: \(error)")
                    case.finished:
                        print("CloudKitUtility.fetch finished! ")
                        HapticManager.instance.notification(type: .error)
                }
            } receiveValue: { [weak self] returnedItems in
                self?.inCards = returnedItems
            }
            .store(in: &cancellables)
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


