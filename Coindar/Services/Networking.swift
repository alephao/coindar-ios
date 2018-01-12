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
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
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

