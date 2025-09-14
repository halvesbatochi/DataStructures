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

// --- Grupo de Testes para a Operação 'append' ---
struct LinkedListAppendTests {
    
    @Test("Append em uma lista vazia deve se comportar como um push")
    func testAppendToEmptyList() {
        var list = LinkedList<Int>()
        list.append(1)
        
        #expect(!list.isEmpty)
        #expect(list.head?.value == 1, "Head deveria ser 1")
        #expect(list.tail?.value == 1, "Tail deveria ser 1")
        #expect(list.head === list.tail, "Head e Tail deveriam ser o mesmo nó")
    }
    
    @Test("Append deve adicionar um elemento ao final de uma lista populada")
        func testAppendToNonEmptyList() {
            var list = LinkedList<Int>()
            list.push(2)
            list.push(3)
            
            list.append(1)
            
            #expect(list.head?.value == 3, "Head não deveria mudar")
            #expect(list.tail?.value == 1, "O novo tail deveria ser 1")
            #expect(list.head?.next?.next === list.tail, "O último elemento da cadeia deve ser o tail")
        }
        
        @Test("Após múltiplos appends, a estrutura e descrição devem estar corretas")
        func testAppendMultipleValues() {
            var list = LinkedList<Int>()
            list.append(1)
            list.append(2)
            list.append(3)
            
            #expect(list.head?.value == 1)
            #expect(list.tail?.value == 3)
            #expect(list.head?.next?.value == 2)
            #expect(list.description == "1 -> 2 -> 3")
        }
}

// --- Grupo de Testes para a Função 'node(at:)' ---
struct LinkedListNodeAtTests {

    private var list: LinkedList<Int>
    
    init() {
        list = LinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
    }

    @Test("Deve encontrar o primeiro nó (head)")
    func testNodeAtFirstIndex() {
        #expect(list.node(at: 0)?.value == 1)
    }

    @Test("Deve encontrar um nó no meio da lista")
    func testNodeAtMiddleIndex() {
        #expect(list.node(at: 1)?.value == 2)
    }

    @Test("Deve encontrar o último nó (tail)")
    func testNodeAtLastIndex() {
        #expect(list.node(at: 2)?.value == 3)
    }

    @Test("Deve retornar nil para um índice fora dos limites")
    func testNodeAtOutOfBoundsIndex() {
        #expect(list.node(at: 99) == nil, "Índice muito alto deveria retornar nil")
    }
    
    @Test("Deve retornar nil ao buscar em uma lista vazia")
    func testNodeAtOnEmptyList() {
        let emptyList = LinkedList<Int>()
        #expect(emptyList.node(at: 0) == nil)
    }
}


// --- Grupo de Testes para a Função 'insert(_:after:)' ---
struct LinkedListInsertTests {
    
    @Test("Deve inserir um nó após o head da lista")
    func testInsertAfterHead() {
        var list = LinkedList<Int>()
        list.append(1)
        list.append(3)
        
        guard let node1 = list.node(at: 0) else {
            Issue.record("Falha ao obter o nó na posição 0")
            return
        }
        
        list.insert(2, after: node1)
        
        #expect(list.description == "1 -> 2 -> 3")
    }
    
    @Test("Deve inserir um nó no meio da lista")
    func testInsertInTheMiddle() {
        var list = LinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(4)
        
        guard let node2 = list.node(at: 1) else {
            Issue.record("Falha ao obter o nó na posição 1")
            return
        }
        
        list.insert(3, after: node2)
        
        #expect(list.description == "1 -> 2 -> 3 -> 4")
    }

    @Test("Inserir após o tail deve se comportar como append")
    func testInsertAfterTail() {
        var list = LinkedList<Int>()
        list.append(1)
        list.append(2)
        
        guard let tailNode = list.tail else {
            Issue.record("Falha ao obter o tail")
            return
        }
        
        list.insert(3, after: tailNode)
        
        #expect(list.description == "1 -> 2 -> 3")
        #expect(list.tail?.value == 3, "O tail da lista deveria ser atualizado para 3")
    }
    
    @Test("A função deve retornar o nó recém-criado")
    func testInsertReturnValue() {
        var list = LinkedList<Int>()
        list.append(1)
        
        let node1 = list.head!
        let insertedNode = list.insert(2, after: node1)
        
        #expect(insertedNode.value == 2)
        #expect(node1.next === insertedNode)
    }
}

// --- Grupo de Testes para a Função 'pop()' ---
struct LinkedListPopTests {

    @Test("Pop em uma lista com múltiplos elementos deve retornar o primeiro valor")
    func testPopOnNonEmptyList() {
        var list = LinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        
        let poppedValue = list.pop()
        
        #expect(poppedValue == 1, "O valor removido (pop) deveria ser o primeiro elemento, 1")
        #expect(list.head?.value == 2, "O novo heade da lista deveria ser 2")
        #expect(list.tail?.value == 3, "O tail da lista não devereia ser afetado")
        #expect(list.description == "2 -> 3", "A descrição da lista deve refletir a remoção")
    }
    
    @Test("Pop em uma lista com um único elemento deve esvaziá-la")
    func testPopOnSingleElementList() {
        var list = LinkedList<String>()
        list.append("único")
        
        let poppedValue = list.pop()
        
        #expect(poppedValue == "único", "O valor removido deveria ser 'único'")
        #expect(list.isEmpty, "A lista deveria ficar vazia após o pop")
        #expect(list.head == nil, "O head deveria se tornar nil")
        #expect(list.tail == nil, "O tail também deveria se tornar nil")
    }
    
    @Test("Pop em uma lista vazia deve retornar nil")
    func testPopOnEmptyList() {
        var list = LinkedList<Character>()
        
        let poppedValue = list.pop()
        
        #expect(poppedValue == nil, "O pop em uma lista vazia deve sempre retornar nil")
        #expect(list.isEmpty, "A lista deve continuar vazia")
    }
}

