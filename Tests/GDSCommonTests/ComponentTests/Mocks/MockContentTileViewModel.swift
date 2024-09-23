import Foundation
import UIKit
import GDSCommon

struct MockContentTileViewModel: ContentTile {
    var image: UIImage = UIImage(named: "placeholder") ?? UIImage()
    var caption: GDSLocalisedString = "test caption"
    var title: GDSLocalisedString = "test title"
    var body: GDSLocalisedString = "test body"
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor? = .systemBackground
    var secondaryButtonViewModel: ButtonViewModel
    var primaryButtonViewModel: ButtonViewModel
    var closeButton: ButtonViewModel
}
