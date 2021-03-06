//  Copyright © 2017 Schibsted. All rights reserved.

import XCTest
@testable import Layout

class ColorExpressionTests: XCTestCase {

    func testRed() {
        let node = LayoutNode()
        let expression = LayoutExpression(colorExpression: "#f00", for: node)
        let expected = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(try expression.evaluate() as? UIColor, expected)
    }

    func testRedOrBlue() {
        let node = LayoutNode()
        let expression = LayoutExpression(colorExpression: "true ? #f00 : #00f", for: node)
        let expected = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(try expression.evaluate() as? UIColor, expected)
    }

    func testRedOrBlue2() {
        let node = LayoutNode(state: ["foo": true])
        let expression = LayoutExpression(colorExpression: "foo ? #f00 : #00f", for: node)
        let expected = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(try expression.evaluate() as? UIColor, expected)
    }

    func testNilColor() {
        let null: UIColor? = nil
        let node = LayoutNode(constants: ["color": null as Any])
        let expression = LayoutExpression(colorExpression: "color", for: node)
        XCTAssertThrowsError(try expression.evaluate()) { error in
            XCTAssert("\(error)".contains("nil"))
        }
    }

    func testRGBColorWithIntConstant() {
        let node = LayoutNode(constants: ["red": 255])
        let expression = LayoutExpression(colorExpression: "rgb(red,0,0)", for: node)
        XCTAssertEqual(try expression.evaluate() as? UIColor, .red)
    }

    func testSetBackgroundColor() {
        let node = LayoutNode(expressions: ["backgroundColor": "#f00"])
        let expected = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(node.view.backgroundColor, expected)
    }

    func testSetLayerBackgroundColor() {
        let node = LayoutNode(expressions: ["layer.backgroundColor": "#f00"])
        let expected = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        XCTAssertEqual(node.view.layer.backgroundColor, expected)
    }

    func testSetLayerBackgroundColorWithCGColorConstant() {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        let node = LayoutNode(
            constants: ["color": color],
            expressions: ["layer.backgroundColor": "color"]
        )
        XCTAssertEqual(node.view.layer.backgroundColor, color)
    }

    func testSetLayerBackgroundColorWithUIColorConstant() {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        let node = LayoutNode(
            constants: ["color": color],
            expressions: ["layer.backgroundColor": "color"]
        )
        XCTAssertEqual(node.view.layer.backgroundColor, color.cgColor)
    }
}
