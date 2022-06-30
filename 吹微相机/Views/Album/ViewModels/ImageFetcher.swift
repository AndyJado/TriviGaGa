//
//  ImageFetcher.swift
//  TriviGaGa
//
//  Created by Andy Jado on 2022/6/30.
//

import SwiftUI
import AsyncCloudKit
import CloudKit



actor ImageActor {
    
    func queryDueItems(database: CKDatabase) async throws {
        
        
        let base = database
            .performQuery(ofType: "ToDoItem")
        
        for try await record in base {
            print(record.description)
        }
    }
    
    
}

struct ImageFetcher: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImageFetcher_Previews: PreviewProvider {
    static var previews: some View {
        ImageFetcher()
    }
}
