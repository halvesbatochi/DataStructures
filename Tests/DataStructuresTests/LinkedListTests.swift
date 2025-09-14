//
//  LinkedListTests.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 14/09/25.
//

import Testing
@testable import DataStructures

// --- Grupo de Testes para a Inicilização da Lista ---
struct LinkedListInitializationTests {
    
    @Test("Uma nova lista ligada deve estar vazia")
    func testInitiallyEmpty() {
        let list = LinkedList<Int>()
        
        #expect(list.isEmpty, "A lista deveria iniciar como ísEmpty = true")
        #expect(list.head == nil, "O 'head' de uma nova lista deveria ser nulo")
        #expect(list.tail == nil, "O 'tail' de uma nova lista deveria ser nulo")
    }
}

// --- Grupo de Testes para a Operação 'push' ---
struct LinkedListPushTests {
    
    @Test("Push em uma lista vazia deve definir head e tail")
    func testPushOnEmptyList() {
        var list = LinkedList<Int>()
        list.push(1)
        
        #expect(!list.isEmpty, "A lista não deveria estar vazia após um push")
        #expect(list.head?.value == 1, "O 'head' deveria ter o valor 1")
        #expect(list.tail?.value == 1, "O 'tail' também deveria ter o valor 1")
        #expect(list.head === list.tail, "Head e tail deveriam ser o mesmo nó")
    }

    @Test("Push deve adicionar elementos no início da lista")
    func testPushAddsToTheBeginning() {
        var list = LinkedList<Int>()
        list.push(1)
        list.push(2)
        
        #expect(list.head?.value == 2, "O novo 'head' deveria ser 2")
        #expect(list.head?.next?.value == 1, "O próximo do 'head'deveria ser 1")
        #expect(list.tail?.value == 1, "O 'tail' deveria permanecer como 1")
    }
    
    @Test("Após múltiplos pushes, a estrutura da lista deve estar correta")
    func testPushMultipleValues() {
        var list = LinkedList<Int>()
        list.push(1)
        list.push(2)
        list.push(3)
        
        #expect(list.head?.value == 3)
        #expect(list.head?.next?.value == 2)
        #expect(list.head?.next?.next?.value == 1)
        #expect(list.tail?.value == 1)
    }
}

// --- Grupo de Teste para a 'description' ---
struct LinkedListDescriptionTests {
    
    @Test("A descrição de uma lista vazia deve ser 'Empty list'")
    func testDescriptionForEmptyList() {
        let list = LinkedList<String>()
        
        #expect(list.description == "Empty list")
    }
    
    @Test("A descrição de uma lista populada deve mostrar todos os nós")
    func testDescriptionForPopulatedList() {
        var list = LinkedList<Int>()
        list.push(1)
        list.push(2)
        list.push(3)
        
        let expected = "3 -> 2 -> 1"
        #expect(list.description == expected)
    }
}
