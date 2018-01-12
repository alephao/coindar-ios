public protocol API {
    var baseURL: URL { get }
    var path: URL { get }
    var params: [String: String]? { get }
}
