//
//  ViewController.swift
//  Project27.1
//
//  Created by Maks Vogtman on 20/03/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawrect()
    }

    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawrect()
            
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
    
    
    func drawrect() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 26, dy: 26)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addRect(rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 27, dy: 27)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 62, y: row * 62, width: 62, height: 62))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = .pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                ctx.cgContext.strokePath()
            }
        }
        
        imageView.image = image
    }
    
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
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
        
        imageView.image = image
    }
    
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "That's what I did with Paul. Now it's time for my challenges!"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 175))
        }
        
        imageView.image = image
    }
    
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectColor = UIColor.systemYellow
            rectColor.setFill()
            
            let rect = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 25, dy: 25)
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.fillPath()
            
            let eyeColor = UIColor.gray
            eyeColor.setFill()
            
            let eyeSize = CGRect(x: 0, y: 0, width: rect.size.width * 0.15, height: rect.size.height * 0.15)
            
            let leftEye = CGRect(x: 140, y: 150, width: eyeSize.width, height: eyeSize.height)
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.fillPath()
            
            let rightEye = CGRect(x: 300, y: 150, width: eyeSize.width, height: eyeSize.height)
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.fillPath()
            
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let smile = CGMutablePath()
            let smileColor = UIColor.black
            smileColor.setFill()
            smileColor.setStroke()
            
            smile.move(to: CGPoint(x: 150, y: 350))
            smile.addQuadCurve(to: CGPoint(x: 360, y: 350), control: CGPoint(x: 260, y: 450))
            
            ctx.cgContext.addPath(smile)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(8)
            
            ctx.cgContext.move(to: CGPoint(x: 140, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: -10, y: 150))
            ctx.cgContext.move(to: CGPoint(x: 65, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 65, y: 300))
            
            ctx.cgContext.move(to: CGPoint(x: 200, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 150, y: 150))
            ctx.cgContext.move(to: CGPoint(x: 250, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 300))
            ctx.cgContext.move(to: CGPoint(x: 300, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 250, y: 150))
            ctx.cgContext.move(to: CGPoint(x: 350, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 300, y: 300))
            
            ctx.cgContext.move(to: CGPoint(x: 375, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 375, y: 300))
            
            ctx.cgContext.move(to: CGPoint(x: 400, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 400, y: 300))
            ctx.cgContext.move(to: CGPoint(x: 475, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 400, y: 150))
            ctx.cgContext.move(to: CGPoint(x: 475, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 475, y: 300))
            
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
}
