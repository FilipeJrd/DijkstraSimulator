import Foundation

public class Graph: NSObject {
    var vertexes : [Vertex]
    var edges : [Edge]
    
    public init(vertexes: [Vertex], edges: [Edge]) {
        self.vertexes = vertexes
        self.edges = edges
    }
    
    
}
