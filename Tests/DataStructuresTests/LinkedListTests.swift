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

// --- Grupo de Testes para a Função 'removeLast()' ---
struct LinkedListRemoveLastTests {
    
    @Test("Remover o último de uma lista com múltiplos elementos")
    func testRemoveLastOnMultiElementList() {
        var list = LinkedList<Int>()
        list.append(10)
        list.append(20)
        list.append(30)
        
        let removedValue = list.removeLast()
        
        #expect(removedValue == 30, "O valor removido deveria ser 30")
        #expect(list.tail?.value == 20, "O novo tail da lista deveria ser 20")
        #expect(list.head?.value == 10, "O head da lista não deveria mudar")
        #expect(list.description == "10 -> 20", "A descrição deve refletir a lista atualizada")
    }
    
    @Test("Remover o último de uma lista com um único elemento")
    func testRemoveLastOnSingleElementList() {
        var list = LinkedList<String>()
        list.append("item único")
        
        let removedValue = list.removeLast()
        
        #expect(removedValue == "item único", "O valor removido deveria ser 'item único'")
        #expect(list.isEmpty, "A lista deveria ficar vazia")
        #expect(list.head == nil, "O head deveria se tornar nil")
        #expect(list.tail == nil, "O tail também deveria se tornar nil")
    }
    
    @Test("Remover o último de uma lista vazia deve retornar nil")
    func testRemoveLastOnEmptyList() {
        var list = LinkedList<Double>()
        
        let removedValue = list.removeLast()
        
        #expect(removedValue == nil, "Chamar removeLast() em uma lista vazia deve retornar nil")
        #expect(list.isEmpty, "A lista deve continuar vazia")
    }
}

// --- Grupo de Testes para a Função 'remove(after:)' ---
struct LinkedListRemoveAfterTests {
    
    @Test("Remover um nó do meio da lista")
    func testRemoveAfterMiddleNode() {
        var list = LinkedList<Int>()
        list.append(10)
        list.append(20)
        list.append(30)
        list.append(40)
        
        guard let node20 = list.node(at: 1) else {
            Issue.record("Falha ao obter o nó na posição 1, que deveria existir.")
            return
        }
        
        let removedValue = list.remove(after: node20)
        
        #expect(removedValue == 30, "O valor removido deveria ser 30")
        #expect(list.description == "10 -> 20 -> 40", "A lista deve pular o nó 30")
        #expect(list.head?.value == 10, "O head não deve ser afetado")
        #expect(list.tail?.value == 40, "O tail não deve ser afetado")
    }
    
    @Test("Remover o último nó (tail) deve atualizar o tail")
    func testRemoveLastNodeUpdatesTail() {
        var list = LinkedList<String>()
        list.append("A")
        list.append("B")
        list.append("C")
        
        guard let nodeB = list.node(at: 1) else {
            Issue.record("Falha ao obter o nó na posição 1")
            return
        }
        
        let removedValue = list.remove(after: nodeB)
        
        #expect(removedValue == "C", "O valor removido deveria ser 'C'")
        #expect(list.tail?.value == "B", "O novo tail da lista deveria ser 'B'")
        #expect(list.description == "A -> B", "A descrição deve refletir a remoção do último nó")
        #expect(list.tail === nodeB, "A propriedade tail deve apontar para o próprio nó 'B'")
    }
    
    @Test("Tentar remover após o último nó não deve fazer nada e retornar nil")
    func testRemoveAfterTailNode() {
        var list = LinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
        
        guard let tailNode = list.tail else {
            Issue.record("Falha ao obter o tail da lista")
            return
        }
        
        let removedValue = list.remove(after: tailNode)
        
        #expect(removedValue == nil, "Deveria retornar nil, pois não há nó após o tail")
        #expect(list.description == "1 -> 2 -> 3", "A lista não deveria ser modificada")
    }
}

// --- Grupo de Testes para a Conformidade com 'Collection' ---
struct LinkedListCollectionTests {
    
    
    @Test("Propriedades startIndex e endIndex")
    func testStartAndEndIndex() {
        var list = LinkedList<Int>()
        list.append(10)
        list.append(20)
        
        #expect(list.startIndex.node === list.head, "O startIndex deve apontar para o head")
        #expect(list.endIndex.node === nil, "O endIndex deve apontar para nil (após o tail)")
        
        let emptyList = LinkedList<Int>()
        
        #expect(emptyList.startIndex == emptyList.endIndex, "Em uma lista vazia, os índices de início e fim devem ser iguais")
    }
    
    @Test("Avançando o índice com index(after:)")
    func testIndexAfter() {
        var list = LinkedList<Character>()
        list.append("A")
        list.append("B")
        list.append("C")
        
        let startIndex = list.startIndex
        let secondIndex = list.index(after: startIndex)
        let thirdIndex = list.index(after: secondIndex)
        
        #expect(list[startIndex] == "A")
        #expect(list[secondIndex] == "B")
        #expect(list[thirdIndex] == "C")
    }
    
    @Test("Acessando valores via subscript")
    func testSubscript() {
        var list = LinkedList<Int>()
        list.append(100)
        list.append(200)
        
        let firstValue = list[list.startIndex]
        let secondValue = list[list.index(after: list.startIndex)]
        
        #expect(firstValue == 100)
        #expect(secondValue == 200)
    }
    
    @Test("Conformidade com Collection habilita métodos como map, filter e count")
        func testHigherOrderFunctions() {
            var list = LinkedList<Int>()
            list.append(1)
            list.append(2)
            list.append(3)
            list.append(4)
            
            let mappedArray = list.map { $0 * 10 }
            #expect(mappedArray == [10, 20, 30, 40], "A função map deve funcionar corretamente")

            let filteredArray = list.filter { $0 % 2 != 0 }
            #expect(filteredArray == [1, 3], "A função filter deve funcionar corretamente")
            
            #expect(list.count == 4, "A propriedade count deve estar disponível e correta")
            
            let emptyList = LinkedList<Int>()
            #expect(emptyList.count == 0, "O count de uma lista vazia deve ser 0")
        }
        
        @Test("Iteração com laço for-in")
        func testForInLoop() {
            var list = LinkedList<String>()
            list.append("Um")
            list.append("Dois")
            list.append("Três")
            
            var result: [String] = []
            
            for item in list {
                result.append(item)
            }

            #expect(result == ["Um", "Dois", "Três"], "O laço for-in deve percorrer todos os elementos na ordem correta")
        }
}

// --- Grupo de Testes para Cópia na Escrita (Copy-on-Write) ---
struct LinkedListCOWTests {

    @Test("Modificar uma cópia não deve afetar a original (append)")
    func testCopyOnWriteWithAppend() {
        var list1 = LinkedList<Int>()
        list1.append(1)
        list1.append(2)
        
        var list2 = list1

        list2.append(3)
        
        #expect(list1.description == "1 -> 2", "A lista original não deve ser modificada.")
        #expect(list2.description == "1 -> 2 -> 3", "A lista copiada deve refletir a modificação.")
        #expect(list1.head !== list2.head, "Após a cópia, os heads das listas devem ser instâncias de nós diferentes.")
    }

    @Test("Modificar uma cópia não deve afetar a original (pop)")
    func testCopyOnWriteWithPop() {
        var list1 = LinkedList<String>()
        list1.push("C")
        list1.push("B")
        list1.push("A")
        
        var list2 = list1
        
        let poppedValue = list2.pop()
        
        #expect(poppedValue == "A")
        #expect(list1.description == "A -> B -> C", "A lista original deve permanecer intacta.")
        #expect(list2.description == "B -> C", "A lista copiada deve ser modificada.")
    }
    
    @Test("Modificar lista com referência única não deve copiar")
    func testMutationOnUniquelyReferencedList() {
        var list = LinkedList<Int>()
        list.append(1)
        
        let oldHeadIdentifier = ObjectIdentifier(list.head!)
        
        list.append(2)
        
        let newHeadIdentifier = ObjectIdentifier(list.head!)
        
        #expect(newHeadIdentifier == oldHeadIdentifier, "O nó head não deveria ter sido copiado, pois a lista era unicamente referenciada.")
        #expect(list.description == "1 -> 2", "A modificação deve ter sido bem-sucedida.")
    }

    @Test("Múltiplas cópias e modificações em cadeia")
    func testMultipleCopiesAndChainedMutations() {
        var listA = LinkedList<Int>()
        listA.append(10)
        
        var listB = listA
        var listC = listA
        
        // Act
        listB.append(20)
        listC.append(30)
        
        // Assert
        #expect(listA.description == "10", "listA deveria permanecer com seu valor original.")
        #expect(listB.description == "10 -> 20", "listB deveria ter seu próprio valor modificado.")
        #expect(listC.description == "10 -> 30", "listC deveria ter seu próprio valor modificado.")
    }
}
