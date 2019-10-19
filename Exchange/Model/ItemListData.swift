//
//  ItemListData.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/18/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import Foundation
import Combine

class ItemListData: ObservableObject {

    var cancellable: AnyCancellable?
    
    var itemType: Int?
    
    var query: String? {
        didSet {
            page = 1
        }
    }
    
    var stopFetching = false
    
    var page: Int = 1
    
    let description: String
    
    init(query: String) {
        self.query = query
        self.itemType = nil
        self.description = "Search"
    }
    
    init(itemType: ItemCategoryConformable) {
        self.itemType = itemType.rawValue
        self.query = nil
        self.description = itemType.description
    }
    
    let didChange = PassthroughSubject<ItemListData, Never>()

    @Published var items: [Item] = [] {
        didSet {
            self.didChange.send(self)
        }
    }
    
    func getItems() {
        guard !stopFetching else { return }
        let currentPage = page
        self.cancellable = ItemQuery().getItems(itemType: itemType,
                                                query: query,
                                                page: page) { result in
            switch result {
            case .success(let items):
                if self.items.isEmpty {
                    self.items = items
                } else {
                    self.items.append(contentsOf: items)
                }
                if items.isEmpty {
                    print("Found nothing :/")
                    self.stopFetching = true
                }
                self.page = currentPage + 1
            default:
                self.items = []
            }
        }
    }
    
    func cancelRequest() {
        cancellable?.cancel()
    }
}
