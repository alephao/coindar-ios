import CoindarFoundation

class Networking {
    func getData<Target: API>(_ token: Target, callback: @escaping (Result<Data>) -> Void){
        
        var urlComponents = URLComponents(url: token.path, resolvingAgainstBaseURL: false)!
        
        let params = token.params?.map({ dict -> URLQueryItem in
            URLQueryItem(name: dict.key, value: dict.value)
        })
        
        urlComponents.queryItems = params

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse,
                let error: Error = (NetworkingError.Client(rawValue: response.statusCode) ?? NetworkingError.Server(rawValue: response.statusCode)) {
                ErrorHandler.defaultHandler.handle(error)
                callback(.error(error))
            } else if let error = error {
                ErrorHandler.defaultHandler.handle(error)
                callback(.error(error))
            } else if let data = data {
                callback(.success(data))
            } else {
                fatalError("No data, and no error :(")
            }
        }
        
        task.resume()
    }
}

