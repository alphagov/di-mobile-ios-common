import GDSCommon
import UIKit

// Conforming to the GDSInformationViewModel deprecated protocol
struct MockGDSInformationViewModel: GDSInformationViewModel,
                                    BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = nil
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an (optional) Information View body."
    let footnote: GDSLocalisedString? = "This is an (optional) Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}

// Conforming to the deprecated GDSInformationViewModelV2 protocol
struct MockGDSInformationViewModelV2: GDSInformationViewModelV2,
                                      GDSInformationViewModelWithFootnote,
                                      GDSInformationViewModelPrimaryButton,
                                      GDSInformationViewModelWithSecondaryButton,
                                      GDSInformationViewModelWithChildView,
                                      BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = nil
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an (optional) Information View body."
    let footnote: GDSLocalisedString = "This is an (optional) Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView {
        createChildView()
    }
     
    func didAppear() { }
    
    func didDismiss() { }
    
    private func createChildView() -> UIView {
        let body = UILabel()
        body.text = GDSLocalisedString(stringLiteral: "This is a child view which can be populated with text or components").value
        body.adjustsFontForContentSizeCategory = true
        body.font = .body
        body.numberOfLines = 0
        body.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [body])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }
}
