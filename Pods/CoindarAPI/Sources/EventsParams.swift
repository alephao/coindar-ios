//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct EventsParams: Codable {

    public enum SortingOrder: Int, Codable {
        /// - Time: Newest to oldest
        /// - Numbers: Major to minor
        case descending = 0
        
        /// - Time: Oldest to newest
        /// - Numbers: Minor to major
        case ascending = 1
    }
    
    public enum SortableAttribute: String, Codable {
        /// Start date
        case dateStart = "date_start"
        
        /// Publication date
        case dateAdded = "date_added"
        
        /// Number of views
        /// - Attention
        ///    views accounting started in June 2018
        case views
    }
    
    /// Page number
    /// - Attention
    ///   - default on server: 1
    public let page: Int?
    
    /// Number of events per page
    /// - Attention
    ///   - possible values: 1 to 100
    ///   - default on server: 30
    public let pageSize: Int?
    
    /// The lower limit of the event start date
    /// - Attention
    ///    - default on server: Date of the first event on Coindar
    public let filterDateStart: Date?
    
    /// The upper date limit of the event start date
    /// - Attention
    ///    - default on server: Date of the last event on Coindar by the time of request
    public let filterDateEnd: Date?
    
    /// Cryptocurrencies Ids
    /// - Attention
    ///    - default on server: All coins
    public let filterCoins: [String]?
    
    /// Tags ids
    /// - Attention
    ///    - default on server: All tags
    public let filterTags: [String]?
    
    /// Attribute to sort by
    /// - Attention
    ///    - default on server:
    public let sortBy: SortableAttribute?
    
    /// Order of sorting
    /// - Attention
    ///    - default on server: descending (0)
    public let orderBy: SortingOrder?
    
    public init(page: Int? = nil,
                pageSize: Int? = nil,
                filterDateStart: Date? = nil,
                filterDateEnd: Date? = nil,
                filterCoins: [String]? = nil,
                filterTags: [String]? = nil,
                sortBy: SortableAttribute? = nil,
                orderBy: SortingOrder? = nil ) {
        self.page = page.flatMap { $0 > 0 ? pageSize : nil }
        self.pageSize = pageSize.flatMap { (1...100).contains($0) ? pageSize : nil }
        
        self.filterDateStart = filterDateStart
        self.filterDateEnd = filterDateEnd
        self.filterCoins = filterCoins
        self.filterTags = filterTags
        self.sortBy = sortBy
        self.orderBy = orderBy
    }
}
