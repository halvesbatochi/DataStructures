//
//  QueueLinkedListTests.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 21/09/25.
//

import Testing
@testable import DataStructures

struct QueueLinkedListTests {
    
    @Test("Inicialização da Fila")
    func testInitialState() {
        let queue = QueueLinkedList<Int>()
        #expect(queue.isEmpty, "A fila deve estar vazia quando inicializada.")
        #expect(queue.peek == nil, "O 'peek' deve retornar nil para uma fila vazia.")
    }

    @Test("Enfileirar elemento")
    func testEnqueue() {
        var queue = QueueLinkedList<Int>()
        let success = queue.enqueue(1)
        
        #expect(success, "O enfileiramento deve retornar true.")
        #expect(!queue.isEmpty, "A fila não deve estar vazia após enfileirar um elemento.")
        #expect(queue.peek == 1, "O 'peek' deve retornar o primeiro elemento.")
        
        _ = queue.enqueue(2)
        _ = queue.enqueue(3)
        #expect(queue.peek == 1, "O 'peek' deve continuar retornando o primeiro elemento, pois novos são adicionados no final.")
    }
    
    @Test("Desenfileirar elemento")
    func testDequeue() {
        var queue = QueueLinkedList<Int>()
        _ = queue.enqueue(1)
        _ = queue.enqueue(2)
        
        let dequeuedElement = queue.dequeue()
        #expect(dequeuedElement == 1, "O elemento removido deve ser o primeiro que foi enfileirado.")
        #expect(!queue.isEmpty, "A fila não deve estar vazia após remover um elemento.")
        #expect(queue.peek == 2, "O 'peek' deve retornar o próximo elemento.")
        
        let dequeuedElement2 = queue.dequeue()
        #expect(dequeuedElement2 == 2, "O elemento removido deve ser o segundo que foi enfileirado.")
        #expect(queue.isEmpty, "A fila deve estar vazia após a remoção do último elemento.")
    }
    
    @Test("Desenfileirar de uma fila vazia")
    func testDequeueFromEmptyQueue() {
        var queue = QueueLinkedList<Int>()
        let dequeuedElement = queue.dequeue()
        
        #expect(dequeuedElement == nil, "Desenfileirar de uma fila vazia deve retornar nil.")
        #expect(queue.isEmpty, "A fila deve continuar vazia.")
    }
    
    @Test("Peek - Visualizar o primeiro elemento")
    func testPeek() {
        var queue = QueueLinkedList<String>()
        _ = queue.enqueue("primeiro")
        _ = queue.enqueue("segundo")
        
        let firstElement = queue.peek
        #expect(firstElement == "primeiro", "O 'peek' deve retornar o primeiro elemento.")
        
        let peekAgain = queue.peek
        #expect(peekAgain == "primeiro", "Chamar 'peek' novamente não deve alterar o resultado.")
        
        _ = queue.dequeue()
        let newFirstElement = queue.peek
        #expect(newFirstElement == "segundo", "O 'peek' deve retornar o novo primeiro elemento após a remoção.")
    }
}
