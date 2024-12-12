import GDSCommon
import UIKit

// Conforming to the new GDSCentreAligned protocols
struct MockGDSCentreAlignedViewModel: GDSCentreAlignedViewModel,
                                      GDSCentreAlignedViewModelWithImage,
                                      GDSCentreAlignedViewModelWithFootnote,
                                      GDSCentreAlignedViewModelWithPrimaryButton,
                                      GDSCentreAlignedViewModelWithSecondaryButton,
                                      GDSCentreAlignedViewModelWithChildView,
                                      BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = nil
    let title: GDSLocalisedString = "This is an Centre Aligned Screen title"
    let body: GDSLocalisedString? = "This is an (optional) Centre Aligned Screen body."
    let footnote: GDSLocalisedString = "This is an (optional) Centre Aligned Screen footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false

    func didAppear() {}

    func didDismiss() {}

    var childView: UIView {
        createChildView()
    }

    private func createChildView() -> UIView {
        let bulletView = BulletView(viewModel: MockBulletViewModel(title: "Optional child view - populated with a BulletView", titleFont: .body))
        let stackView = UIStackView(arrangedSubviews: [bulletView])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }
}
