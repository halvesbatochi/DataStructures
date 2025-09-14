//
//  NodeTests.swift
//  DataStructures
//
//  Created by Henrique Alves Batochi on 14/09/25.
//

import Testing
// @testable permite acesso a tipos e funções 'internal' do seu package
@testable import DataStructures

struct NodeTests {
    // Teste 1: Verifica se a inicialização de um único nó funciona corretamente.
    @Test("Inicialização do Nó")
    func testNodeInitialization() {
        
        let node = Node(value: 1)
        
        // Assert
        #expect(node.value == 1, "O valor do nó deveria ser 1")
        #expect(node.next == nil, "O próximo nó deveri ser nulo (nil) por padrão")
        
    }
    
    @Test("Vinculação entre nós")
    func testNodeLinking() {
        
        let node1 = Node(value: 1)
        let node2 = Node(value: 2)
        let node3 = Node(value: 3)
        
        node1.next = node2
        node2.next = node3
        
        #expect(node1.next === node2, "O próximo de node1 deveria ser node2")
        #expect(node2.next === node3, "O próximo de node2 deveria ser node3")
        #expect(node3.next == nil, "O próximo de node3 deveria ser nulo (nil)")
    }
    
    @Test("Descrição Customizada do Nó")
    func testNodeDescription() {
        
        let node1 = Node(value: 1)
        let node2 = Node(value: 2)
        let node3 = Node(value: 3)
        
        node1.next = node2
        node2.next = node3
        
        let singleNodeDescription = Node(value: 42).description
        #expect(singleNodeDescription == "42", "A descrição de um nó único de ser apenas seu valor")
        
        let expectedDescription = "1 -> 2 -> 3"
        #expect(node1.description == expectedDescription, "A descrição da cadeia de nós não está no formato esperado \(node1.description)")
    }
}
