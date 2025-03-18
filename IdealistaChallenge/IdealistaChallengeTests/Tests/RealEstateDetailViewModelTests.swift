//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 18/3/25.
//

import XCTest
@testable import IdealistaChallenge

final class RealEstateDetailViewModelTests: XCTestCase {
    
    private var viewModel: RealEstateDetailViewModel!
    private var mockInteractor: MockRealStateInteractor!
    private var mockCoordinator: MockCoordinator!
    
    override func setUp() {
        super.setUp()
        
        mockInteractor = MockRealStateInteractor()
        mockCoordinator = MockCoordinator()
        
        viewModel = RealEstateDetailViewModel(
            interactor: mockInteractor,
            coordinator: mockCoordinator
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
        mockCoordinator = nil
        
        super.tearDown()
    }
    
    func testLoadPropertyDetail_Success() async {
        
        let expectedDetail = RealEstateDetail.realEstateDetail1
        mockInteractor.mockDetailRealEstateResult = .success(expectedDetail)
        
        await viewModel.loadPropertyDetail()
        
        XCTAssertEqual(viewModel.realEstateDetail?.adid, expectedDetail.adid)
        XCTAssertEqual(viewModel.realEstateDetail?.propertyType, expectedDetail.propertyType)
        XCTAssertEqual(viewModel.realEstateDetail?.propertyComment, expectedDetail.propertyComment)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isEmptySourceData)
        
        if case .contentView = viewModel.contentState {
            // Correcto, es lo que esperamos
            
        } else {
            XCTFail("Expected contentState to be .contentView, but got \(viewModel.contentState)")
        }
    }
    
    func testLoadPropertyDetail_Failure() async {
        
        let expectedError = NSError(domain: "test.error", code: 404, userInfo: nil)
        mockInteractor.mockDetailRealEstateResult = .failure(expectedError)
        
        await viewModel.loadPropertyDetail()
        
        XCTAssertNil(viewModel.realEstateDetail)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual((viewModel.error as NSError?)?.domain, expectedError.domain)
        XCTAssertEqual((viewModel.error as NSError?)?.code, expectedError.code)
        
        // Verificar el estado de contenido
        if case .error = viewModel.contentState {
            // Correcto, es lo que esperamos
        } else {
            XCTFail("Expected contentState to be .error, but got \(viewModel.contentState)")
        }
    }
    
    func testLoadingState() async {
        
        let expectation = XCTestExpectation(description: "Loading state should be set to true during fetch")
        
        // Configure to provide delayed results
        let expectedDetail = RealEstateDetail.realEstateDetail1
        mockInteractor.mockDetailRealEstateResult = .success(expectedDetail)
        mockInteractor.addDelay = true
        
        // When - Start observing loading state
        var loadingObserved = false
        
        // Use a detached task to monitor the loading state
        Task.detached {
            
            try? await Task.sleep(nanoseconds: 10_000_000) // Small delay to ensure loading starts
            if self.viewModel.isLoading {
                loadingObserved = true
            }
            expectation.fulfill()
        }
        
        // Start the actual loading
        await viewModel.loadPropertyDetail()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertTrue(loadingObserved)
        XCTAssertFalse(viewModel.isLoading) // Should be false after completion
        
        // Verificar que el contentState no es loading después de completar
        if case .loading = viewModel.contentState {
            XCTFail("ContentState should not be .loading after completion")
        }
    }
}

class MockCoordinator: Coordinator {
    
    var navigateToDetailCalled = false
    var startCalled = false
    
    func start() {
        startCalled = true
    }
    
    func navigate(to route: NavigationRoute) {
        if case .propertyDetailSwiftUI = route {
            navigateToDetailCalled = true
        }
    }
}
