//
//  StackTests.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 15/09/25.
//

import Testing
@testable import DataStructures

// --- Grupo de Testes para a Inicialização da Stack ---
struct StackInitializationTests {
    
    @Test("A inicialização padrão deve criar uma stack vazia")
    func testDefaultInitialization() {
        let stack = Stack<Int>()
        #expect(stack.isEmpty, "Uma stack criada com init() deve estar vazia")
    }
    
    @Test("A inicialização com um array deve criar uma stack com esses elementos")
    func teestInitializationWithArray() {
        let array = [10, 20, 30]
        let stack = Stack(array)
        
        #expect(stack.peek() == 30, "O topo da stack deveria ser o último elemento do array")
        #expect(!stack.isEmpty)
    }
}

// --- Grupo de Testes para as Operações de Mutação (push/pop) ---
struct StackMutationsTests {
    
    @Test("Push deve adicionar um elemento ao topo da Stack")
    func testPush() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        
        #expect(stack.peek() == 2, "O elemento 2 deveria ser o novo topo")
    }
    
    @Test("Pop em uma stack populada deve remover e retornar o elemento do topo")
    func testPopOnNonEmptyStack() {
        var stack: Stack = [10, 20, 30]
        
        let poppedValue = stack.pop()
        
        #expect(poppedValue == 30, "O valor removido deveria ser 30")
        #expect(stack.peek() == 20, "O novo topo da stack deveria ser 20")
    }
    
    @Test("Pop em uma stack com um único elemento deve esvaziá-la")
    func testPopOnSingleElementStack() {
        var stack: Stack = ["Único"]
        
        let poppedValue = stack.pop()
        
        #expect(poppedValue == "Único")
        #expect(stack.isEmpty, "A stack deveria ficar vazia após o pop")
    }
    
    @Test("Pop em uma stack vazia deve retornar nil e não causar erro")
    func testPopOnEmptyStack() {
        var stack = Stack<Double>()
        
        let poppedValue = stack.pop()
        
        #expect(poppedValue == nil, "Pop em uma stack vazia deve retornar nil")
        #expect(stack.isEmpty)
    }
}

// --- Grupo de Testes para as Propriedades de Leitura (isEmpty/peek) ---
struct StacksStateTests {
    
    @Test("isEmpty deve retornar verdadeiro para uma stack vazia")
    func testIsEmptyOnEmptyStack() {
        let stack = Stack<Int>()
        #expect(stack.isEmpty)
    }
    
    @Test("isEmpty deve retornar false para uma stack com elementos")
    func testIsEmptyOnNonEmptyStack() {
        let stack: Stack = [1]
        #expect(!stack.isEmpty)
    }
    
    @Test("Peek deve retornar o elemento do topo sem removê-lo")
    func testPeek() {
        let stack: Stack = ["X", "Y", "Z"]
        
        #expect(stack.peek() == "Z", "Peek deveria retornar o elemento 'Z'")
        #expect(stack.peek() == "Z", "Peek não deve alterar o topo da stack")
    }
    
    @Test("Peek em uma stack vazia deve retornar nil")
    func testPeekOnEmptyStack() {
        let stack = Stack<String>()
        #expect(stack.peek() == nil)
    }
}

// --- Grupo de Tests para a 'description' ---
struct StackDescriptionTests {
    
    @Test("A descrição de uma stack populada deve ser formatada corretamente")
    func testDescriptionForPopulatedStack() {
        let stack: Stack = [1, 2, 3]
        
        let expected = """
        ----top----
        3
        2
        1
        -----------
        """
        
        #expect(stack.description == expected)
    }
    
    @Test("A descrição de uma stack vazia deve ser formatada corretamente")
    func testDescriptionForEmptyStack() {
        let stack = Stack<Int>()
        
        let expected = """
        ----top----
        
        -----------
        """
        
        #expect(stack.description == expected, "A descrição para uma stack vazia não está correta")
    }
}
