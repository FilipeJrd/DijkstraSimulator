import Foundation
import UIKit

public class GraphView: UIView {
    
    var nodes : [(x:Int,y:Int)] = []
    var connections : [(origin:Int,destination:Int)] = []
    
    var nodeView  : UIView = UIView()
    var edgeView : UIView = UIView()
    
    
    var vertexes: [Vertex] = []
    var edges: [Edge] = []
    
    
    var nodeViews : [NodeView] = []
    var edgeViews : [EdgeView] = []
    
    var targetIndex : Int = -1
    var sourceIndex : Int = -1
    
    var isSource : Bool = true
    
    public var defaultNodeColor: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1){
        didSet{
            for view in self.nodeViews{
                view.backgroundColor = self.defaultNodeColor
            }
        }
    }
    public var sourceNodeColor: UIColor = #colorLiteral(red: 0, green: 0.6855617166, blue: 0.7909439206, alpha: 1)
    public var targetNodeColor: UIColor = #colorLiteral(red: 0.7605296969, green: 0.2022327185, blue: 0.6047860384, alpha: 1)
    
    public var pathEdgeColor: UIColor = #colorLiteral(red: 0.5764705882, green: 0.8728952844, blue: 0.3911756277, alpha: 1)
    public var defaultEdgeColor: UIColor = UIColor.white{
        
        didSet{
            for view in self.edgeViews{
                view.color = self.defaultEdgeColor
            }
        }
    }

    public convenience init(frame: CGRect, nodes:[(x:Int,y:Int)],connections:[(origin:Int,destination:Int)]){
        self.init(frame: frame)
        self.nodes = nodes
        
        var inversedConnections:[(origin:Int,destination:Int)] = []
        
        for connection in connections{
            inversedConnections.append((origin:connection.destination, destination: connection.origin))
        }
        
        self.connections = connections
        self.connections.append(contentsOf: inversedConnections)
        
        self.nodeView = UIView(frame: frame)
        self.edgeView = UIView(frame: frame)
        
        
        self.addSubview(self.nodeView)
        self.insertSubview(self.edgeView, belowSubview: self.nodeView)
        
        self.createNodes()
        self.createEdges()        
    }
    
    func createNodes(){
        for node in nodes {
            let viewzinea = NodeView(frame: CGRect(x: node.x, y: node.y, width: 20, height: 20))
            
            viewzinea.center.x = CGFloat(node.x)
            viewzinea.center.y = CGFloat(node.y)
            viewzinea.changedDelegate = self
            self.nodeView.addSubview(viewzinea)
            self.nodeViews.append(viewzinea)
            
            let vertex = Vertex(id:"\(node.x)   \(node.y)")
            vertexes.append(vertex)
        }
    }
    
    func createEdges(){
        for connection in connections {
            let first = nodes[connection.origin]
            let second = nodes[connection.destination]
            
            
            let edgev = EdgeView(frame: self.frame, x1: first.x, y1: first.y, x2: second.x, y2: second.y)
            self.edgeViews.append(edgev)
            self.edgeView.addSubview(edgev)
            
            
            let x = pow(Double(first.x - second.x), 2.0)
            let y = pow(Double(first.y - second.y), 2.0)
            let edge = Edge(id: "", source: vertexes[connection.origin], destination: vertexes[connection.destination], weight:
                Int(sqrt(x+y)))
            edges.append(edge)
        }
    }
    
    func getShortestPath()  {
        if self.sourceIndex >= 0 && self.targetIndex >= 0{
            let graph = Graph(vertexes: vertexes, edges: edges)
            let dijkstra = Dijkstra(graph: graph)
            
            let results = dijkstra.run(source: vertexes[self.sourceIndex], target: vertexes[self.targetIndex])
            
            var path : [Vertex] = results.path
            
            if path.count > 1{
                for i in 0...(path.count-2){
                    let first = path[i]
                    let second = path[i+1]
                    
                    let current = edges.filter({ (e) -> Bool in
                        return e.source == first && e.destination == second
                    }).first
                    let wrong = edges.filter({ (e) -> Bool in
                        return e.source == second && e.destination == first
                    }).first
                    
                    edgeViews[edges.index(of: wrong!)!].color = UIColor.clear
                    edgeViews[edges.index(of: current!)!].color = self.pathEdgeColor
                }
            }
        }
    }
}
extension GraphView : NodeChangedDelegate{
    public func didChange(sender: NodeView) {
        let index = self.nodeViews.index(of: sender)!
        self.nodes[index].x = Int(sender.center.x)
        self.nodes[index].y = Int(sender.center.y)
        self.updateEdgesConnected(to: sender)
    }
    
    public func endChange() {
        self.getShortestPath()
    }
    
    public func select(sender : NodeView) {
        let index = self.nodeViews.index(of: sender)!
        self.clear()
        if self.isSource {
            
            if self.sourceIndex >= 0{
                self.nodeViews[self.sourceIndex].backgroundColor = self.defaultNodeColor
            }
            self.sourceIndex = index
        }else{
            
            if self.targetIndex >= 0{
                self.nodeViews[self.targetIndex].backgroundColor = self.defaultNodeColor
            }
            self.targetIndex = index
            self.getShortestPath()
        }
        
        if self.targetIndex >= 0{
            self.nodeViews[self.targetIndex].backgroundColor = self.targetNodeColor
        }
        
        if self.sourceIndex >= 0 {
            self.nodeViews[self.sourceIndex].backgroundColor = self.sourceNodeColor
        }
        self.isSource = !self.isSource
    }
    
    func clear(){
        for edge in self.edgeViews{
            edge.color = self.defaultEdgeColor
        }
    }

    
    func updateEdgesConnected(to nodeView: NodeView){
        let node = self.vertexes[self.nodeViews.index(of: nodeView)!]
        for edge in self.edges{
            let edgeView = self.edgeViews[self.edges.index(of: edge)!]
            edgeView.color = self.defaultEdgeColor
            if(edge.destination == node){
                edgeView.x2 = Int(nodeView.center.x)
                edgeView.y2 = Int(nodeView.center.y)
            }else if(edge.source == node){
                edgeView.x1 = Int(nodeView.center.x)
                edgeView.y1 = Int(nodeView.center.y)
            }
            let x = pow(Double(edgeView.x1 - edgeView.x2), 2.0)
            let y = pow(Double(edgeView.y1 - edgeView.y2), 2.0)
            
            edge.weight = Int(sqrt(x+y))
        }
    }
}
