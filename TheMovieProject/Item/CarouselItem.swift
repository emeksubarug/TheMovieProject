import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let carouselItemNib = "carouselItem"

    // MARK: - Outlets

    @IBOutlet weak private var vwContent: UIView!
    @IBOutlet weak private var vwBackground: UIView!
    @IBOutlet weak private var image: UIImageView!

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

    private func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.carouselItemNib, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
