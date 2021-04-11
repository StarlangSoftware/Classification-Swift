import XCTest
@testable import Classification

final class ClassificationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Classification().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
