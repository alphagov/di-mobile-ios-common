@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class InstructionsWithImageViewControllerTests: XCTestCase {
    var buttonViewModel: ButtonViewModel!
    var warningButtonViewModel: ButtonViewModel!
    var viewModel: InstructionsWithImageViewModel!
    var sut: InstructionsWithImageViewController!
    
    var screenDidAppear = false
    var screenDidDismiss = false

    var didTapPrimaryButton = false
    var didTapSecondaryButton = false
    var didTapWarningButton = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = MockInstructionsWithImageViewModel(warningButtonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                                   shouldLoadOnTap: false,
                                                                                                   action: { self.didTapWarningButton = true }),
                                                       primaryButtonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                                   shouldLoadOnTap: false,
                                                                                                   action: { self.didTapPrimaryButton = true }),
                                                       secondaryButtonViewModel: MockButtonViewModel(title: "Secondary Button",
                                                                                                     shouldLoadOnTap: false,
                                                                                                     action: { self.didTapSecondaryButton = true }), 
                                                       rightBarButtonTitle: "close",
                                                       screenView: {
            self.screenDidAppear = true
        }, dismissAction: {
            self.screenDidDismiss = true
        })
        
        sut = InstructionsWithImageViewController(viewModel: viewModel)
        
        attachToWindow(viewController: sut)
    }
    
    override func tearDown() {
        buttonViewModel = nil
        warningButtonViewModel = nil
        viewModel = nil
        sut = nil
    
        super.tearDown()
    }
}

extension InstructionsWithImageViewControllerTests {
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.viewDidAppear(false)
        XCTAssertTrue(screenDidAppear)
    }
    
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "close")

        XCTAssertFalse(screenDidDismiss)

        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(screenDidDismiss)
    }
    
    func test_backButton() {
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    func test_labelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "This is the Instructions with image view")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "We can use this body to provide details or context as to what we want the users to do")
        XCTAssertEqual(try sut.bodyLabel.textColor, .gdsGrey)
    }
    
    func test_imageView() throws {
        XCTAssertNotNil(try sut.imageView)
    }
    
    func test_primaryButton() throws {
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Action Button")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapPrimaryButton)
    }
    
    func test_secondaryButton() throws {
        XCTAssertNotNil(try sut.secondaryButton)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary Button")
        XCTAssertEqual(try sut.secondaryButton.backgroundColor, nil)
        
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapSecondaryButton)
    }
    
    func test_warningButton() throws {
        XCTAssertNotNil(try sut.warningButton)
        XCTAssertEqual(try sut.warningButton.title(for: .normal), "Action Button")
        XCTAssertEqual(try sut.warningButton.backgroundColor, nil)
        
        try sut.warningButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapWarningButton)
    }
}

extension InstructionsWithImageViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "bodyLabel"])
        }
    }
    
    var imageView: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "imageView"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "secondaryButton"])
        }
    }
    
    var warningButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "warningButton"])
        }
    }
}
