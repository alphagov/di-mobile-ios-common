import UIKit

/// View model for the `InstructionsWithImageViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is `NSAttributedString`
/// - `image` type is `UIImage`
/// - `warningButtonViewModel` type is ``ButtonViewModel``?
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
@MainActor
public protocol InstructionsWithImageViewModel {
    var title: GDSLocalisedString { get }
    var body: NSAttributedString { get }
    var image: UIImage { get }
    var warningButtonViewModel: ButtonViewModel? { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

public protocol InstructionsWithImageWithAltTextViewModel {
    var imageAltText: GDSLocalisedString { get }
}
