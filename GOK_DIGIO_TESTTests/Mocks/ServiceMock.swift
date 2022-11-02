import Foundation
@testable import GOK_DIGIO_TEST

class ServiceMock: ServiceProtocol {
    var spotlightArray:[Spotlight] = []
    var productArray:[Product] = []

    func loadDigioServices(url: String, onComplete: @escaping (GOK_DIGIO_TEST.MainModel) -> Void, onError: @escaping (GOK_DIGIO_TEST.ErrorType) -> Void) {
            let path = Bundle.main.path(forResource: "mockJson", ofType: "json")
            let urlPath = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try JSONDecoder().decode(MainModel.self, from: data)
            onComplete(result)
        } catch {
            onError(.jsonError)
        }
    }
}
