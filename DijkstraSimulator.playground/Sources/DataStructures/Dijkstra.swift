import Foundation

public class Dijkstra: NSObject {
    var graph: Graph
    
    var distance : [Vertex:Int] = [:]
    var path : [Vertex:Vertex] = [:]
    var visitedVertexes : Set<Vertex> = Set<Vertex>()
    
    var heap: Heap<Vertex>? = nil
    
    public func run(source: Vertex, target: Vertex) -> (path:[Vertex],distance:Int){
        self.heap = Heap<Vertex>(comparer: { (a, b) -> Bool in
            return self.distance[a]! > self.distance[b]!
        })

        for vertex in self.graph.vertexes {
            self.distance[vertex] = Int.max
        }
        
        self.distance[source] = 0
        self.heap?.insert(elem: source)

        while !(self.heap!.isEmpty) {
            let node = self.heap?.remove()
            self.visitedVertexes.insert(node!)
            for edge in self.graph.edges{
                if edge.source == node! {
                    if self.distance[edge.destination]! > self.distance[node!]! + edge.weight{
                        self.distance[edge.destination] = self.distance[node!]! + edge.weight
                        self.path[edge.destination] = node!
                        self.heap?.insert(elem: edge.destination)
                    }
                }
            }
            
        }
        
        var paths : [Vertex] = []
        paths.append(target)
        var current = target
        while self.path[current]  != nil{
            paths.append(self.path[current]!)
            current = self.path[current]!
        }
        return (path: paths.reversed(), distance: self.distance[target]!)
    }
    
    public init(graph: Graph) {
        self.graph = graph
    }
    
    
    
}
