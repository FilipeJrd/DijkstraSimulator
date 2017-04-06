import Foundation

public class Heap<T:Hashable>: NSObject{
    private var elements : [T] = []
    private var comparer : (T,T) -> Bool
    
    public var isEmpty: Bool{
        get{
            return elements.isEmpty
        }
    }
    public init(comparer : @escaping (T,T) -> Bool) {
        self.comparer = comparer
        self.elements = []
        super.init()
    }
    
    
    
    public func insert(elem: T) {
        self.elements.append(elem)
        
        var i = self.elements.count - 1
        
        while ((i >= 0)  && (self.comparer(self.elements[self.father(index: i)],elem))) {
            swapIndexes(self.father(index: i), i)
            
            i = self.father(index: i)
        }
    }
    
    public func remove() -> T? {
        if !self.elements.isEmpty {
            let firstElem = self.elements.removeFirst()
        
            self.heapify(index: 0)
        
            return firstElem
        }
        return nil
    }
    
    private func father(index: Int) -> Int{
        return Int(floor(Double(index/2)))
    }
    
    private func swapIndexes(_ a : Int, _ b: Int){
        let first = self.elements[a]
        let second = self.elements[b]
        
        self.elements[a] = second
        self.elements[b] = first

    }
    
    private func heapify(index: Int){
        var adequate = index
        
        let nextChild = (index > 0) ? (2 * index) : 1
        
        let left = nextChild
        let right = nextChild + 1
        
        let length = self.elements.count - 1
        
        if ((left <= length)
            && comparer( self.elements[adequate], self.elements[left])){
            
            adequate = left
        }
        
        if ((right <= length)
            && comparer( self.elements[adequate], self.elements[right])){
            
            adequate = right
        }
        
        
        if adequate != index{
            self.swapIndexes(index, adequate)
            heapify(index: adequate)
        }
    }
    
}
