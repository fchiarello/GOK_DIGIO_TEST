import Foundation
import UIKit

protocol DigioServicesViewModelDelegate {
    func successList()
    func errorList()
}

final class DigioServicesViewModel {
    private var service: ServiceProtocol?
    
    var spotlights: [Spotlight]?
    var products: [Product]?
    var cash: Cash?
    var delegate: DigioServicesViewModelDelegate?
    
    init(coordinator: Coordinator, service: ServiceProtocol? = nil) {
        self.service = service
    }
    
    func loadServices() {
        service?.loadDigioServices(url: Constants.url, onComplete: { (services) in
            self.spotlights = services.spotlight
            self.products = services.products
            self.cash = services.cash
            self.delegate?.successList()
        }, onError: { _ in
            self.delegate?.errorList()
        })
    }
    
    func setupCashLabel() -> NSAttributedString {
        let txt = self.cash?.title
        let split = txt?.split(regex: " ")
        
        let firstStr = split?.first ?? String()
        let secondStr = split?[1] ?? String()
        
        let string = NSMutableAttributedString()
        let attibutes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17),
                          NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor(red: 44.0/255.0, green: 50.0/255.0, blue: 70.0/255.0, alpha: 1)]
        let attibutes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 17),
                          NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.lightGray]
        
        string.append(NSAttributedString(string: firstStr, attributes: attibutes1))
        string.append(NSAttributedString(string: " \(secondStr)", attributes: attibutes2))
        return string
    }
    
    func setupCashImage() -> UIImage? {
        if let strURL = cash?.bannerURL {
            guard
                let url = URL(string: strURL)
            else { return nil }
            do {
                let path = try Data(contentsOf: url)
                return UIImage(data: path)
            } catch {
                return UIImage(named: Constants.errorImage)
            }
        } else {
            return UIImage(named: Constants.errorImage)
        }
    }
}
