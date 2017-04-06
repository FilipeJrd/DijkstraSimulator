import Foundation

public class Edge: NSObject {
    public var id: String
    public var source: Vertex
    public var destination: Vertex
    public var weight: Int
    
    public init(id: String, source: Vertex, destination: Vertex, weight: Int) {
        self.id = id
        self.source = source
        self.destination = destination
        self.weight = weight
    }
}
