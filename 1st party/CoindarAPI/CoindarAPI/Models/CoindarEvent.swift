import CoindarFoundation

public struct CoindarEvent: Decodable {
    
    public struct Formatters {
        /// yyyy-mm-dd HH: MM
        static let ymdTime = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm")

        // yyyy-MM-dd
        static let ymd = DateFormatter(dateFormat: "yyyy-MM-dd")
        
        // yyyy-MM
        static let ym = DateFormatter(dateFormat: "yyyy-MM")
        
        static func anyDate(from string: String) -> Date? {
            return ymdTime.date(from: string) ?? ymd.date(from: string) ?? ym.date(from: string)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case caption
        case proof
        case publicDate = "public_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case coinName = "coin_name"
        case coinSymbol = "coin_symbol"
    }
    
    public let caption: String
    public let proof: String
    public let publicDate: Date
    public let startDate: Date
    public let endDate: Date?
    public let coinName: String
    public let coinSymbol: String
    
    public var eventAddedCaption: String {
        let hours = Int(abs(publicDate.timeIntervalSinceNow) / 3600)
        let days = hours / 24
        
        return days >= 1
            ? "\(days) day\(days > 1 ? "s" : "")"
            : "\(hours) hour\(hours > 1 ? "s" : "")"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        caption = try values.decode(String.self, forKey: .caption)
        proof = try values.decode(String.self, forKey: .proof)
        
        let publicDateString = try values.decode(String.self, forKey: .publicDate)
        guard let publicDate = Formatters.anyDate(from: publicDateString) else {
            throw DecodingError.dataCorruptedError(forKey: .publicDate, in: values, debugDescription: "Wrong date format: \(publicDateString)")
        }
        self.publicDate = publicDate

        let startDateString = try values.decode(String.self, forKey: .startDate)
        guard let startDate = Formatters.anyDate(from: startDateString) else {
            throw DecodingError.dataCorruptedError(forKey: .startDate, in: values, debugDescription: "Wrong date format: \(startDateString)")
        }
        self.startDate = startDate
        
        let endDateString = try values.decode(String.self, forKey: .endDate)
        endDate = Formatters.anyDate(from: endDateString)
        
        coinName = try values.decode(String.self, forKey: .coinName)
        coinSymbol = try values.decode(String.self, forKey: .coinSymbol)
    }
}
