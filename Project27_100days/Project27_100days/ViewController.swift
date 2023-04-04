//
//  ViewController.swift
//  Project27_100days
//
//  Created by user228564 on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentDrawType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true
            var length: CGFloat = 256

            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 4)

                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }

                length *= 0.99
            }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }

        imageView.image = img
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        imageView.image = img
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let eyeOffset = 50
            let eyeLeftX = 256 - eyeOffset - 20
            let eyeRightX = 256 + eyeOffset
            
            drawEye(ctx: ctx.cgContext, positionX: CGFloat(eyeLeftX), positionY: 200)
            drawEye(ctx: ctx.cgContext, positionX: CGFloat(eyeRightX), positionY: 200)
            drawMouthLine(ctx: ctx.cgContext)
            
        }
        imageView.image = image
    }
    
    func drawMouthLine(ctx: CGContext) {
        ctx.translateBy(x: 256, y: 256)
        ctx.move(to: CGPoint(x: -80, y: 100))
        ctx.addLine(to: CGPoint(x: 80, y: 100))
        
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokePath()
        ctx.translateBy(x: -256, y: -256)
    }
    
    func drawEye(ctx: CGContext, positionX: CGFloat, positionY: CGFloat) {
            let eye = CGRect(x: 0, y: 0, width: 40, height: 40)
            ctx.setFillColor(UIColor.black.cgColor)
            ctx.translateBy(x: positionX, y: positionY)
            ctx.addEllipse(in: eye)
            ctx.drawPath(using: .fill)
            ctx.translateBy(x: -positionX, y: -positionY)
    }
    
    
    
    func drawTwin() {
        let imageWidth = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageWidth, height: 512))
        let spacing = CGFloat((imageWidth - 128) / 4)
        let offset = CGFloat(64)
        let image = renderer.image { ctx in
            //let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            let letterPositionY = CGFloat(192)
            drawT(ctx: ctx.cgContext, positionX: offset + 0.5 * spacing, positionY: letterPositionY)
            drawW(ctx: ctx.cgContext, positionX: offset + 1.5 * spacing, positionY: letterPositionY)
            drawI(ctx: ctx.cgContext, positionX: offset + 2.5 * spacing, positionY: letterPositionY)
            drawN(ctx: ctx.cgContext, positionX: offset + 3.5 * spacing, positionY: letterPositionY)
        
            
        }
        imageView.image = image
    }
    
    func drawT(ctx: CGContext, positionX: CGFloat, positionY: CGFloat) {
        let width = CGFloat(64)
        let height = CGFloat(128)
        ctx.setFillColor(UIColor.black.cgColor)
        ctx.translateBy(x: positionX, y: positionY)
        ctx.move(to: CGPoint(x: -width / 2, y: 0))
        ctx.addLine(to: CGPoint(x: width / 2, y: 0))
        ctx.move(to: CGPoint(x: 0, y: 0))
        ctx.addLine(to: CGPoint(x: 0, y: height))
        UIColor.black.setStroke()
        ctx.setStrokeColor(UIColor.black.cgColor)
        //ctx.setLineWidth(5)
        ctx.strokePath()
        ctx.translateBy(x: -positionX, y: -positionY)
    }
    
    func drawW(ctx: CGContext, positionX: CGFloat, positionY: CGFloat) {
        ctx.setFillColor(UIColor.black.cgColor)
        let width = CGFloat(64/4)
        let height = CGFloat(128)
        ctx.translateBy(x: positionX, y: positionY)
        ctx.move(to: CGPoint(x: 0, y: 0))
        ctx.addLine(to: CGPoint(x: -width, y: height))
        ctx.addLine(to: CGPoint(x: -2*width, y: 0))
        ctx.move(to: CGPoint(x: 0, y: 0))
        ctx.addLine(to: CGPoint(x: width, y: height))
        ctx.addLine(to: CGPoint(x: 2*width, y: 0))
        
        UIColor.black.setStroke()
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokePath()
        ctx.translateBy(x: -positionX, y: -positionY)
    }
    
    func drawI(ctx: CGContext, positionX: CGFloat, positionY: CGFloat) {
        ctx.setFillColor(UIColor.black.cgColor)
        let height = CGFloat(128)
        ctx.translateBy(x: positionX, y: positionY)
        ctx.move(to: CGPoint(x: 0, y: 0))
        ctx.addLine(to: CGPoint(x: 0, y: height))
        UIColor.black.setStroke()
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokePath()
        ctx.translateBy(x: -positionX, y: -positionY)
    }
    
    func drawN(ctx: CGContext, positionX: CGFloat, positionY: CGFloat) {
        ctx.setFillColor(UIColor.black.cgColor)
        let width = CGFloat(64)
        let height = CGFloat(128)
        ctx.translateBy(x: positionX, y: positionY)
        ctx.move(to: CGPoint(x: -width / 2, y: height))
        ctx.addLine(to: CGPoint(x: -width / 2, y: 0))
        ctx.addLine(to: CGPoint(x: width / 2, y: height))
        ctx.addLine(to: CGPoint(x: width / 2, y: 0))
        
        UIColor.black.setStroke()
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokePath()
        ctx.translateBy(x: -positionX, y: -positionY)
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1

        if currentDrawType > 7 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawEmoji()
            //drawRectangle()

        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawTwin()

        default:
            break
        }
    }
}

