import Foundation
import UIKit

public class EdgeView : UIView {
    public var x1 : Int = 0{
        didSet{
            self.weightLabel.text = "\(self.weight)"
            self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
            self.setNeedsDisplay()
        }
    }
    
    public var y1 : Int = 0{
        didSet{
            self.weightLabel.text = "\(self.weight)"
            self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
            self.setNeedsDisplay()
        }
    }
    
    public var x2 : Int = 0{
        didSet{
            self.weightLabel.text = "\(self.weight)"
            self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
            self.setNeedsDisplay()
        }
    }
    
    public var y2 : Int = 0 {
        didSet{
            self.weightLabel.text = "\(self.weight)"
            self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
            self.setNeedsDisplay()
        }
    }
    
    public var color : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1){
        didSet{
            
            self.weightLabel.text = "\(self.weight)"
            self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
            self.setNeedsDisplay()
        }
    }
    
    var weight : Int {
        get{
            return Int(sqrt(pow(Double(x1-x2), 2.0) + pow(Double(y1-y2), 2.0)))
        }
    }
    
    var weightLabel : UILabel
    
    public convenience init(frame: CGRect, x1: Int, y1: Int, x2: Int, y2: Int) {
        self.init(frame:frame)
        self.weightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 22))
        
        self.weightLabel.center = CGPoint(x: abs(x1+x2)/2, y: abs(y1+y2)/2)
        
        self.weightLabel.layer.backgroundColor   = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).withAlphaComponent(0.3).cgColor
        self.weightLabel.layer.cornerRadius = 5
        self.weightLabel.textAlignment = .center
        
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
        
        self.weightLabel.text = "\(self.weight)"
        self.addSubview(self.weightLabel)
    }
    
    public override init(frame: CGRect) {
        self.weightLabel = UILabel()
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(self.color.cgColor)
            context.setLineWidth(3)
            context.beginPath()
            context.move(to: CGPoint(x: self.x1, y: self.y1))
            context.addLine(to: CGPoint(x: self.x2 , y: self.y2))
            context.strokePath()
        }
    }
}
