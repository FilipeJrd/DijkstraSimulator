import UIKit
import PlaygroundSupport
/*:
 ## Dijkstra Algorithm 
 
 Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph.
 
 This Playground is a simple visual implementation of the Dijkstra Algorithm, with the purpose of visualizing a graph and the shortest path between any pair of its nodes.
 
 Feel free to create, remove or modify the existing nodes and their connections. Create any graph you want and find out which is the shortest path between any two nodes.

 ### Controls
 - Choose the **source** or **destination** by **double tapping** the selected node.
 
 - If you want to change the **position** of a existing node just **drag** it to the desired location.
 
 ### Nodes
 Each node is represented by a tuple of its coordinates (x and y)
*/
var nodes = [(x:500,y:350),(x:100,y:200),(x:300,y:50),(x:200,y:400),(x:300,y:400),(x:550,y:500),(x:350,y:250)]


/*:
 ### Connections
 Each connection is represented by a tuple of integers. Each value of the tuple is the index of a element in the nodes list. The weight of a connection is the distance between the two nodes that are connected.
 */
var connections = [(origin:0,destination:1),(origin:1,destination:3),(origin:2,destination:3),(origin:1,destination:2),(origin:1,destination:4),(origin:3,destination:4),(origin:5,destination:0),(origin:3,destination:5),(origin:4,destination:6),(origin:2,destination:6)]

var graph = GraphView(frame: CGRect(x:0,y:0,width:600,height:600), nodes: nodes, connections: connections)

/*:
 ### Colors
 Experiment changing the colors of the graph to your liking.
 */
graph.backgroundColor = #colorLiteral(red: 0.119810544, green: 0.1677933335, blue: 0.217716068, alpha: 1)

graph.defaultEdgeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
graph.pathEdgeColor = #colorLiteral(red: 0.5764705882, green: 0.8728952844, blue: 0.3911756277, alpha: 1)

graph.defaultNodeColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
graph.sourceNodeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
graph.targetNodeColor = #colorLiteral(red: 0.7605296969, green: 0.2022327185, blue: 0.6047860384, alpha: 1)

PlaygroundPage.current.liveView = graph

