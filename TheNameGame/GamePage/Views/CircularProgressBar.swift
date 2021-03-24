//
//  CircularProgressBar.swift
//  TheNameGame
//
//  Created by Lynk on 3/24/21.
//

import UIKit

//Delegate method to alert GameViewController that the timer has ended
protocol CircularProgressBarDelegate: AnyObject {
    func timerEnded()
}

//Custom Circular Progress Bar
class CircularProgressBar: UIView {
    
    private var customBackgroundColor = UIColor(red: 226/255, green: 233/255, blue: 238/255, alpha: 1)
    private var progressColor = UIColor(red: 28/255, green: 102/255, blue: 155/255, alpha: 1)
    private var ringWidth: CGFloat = 3
    
    private var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Layers to create progress bar
    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    
    weak var delegate: CircularProgressBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        backgroundColor = customBackgroundColor
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    //Draw Progress
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .square
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = progressColor.cgColor
    }

    //Internal timer set for 1 minute
    //Updates progress every 0.1 of a second for smoother animation
    func startTimer() {
        var secondsPast: CGFloat = 0.0
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] (timer) in
            guard let self = self else { return }
            secondsPast += 0.1
            self.progress = secondsPast/60.0
            
            //due to float addition, 60 seconds may end up as 60.00058
            //check for equal or greater to solve
            if secondsPast >= 60.0 {
                timer.invalidate()
                self.delegate?.timerEnded()
            }
        }
    }
}
