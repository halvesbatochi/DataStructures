//
//  QueueLinkedList.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 20/09/25.
//

public class QueueLinkedList<T>: Queue {
    private var list = DoublyLinkedList<T>()
    public init() {}
    
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    public func dequeue() -> T? {
        guard !list.isEmpty else {
            return nil
        }
        return list.pop()
    }
    
    public var peek: T? {
        return list.first
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}
