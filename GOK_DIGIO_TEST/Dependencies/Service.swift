import Foundation

enum ErrorType {
    case urlError
    case jsonError
    case statusCodeError(code: Int)
    case taskError(error: Error)
}

protocol ServiceProtocol {
    func loadDigioServices(url: String,
                           onComplete: @escaping (MainModel) -> Void,
                           onError: @escaping (ErrorType) -> Void)
}

final class Service: ServiceProtocol {
    static let session = URLSession.shared
    
    func loadDigioServices(url: String,
                           onComplete: @escaping (MainModel) -> Void,
                           onError: @escaping (ErrorType) -> Void) {
        guard
            let urlString = URL(string: url)
        else {
            onError(.urlError)
            return
        }
        
        let task = Service.session.dataTask(with: urlString) { data, response, error in
            if error == nil {
                guard
                    let response = response as? HTTPURLResponse
                else { return }
                switch response.statusCode {
                case 200:
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let servicesList = try decoder.decode(MainModel.self, from: data)
                        onComplete(servicesList)
                    } catch _ as NSError {
                        onError(.jsonError)
                    }
                default:
                    onError(.statusCodeError(code: response.statusCode))
                }
            } else {
                guard let taskError = error else { return }
                onError(.taskError(error: taskError))
            }
        }
        task.resume()
    }
}
