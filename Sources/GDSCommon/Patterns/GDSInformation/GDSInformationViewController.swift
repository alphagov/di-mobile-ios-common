import UIKit

/// View controller for `GDSInformation` screen
///     - `informationImage` (type: `String`)
///     - `titleLabel` (type: `UILabel`)
///     - `bodyLabel` (type: `UILabel`)
///     - `footnoteLabel`  (type: `UILabel`)
///     - `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///     - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
public final class GDSInformationViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "GDSInformation" }
    
    public private(set) var viewModel: GDSInformationViewModel

    private let defaultImageHeight: CGFloat = 55
    private let imagePaddingCompensation: CGFloat = 11
    
    public init(viewModel: GDSInformationViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSInformation", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var informationImage: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: viewModel.imageWeight ?? .semibold)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            informationImage.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
            informationImage.tintColor = viewModel.imageColour ?? .gdsPrimary
            informationImage.accessibilityIdentifier = "information-image"
            
            let heightConstraint: CGFloat
            
            if let value = viewModel.imageHeightConstraint {
                heightConstraint = value + imagePaddingCompensation
            } else {
                heightConstraint = defaultImageHeight
            }
            
            NSLayoutConstraint.activate([
                    informationImage.heightAnchor.constraint(greaterThanOrEqualToConstant: heightConstraint)
            ])
        }
    }
    
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "information-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let bodyContent = viewModel.body {
                bodyLabel.text = bodyContent.value
            } else {
                bodyLabel.isHidden = true
            }
            bodyLabel.accessibilityIdentifier = "information-body"
        }
    }

    /// Stack View: `UIStackView`. Any `UIView` which is on the `GDSInformationViewModelWithChildView` view model's `childView` property.
    /// This will be added to the `stackView` below the existing `bodyLabel`
    @IBOutlet private var stackView: UIStackView! {
        didSet {
            if let viewModel = viewModel as? GDSInformationViewModelChildView {
                stackView.addArrangedSubview(viewModel.childView)
            }
            stackView.accessibilityIdentifier = "information-optional-stack-view"
        }
    }
    
    @IBOutlet private var footnoteLabel: UILabel! {
        didSet {
            if let footnoteContent = viewModel as? GDSInformationViewModelFootnote {
                footnoteLabel.font = .init(style: .footnote)
                footnoteLabel.text = footnoteContent.footnote.value
                
                if #available(iOS 15.0, *) {
                    footnoteLabel.maximumContentSizeCategory = .accessibilityMedium
                }
            } else {
                footnoteLabel.isHidden = true
            }
            footnoteLabel.accessibilityIdentifier = "information-footnote"
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            if let buttonViewModel = viewModel as? GDSInformationViewModelPrimaryButton {
                primaryButton.setTitle(buttonViewModel.primaryButtonViewModel.title.value, for: .normal)
            } else {
                primaryButton.isHidden = true
            }
            primaryButton.accessibilityIdentifier = "information-primary-button"
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel as? GDSInformationViewModelPrimaryButton {
            buttonViewModel.primaryButtonViewModel.action()
        }
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel as? GDSInformationViewModelSecondaryButton {
                secondaryButton.setTitle(buttonViewModel.secondaryButtonViewModel.title.value, for: .normal)
                secondaryButton.titleLabel?.textAlignment = .center
                
                if let icon = buttonViewModel.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "information-secondary-button"
        }
    }

    @IBAction private func secondaryButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel as? GDSInformationViewModelSecondaryButton {
            buttonViewModel.secondaryButtonViewModel.action()
        }
    }
}
