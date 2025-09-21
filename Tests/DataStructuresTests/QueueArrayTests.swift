//
//  QueueArrayTests.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 20/09/25.
//

import Testing
@testable import DataStructures

struct QueueArrayTests {
    
    // Testa se a fila começa vazia após a inicialização
    @Test("Inicialização da Fila")
    func testInitialization() {
        let queue = QueueArray<Int>()
        
        #expect(queue.isEmpty, "A fila deve esta vazia após ser inicializada.")
        #expect(queue.peek == nil, "O 'peek' deve retornar nil para uma fila vazia")
    }
    
    // Testa o enfileiramente (enqueue) de um elemento
    @Test("Enfileirar elemento")
    func testEnqueue() {
        var queue = QueueArray<Int>()
        let element = 42
        
        let success = queue.enqueue(element)
        
        #expect(success, "O enfileiramento deve retornar true")
        #expect(!queue.isEmpty, "A fila não deve esta vazia após adicionar um elemento.")
        #expect(queue.peek == element, "O 'peek' deve retornar o elemento que foi enfileirado.")
    }
    
    // Testa o desfileiramento (dequeue) de um elemento.
    @Test("Desenfileirar elemento")
    func testDequeue() {
        var queue = QueueArray<Int>()
        _ = queue.enqueue(1)
        _ = queue.enqueue(2)
        
        let firstElement = queue.dequeue()
        
        #expect(firstElement == 1, "O primeiro elemento a ser desenfileirado deve ser 1.")
        #expect(!queue.isEmpty, "A fila não deve estar vazia após remover o primeiro elemento.")
        #expect(queue.peek == 2, "O 'peek' deve mostrar o próximo elemento, que é 2.")
    }
    
    // Testa o desenfileiramento de uma fila que já está vazia.
    @Test("Desenfileirar de fila vazia")
    func testDequeueFromEmptyQueue() {
        var queue = QueueArray<Int>()
        
        let element = queue.dequeue()
        
        #expect(element == nil, "Desenfileirar de uma fila vazia deve retornar nil.")
        #expect(queue.isEmpty, "A fila deve permanecer vazia")
    }
    
    // Testa a funcionalidade 'peek' para verificar o prócimo elemento sem removê-lo.
    @Test("Visualizar próximo elemento ('peek')")
    func testPeek() {
        var queue = QueueArray<String>()
        _ = queue.enqueue("a")
        _ = queue.enqueue("b")
        
        let firstElement = queue.peek
        
        #expect(firstElement == "a", "O 'peek' deve retornar o primeiro elemento.")
        #expect(!queue.isEmpty, "A fila não deve ficar vazia após um 'peek'.")
        
        // Teste se o peek não removeu o elemento
        let nextElement = queue.dequeue()
        #expect(nextElement == "a", "O elemento removido deve ser o que o 'peek' mostrou.")
    }
    
    // Testa a descrição customizada da fila
    @Test("Descrição da fila")
    func testDescription() {
        var queue = QueueArray<Int>()
        
        #expect(queue.description == "[]", "A descrição de uma fila vazia deve ser '[]'.")
        
        _ = queue.enqueue(1)
        _ = queue.enqueue(2)
        _ = queue.enqueue(3)
        
        #expect(queue.description == "[1, 2, 3]", "A descrição da fila deve ser '[1, 2, 3]'.")
    }
}
