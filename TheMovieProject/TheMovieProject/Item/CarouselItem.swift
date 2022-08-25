import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let CAROUSELITEMNIB = "carouselItem"
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var image: UIImageView!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }

    convenience init(imageName: UIImage?, background: UIColor? = .red) {
        self.init()
        image.image = imageName
        vwBackground.backgroundColor = background
    }

    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
