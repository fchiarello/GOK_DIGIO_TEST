import Foundation
import UIKit

protocol ServiceDetailViewModelDelegate: AnyObject {
    func loadImage(image: UIImage)
    func loadLabels(title: String, description: String)
    func loadError()
}

final class ServiceDetailViewModel {
    private var model: ServiceDetailModel?
    
    weak var delegate: ServiceDetailViewModelDelegate?
    
    init(coordinator: Coordinator?, model: ServiceDetailModel? = nil) {
        self.model = model
    }
    
    func loadViewInformations() {
        if let model = self.model {
            guard
                let image = setupImage(strURL: model.imageURL)
            else { return }
            delegate?.loadImage(image: image)
            delegate?.loadLabels(title: model.title,
                                 description: model.description)
        } else {
            delegate?.loadError()
        }
    }
    
    private func setupImage(strURL: String) -> UIImage? {
        let defaultImage = UIImage(named: Constants.errorImage)
        if let url = URL(string: strURL) {
            do {
                let path = try Data(contentsOf: url)
                return UIImage(data: path)
            } catch {
                return defaultImage
            }
        } else {
            return defaultImage
        }
    }
}
