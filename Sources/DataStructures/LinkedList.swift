//
//  LinkedList.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 14/09/25.
//

import Foundation

public struct LinkedList<Value> {
    
    private class Storage {
        var head: Node<Value>?
        var tail: Node<Value>?
        
        init(head: Node<Value>? = nil, tail: Node<Value>? = nil) {
            self.head = head
            self.tail = tail
        }
    }
    
    private var _storage: Storage
    
    public var head: Node<Value>? {
        get { return _storage.head }
        set { _storage.head = newValue }
    }
    
    public var tail: Node<Value>? {
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

        guard var oldNode = head else {
            _storage = Storage()
            return
        }
        
        var newHead = Node(value: oldNode.value)
        var newNode = newHead
        
        while let nextOldNode = oldNode.next {
            newNode.next = Node(value: nextOldNode.value)
            newNode = newNode.next!
            oldNode = nextOldNode
        }
        
        _storage = Storage(head: newHead, tail: newNode)
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
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
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodes()
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}
    

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left === right
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
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
