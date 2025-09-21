//
//  DoublyLinkedList.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 21/09/25.
//

import Foundation

public class DoublyListNode<Value> {
    public var value: Value
    public var next: DoublyListNode<Value>?
    public weak var previous: DoublyListNode<Value>?

    public init(value: Value) {
        self.value = value
    }
}

extension DoublyListNode: CustomStringConvertible {
    public var description: String {
        return "\(value)"
    }
}

public struct DoublyLinkedList<Value> {
    
    private class Storage {
        var head: DoublyListNode<Value>?
        var tail: DoublyListNode<Value>?
        
        init(head: DoublyListNode<Value>? = nil, tail: DoublyListNode<Value>? = nil) {
            self.head = head
            self.tail = tail
        }
    }
    
    private var _storage: Storage
    
    public var head: DoublyListNode<Value>? {
        get { return _storage.head }
        set { _storage.head = newValue }
    }
    
    public var tail: DoublyListNode<Value>? {
        get { return _storage.tail }
        set { _storage.tail = newValue }
    }
    
    public init() {
        _storage = Storage()
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&_storage) else {
            return
        }
        
        guard let oldHead = head else {
            _storage = Storage()
            return
        }
        
        let newHead = DoublyListNode(value: oldHead.value)
        var newNode = newHead
        var oldNode = oldHead
        
        while let nextOldNode = oldNode.next {
            let nextNewNode = DoublyListNode(value: nextOldNode.value)
            newNode.next = nextNewNode
            nextNewNode.previous = newNode
            newNode = nextNewNode
            oldNode = nextOldNode
        }
        
        _storage = Storage(head: newHead, tail: newNode)
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        let newNode = DoublyListNode(value: value)
        newNode.next = head
        head?.previous = newNode
        head = newNode
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        
        let newNode = DoublyListNode(value: value)
        tail?.next = newNode
        newNode.previous = tail
        tail = newNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: DoublyListNode<Value>) -> DoublyListNode<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        let newNode = DoublyListNode(value: value)
        newNode.next = node.next
        newNode.previous = node
        node.next?.previous = newNode
        node.next = newNode
        
        return newNode
    }
    
    // --- Operações de Remoção ---
    
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            head?.previous = nil
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        guard let tail = tail else {
            return nil
        }
        guard tail.previous != nil else {
            return pop()
        }
        
        let value = tail.value
        let previousNode = tail.previous
        previousNode?.next = nil
        self.tail = previousNode
        
        return value
    }
    
    @discardableResult
    public mutating func remove(after node: DoublyListNode<Value>) -> Value? {
        copyNodes()
        guard let removedNode = node.next else {
            return nil
        }
        
        removedNode.next?.previous = node
        node.next = removedNode.next
        
        if removedNode === tail {
            tail = node
        }
        
        return removedNode.value
    }
    
    @discardableResult
    public mutating func remove(_ node: DoublyListNode<Value>) -> Value? {
        copyNodes()
        guard let head = head else { return nil }

        if node === head {
            return pop()
        }

        if node === tail {
            return removeLast()
        }

        node.previous?.next = node.next
        node.next?.previous = node.previous
        
        return node.value
    }
    
    public func node(at index: Int) -> DoublyListNode<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    
    public var description: String {
            guard let head = head else {
                return "Empty list"
            }
            
            var description = "Head -> "
            var currentNode: DoublyListNode? = head
            while let node = currentNode {
                let previousValue = node.previous?.value
                let nextValue = node.next?.value
                
                let prevString = previousValue != nil ? "\(previousValue!)" : "nil"
                let nextString = nextValue != nil ? "\(nextValue!)" : "nil"
                
                description += "(\(prevString) <- \(node.value) -> \(nextString))"
                
                if node.next != nil {
                    description += " <-> "
                }
                currentNode = node.next
            }
            description += " <- Tail"
            
            return description
        }
}

extension DoublyLinkedList: Collection {
    public struct Index: Comparable {
        public var node: DoublyListNode<Value>?
        
        public static func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left === right
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        public static func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}
