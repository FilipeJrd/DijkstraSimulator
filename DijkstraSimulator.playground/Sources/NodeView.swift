import Foundation
import UIKit

public class NodeView: UIView {
    public var changedDelegate : NodeChangedDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.layer.borderWidth = 0.5
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.tapCount == 2 {
            self.changedDelegate?.select(sender: self)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: superview)
            self.center = touchLocation
            self.changedDelegate?.didChange(sender: self)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changedDelegate?.endChange()
    }

}
