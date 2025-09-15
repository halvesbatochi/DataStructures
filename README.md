# DataStructures

Uma coleção de estruturas de dados fundamentais e eficientes, implementada em Swift puro. Este pacote foi criado para fins de estudo e utilização em projetos que necessitam de estruturas de dados clássicas.

## Estruturas de Dados Implementadas

-   [Node](#nodevalue)
-   *LinkedList (em breve)*
-   *Queue (em breve)*
-   *Stack (em breve)*

---

### Node<Value>

O `Node` é o bloco de construção fundamental para estruturas de dados encadeadas, como Listas Ligadas (Linked Lists) e Filas (Queues). Cada nó contém um valor e uma referência opcional para o próximo nó na sequência.

#### Características Técnicas

-   **Genérico (`<Value>`):** Pode armazenar qualquer tipo de valor (`Int`, `String`, objetos customizados, etc.), oferecendo máxima flexibilidade.
-   **Tipo de Referência (`class`):** Sendo uma classe, instâncias de `Node` são passadas por referência. Isso é essencial para que múltiplos ponteiros (como `head`, `tail` ou o `next` de outro nó) possam apontar para a *mesma* instância na memória.
-   **Encadeamento (`next`):** A propriedade `next: Node?` é o que permite a ligação entre os nós, formando a cadeia da estrutura de dados.
-   **Impressão Amigável (`CustomStringConvertible`):** Facilita a depuração e visualização, permitindo imprimir toda a cadeia de nós a partir de um nó inicial com um simples `print()`.

#### Instanciação e Uso

Você pode criar um nó individualmente ou já conectá-lo a outro nó existente.

**1. Criando um nó simples:**

```swift
// Cria um nó que armazena o valor inteiro 10
let singleNode = Node(value: 10)

print(singleNode.value) // Saída: 10
print(singleNode.next)  // Saída: nil
```

**2. Criando nós encadeados:**

Para formar uma cadeia, você pode passar o próximo nó durante a inicialização.

```swift
// Cria o segundo nó
let secondNode = Node(value: 20)

// Cria o primeiro nó, já apontando para o segundo
let firstNode = Node(value: 10, next: secondNode)

// Graças ao CustomStringConvertible, a impressão é intuitiva
print(firstNode) // Saída: 10 -> 20
```

#### Acessando Valores

Você pode navegar pela cadeia de nós através da propriedade `next`.

```swift
if let nextNode = firstNode.next {
    print(nextNode.value) // Saída: 20
}

// Acessando o valor do segundo nó através do primeiro
if let nextValue = firstNode.next?.value {
    print(nextValue) // Saída: 20
}
```

---

### Como Usar (Instalação)

Este projeto é um Swift Package. Para adicioná-lo como uma dependência ao seu projeto, adicione a URL deste repositório no Xcode ou no seu arquivo `Package.swift`.

**Xcode:**
`File > Add Packages...` e insira a URL do repositório.

**Package.swift:**
```swift
dependencies: [
    .package(url: "URL_DO_SEU_REPOSITORIO_AQUI", .upToNextMajor(from: "1.0.0"))
]
```

### Testes

O pacote inclui um conjunto completo de testes unitários para garantir a confiabilidade de todas as estruturas de dados. Para executar os testes, abra o projeto no Xcode e pressione `Cmd+U`.
