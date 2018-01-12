import CoindarFoundation

class Networking {
    func getData<Target: API>(_ token: Target, callback: @escaping (Result<Data>) -> Void){
        
        let params = token.params

        let httpBody = params != nil
            ? try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            : nil

        var request = URLRequest(url: token.path)
        request.httpBody = httpBody
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

