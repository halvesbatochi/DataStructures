//
//  DoublyLinkedListTest.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 21/09/25.
//

import Testing
@testable import DataStructures

struct DoublyLinkedListTests {
    
    @Test("Inicialização da Lista Duplamente Encadeada")
    func testInitialization() {
        let list = DoublyLinkedList<Int>()
        
        #expect(list.isEmpty, "A lista deve estar vazia quando inicializada.")
        #expect(list.head == nil, "A cabeça da lista deve ser nil.")
        #expect(list.tail == nil, "A cauda da lista deve ser nil.")
    }
    
    @Test("Push - Inserir no início")
    func testPush() {
        var list = DoublyLinkedList<Int>()
        
        list.push(1)
        #expect(list.head?.value == 1, "O head deve ter o valor 1.")
        #expect(list.tail?.value == 1, "O tail deve ter o valor 1.")
        #expect(list.head?.previous == nil, "O previous do head deve ser nil.")
        
        list.push(2)
        #expect(list.head?.value == 2, "O novo head deve ter o valor 2.")
        #expect(list.head?.next?.value == 1, "O próximo nó do head deve ser o antigo head (valor 1).")
        #expect(list.head?.next?.previous === list.head, "O nó com valor 1 deve apontar para o novo head.")
        #expect(list.tail?.value == 1, "O tail deve permanecer com o valor 1.")
    }
    
    @Test("Append - Adicionar no final")
    func testAppend() {
        var list = DoublyLinkedList<Int>()
        
        list.append(1)
        #expect(list.head?.value == 1, "O head deve ter o valor 1.")
        #expect(list.tail?.value == 1, "O tail deve ter o valor 1.")
        
        list.append(2)
        #expect(list.tail?.value == 2, "O novo tail deve ter o valor 2.")
        #expect(list.tail?.previous?.value == 1, "O previous do novo tail deve ser o antigo tail.")
        #expect(list.tail?.previous?.next === list.tail, "O nó com valor 1 deve apontar para o novo tail.")
        #expect(list.head?.value == 1, "O head deve permanecer com o valor 1.")
    }
    
    @Test("Pop - Remover do início")
    func testPop() {
        var list = DoublyLinkedList<Int>()
        list.push(1)
        list.push(2)
        
        let removedValue = list.pop()
        
        #expect(removedValue == 2, "O valor removido deve ser 2.")
        #expect(list.head?.value == 1, "O novo head deve ser 1.")
        #expect(list.head?.previous == nil, "O previous do novo head deve ser nil.")
        #expect(list.tail?.value == 1, "O tail deve permanecer 1.")
        
        let removedValue2 = list.pop()
        #expect(removedValue2 == 1, "O valor removido deve ser 1.")
        #expect(list.isEmpty, "A lista deve estar vazia após a remoção do último elemento.")
        #expect(list.head == nil, "O head deve ser nil.")
        #expect(list.tail == nil, "O tail deve ser nil.")
    }
    
    @Test("RemoveLast - Remover do final")
    func testRemoveLast() {
        var list = DoublyLinkedList<Int>()
        list.push(1)
        list.push(2)
        list.push(3)
        
        let removedValue = list.removeLast()
        
        #expect(removedValue == 1, "O valor removido deve ser o último (1).")
        #expect(list.tail?.value == 2, "O novo tail deve ser 2.")
        #expect(list.head?.value == 3, "O head deve permanecer 3.")
        #expect(list.tail?.next == nil, "O next do novo tail deve ser nil.")
        
        let removedValue2 = list.removeLast()
        #expect(removedValue2 == 2, "O valor removido deve ser 2.")
        #expect(list.tail?.value == 3, "O novo tail deve ser 3.")
        #expect(list.tail?.previous == nil, "O previous do novo tail deve ser nil.")
        
        let removedValue3 = list.removeLast()
        #expect(removedValue3 == 3, "O valor removido deve ser 3.")
        #expect(list.isEmpty, "A lista deve estar vazia.")
    }

    @Test("Insert After - Inserir depois de um nó")
    func testInsertAfter() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(3)
        
        let node1 = list.node(at: 0)!
        _ = list.insert(2, after: node1)
        
        #expect(node1.next?.value == 2, "O nó 2 deve ser inserido depois do nó 1.")
        #expect(node1.next?.next?.value == 3, "O nó 3 deve ser o próximo do nó 2.")
        #expect(node1.next?.previous === node1, "O previous do nó 2 deve ser o nó 1.")
        #expect(list.tail?.previous?.value == 2, "O previous do tail (3) deve ser 2.")
    }
    
    @Test("Remove After - Remover depois de um nó")
    func testRemoveAfter() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
        
        let node1 = list.node(at: 0)!
        let removedValue = list.remove(after: node1)
        
        #expect(removedValue == 2, "O valor removido deve ser 2.")
        #expect(node1.next?.value == 3, "O próximo do nó 1 deve ser o nó 3.")
        #expect(list.tail?.previous === node1, "O previous do tail (3) deve ser o nó 1.")
        #expect(list.count == 2, "A lista deve ter 2 elementos.")
    }

    @Test("Remove - Remover um nó do meio")
    func testRemoveMiddleNode() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
        
        let middleNode = list.node(at: 1)!
        let removedValue = list.remove(middleNode)
        
        #expect(removedValue == 2, "O valor removido deve ser 2.")
        #expect(list.head?.next?.value == 3, "O próximo do head (1) deve ser 3.")
        #expect(list.tail?.previous?.value == 1, "O previous do tail (3) deve ser 1.")
        #expect(list.count == 2, "A lista deve ter 2 elementos.")
    }
}
