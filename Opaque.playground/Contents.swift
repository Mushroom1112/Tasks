import UIKit

/*
 Create a Shape protocol with methods to calculate the area and perimeter of different shapes. Use opaque types to return different shapes, and implement a calculateShapeDetails function that prints the area and perimeter.
 Steps:
 1) Define a protocol Shape with methods area() and perimeter().
 2) Implement two classes, Circle and Rectangle, that conform to Shape.
 3) Implement a function generateShape that has Shape return type, but under hood creates a Circle with radius 5.
 4) Implement the function calculateShapeDetails that returns tuple of the area and perimeter of a shape.
 */

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

class Circle: Shape {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        return .pi * radius * radius
    }

    func perimeter() -> Double {
        return 2 * .pi * radius
    }
}

class Rectangle: Shape {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        return width * height
    }

    func perimeter() -> Double {
        return 2 * (width + height)
    }
}

func generateShape() -> some Shape {
    return Circle(radius: 5)
}

func calculateShapeDetails(shape: Shape) -> (area: Double, perimeter: Double) {
    let area = shape.area()
    let perimeter = shape.perimeter()
    return (area, perimeter)
}
