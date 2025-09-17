# DataStructures

Uma coleção de estruturas de dados fundamentais e eficientes, implementada em Swift puro. Este pacote foi criado para fins de estudo e utilização em projetos que necessitam de estruturas de dados clássicas.

## Estruturas de Dados Implementadas

-   [Node<Value>](#nodevalue)
-   [LinkedList<Value>](#linkedlistvalue)
-   *Queue (em breve)*
-   *Stack (em breve)*

---

### Node<Value>

O `Node` é o bloco de construção fundamental para estruturas de dados encadeadas, como Listas Ligadas (Linked Lists) e Filas (Queues). Cada nó contém um valor e uma referência opcional para o próximo nó na sequência.

#### Características Técnicas

-   **Genérico (`<Value>`):** Pode armazenar qualquer tipo de valor (`Int`, `String`, objetos customizados, etc.), oferecendo máxima flexibilidade.
-   **Tipo de Referência (`class`):** Sendo uma classe, instâncias de `Node` são passadas por referência. Isso é essencial para que múltiplos ponteiros (como `head`, `tail` ou o `next` de outro nó) possam apontar para a *mesma* instância na memória.
-   **Encadeamento (`next`):** A propriedade `next: Node?` é o que permite a ligação entre os nós, formando a cadeia da estrutura de dados.
-   **Impressão Amigável (`CustomStringConvertible`):** Facilita a depuração e visualização, permitindo imprimir toda a cadeia de nós a partir de um nó inicial com um simples `print()`.

#### Instanciação e Uso

**1. Criando um nó simples:**

```swift
// Cria um nó que armazena o valor inteiro 10
let singleNode = Node(value: 10)

print(singleNode.value) // Saída: 10
print(singleNode.next)  // Saída: nil
```

**2. Criando nós encadeados:**

```swift
// Cria o segundo nó
let secondNode = Node(value: 20)
// Cria o primeiro nó, já apontando para o segundo
let firstNode = Node(value: 10, next: secondNode)

print(firstNode) // Saída: 10 -> 20
```

---

### LinkedList<Value>

Uma Lista Ligada (Linked List) é uma estrutura de dados linear que consiste em uma sequência de nós. Esta implementação é uma lista ligada unidirecional (singly-linked list) com otimizações para o ecossistema Swift.

#### Características Técnicas

-   **Gerenciamento de `head` e `tail`:** A lista mantém referências tanto para o primeiro (`head`) quanto para o último (`tail`) nó. Isso permite operações de inserção no início e no fim com altíssima performance.
-   **Semântica de Valor com Copy-on-Write (COW):** A `LinkedList` é uma `struct` e se comporta como as coleções nativas do Swift (`Array`, `Dictionary`). Cópias são extremamente rápidas e eficientes em memória, pois os dados internos (os nós) só são duplicados no exato momento de uma modificação, evitando cópias desnecessárias.
-   **Conformidade com `Collection`:** Permite o uso de uma vasta gama de funcionalidades da Biblioteca Padrão do Swift, incluindo iteração com laços `for-in`, acesso a propriedades como `.count` e `.first`, e o uso de métodos de alta ordem como `map`, `filter` e `reduce`.
-   **Genérica (`<Value>`):** Pode ser usada para criar uma lista de qualquer tipo de dado.
-   **Impressão Amigável (`CustomStringConvertible`):** Você pode imprimir a lista inteira diretamente, o que é ótimo para depuração.

#### Instanciação e Uso Básico

```swift
// Cria uma nova lista ligada de Strings
var list = LinkedList<String>()

// 1. Adicionando no início (push)
list.push("C")
print(list) // Saída: C

// 2. Adicionando no início novamente
list.push("B")
print(list) // Saída: B -> C

// 3. Adicionando no final (append)
list.append("D")
print(list) // Saída: B -> C -> D

// 4. Removendo do início (pop)
let poppedValue = list.pop()
print(poppedValue ?? "nil") // Saída: B
print(list)                 // Saída: C -> D
```

#### Uso Avançado (Protocolo `Collection`)

Graças à conformidade com `Collection`, você pode interagir com a `LinkedList` de maneiras muito mais expressivas e poderosas.

```swift
var list = LinkedList<Int>()
list.append(10)
list.append(20)
list.append(30)

// Iteração com for-in
for value in list {
    print(value)
}
// Saída:
// 10
// 20
// 30

// Propriedades como .count e .first
print(list.count) // Saída: 3
print(list.first ?? -1) // Saída: 10

// Métodos de alta ordem como .map e .filter
let squared = list.map { $0 * $0 }
print(squared) // Saída: [100, 400, 900]

let evenNumbers = list.filter { $0 % 2 == 0 }
print(evenNumbers) // Saída: [10, 20, 30]
```

#### Análise de Performance

A principal vantagem de uma Lista Ligada sobre um Array é a performance consistente para operações de inserção e remoção no início da coleção.

| Método | Complexidade de Tempo | Descrição |
| :--- | :--- | :--- |
| `push` | $O(1)$ | Inserir no início da lista (head) é uma operação de tempo constante. |
| `append` | $O(1)$ | Inserir no fim da lista (tail) também é $O(1)$ porque mantemos uma referência direta para o `tail`. |
| `insert(after:)` | $O(1)$ | Inserir após um nó específico é uma operação de tempo constante. |
| `node(at:)` | $O(i)$ | Para encontrar um nó em um índice `i`, é preciso percorrer a lista a partir do `head`. |
| `pop` | $O(1)$ | Remover o primeiro elemento (head) é uma operação de tempo constante. |
| `removeLast` | $O(n)$ | Para remover o último elemento, é preciso percorrer **toda a lista** para encontrar o penúltimo nó. |
| `remove(after:)` | $O(1)$ | Remover um nó após um nó específico é uma operação de tempo constante. |

**Nota sobre `Collection`:** A conformidade com o protocolo `Collection` adiciona funcionalidades muito úteis, como a propriedade `.count`. É importante notar que, em uma `LinkedList`, o cálculo do `.count` tem uma complexidade de tempo de $O(n)$, pois requer a travessia de toda a lista para contar os elementos. Da mesma forma, outras operações como `.filter` também são $O(n)$.

---

### Stack<Element>

Uma Pilha (Stack) é uma estrutura de dados que segue o princípio **LIFO** (Last-In, First-Out), ou seja, o último elemento a entrar é o primeiro a sair. É análoga a uma pilha de pratos: você adiciona (`push`) e remove (`pop`) pratos sempre pelo topo. Esta implementação utiliza um `Array` Swift como seu armazenamento interno, garantindo excelente performance.

#### Características Técnicas

-   **Wrapper de `Array` Swift:** Construída sobre a estrutura `Array` nativa do Swift, aproveitando toda a sua eficiência e gerenciamento de memória.
-   **LIFO (Last-In, First-Out):** A lógica fundamental da pilha é estritamente seguida em suas operações.
-   **Semântica de Valor (`struct`):** Comporta-se como as coleções padrão do Swift. As cópias são baratas e a duplicação de memória só ocorre na primeira modificação (Copy-on-Write, herdado do `Array`).
-   **Genérica (`<Element>`):** Pode armazenar qualquer tipo de dado.
-   **Inicialização Versátil (`ExpressibleByArrayLiteral`):** Permite criar uma pilha de forma declarativa e intuitiva, como `let stack: Stack = [1, 2, 3]`.
-   **Impressão Amigável (`CustomStringConvertible`):** Fornece uma representação visual clara da pilha, com o topo em destaque, facilitando a depuração.

#### Instanciação e Uso

```swift
// 1. Criando uma pilha com 'array literal'
var stack: Stack = [10, 20]

// 2. Empilhando (push) um novo elemento
stack.push(30)

// A pilha agora é [10, 20, 30], com 30 no topo
print(stack)
// Saída:
// ----top----
// 30
// 20
// 10
// -----------

// 3. Espiando (peek) o elemento do topo
// Retorna o valor sem removê-lo
if let topElement = stack.peek() {
    print("Elemento no topo: \(topElement)") // Saída: Elemento no topo: 30
}

// 4. Desempilhando (pop)
// Remove e retorna o elemento do topo
let poppedValue = stack.pop()
print("Valor removido: \(poppedValue ?? -1)") // Saída: Valor removido: 30
print("Pilha agora: \n\(stack)")
// Saída:
// Pilha agora:
// ----top----
// 20
// 10
// -----------

// 5. Verificando se está vazia
print(stack.isEmpty) // Saída: false

#### Análise de Performance

Graças ao uso de um `Array` como base, as operações principais de uma `Stack` são extremamente rápidas.

| Método | Complexidade de Tempo | Descrição |
| :--- | :--- | :--- |
| `push` | $O(1)$ (Amortizado) | Adicionar um elemento ao final de um `Array` é uma operação de tempo constante na maior parte do tempo. |
| `pop` | $O(1)$ | Remover o último elemento de um `Array` é sempre uma operação de tempo constante. |
| `peek` | $O(1)$ | Acessar o último elemento de um `Array` é sempre uma operação de tempo constante. |
| `isEmpty` | $O(1)$ | A verificação se a pilha está vazia também tem tempo constante. |

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
