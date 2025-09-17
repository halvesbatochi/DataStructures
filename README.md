# DataStructures

Uma coleção de estruturas de dados fundamentais e eficientes, implementada em Swift puro. Este pacote foi criado para fins de estudo e utilização em projetos que necessitam de estruturas de dados clássicas.

## Estruturas de Dados Implementadas

-   [Node<Value>](#nodevalue)
-   [LinkedList<Value>](#linkedlistvalue)
-   [Stack<Element>](#stackelement)
-   *Queue (em breve)*

---

### Node<Value>

O `Node` é o bloco de construção fundamental para estruturas de dados encadeadas, como Listas Ligadas (Linked Lists) e Filas (Queues). Cada nó contém um valor e uma referência opcional para o próximo nó na sequência.

#### Características Técnicas

-   **Genérico (`<Value>`):** Pode armazenar qualquer tipo de valor (`Int`, `String`, objetos customizados, etc.), oferecendo máxima flexibilidade.
-   **Tipo de Referência (`class`):** Sendo uma classe, instâncias de `Node` são passadas por referência. Isso é essencial para que múltiplos ponteiros (como `head`, `tail` ou o `next` de outro nó) possam apontar para a *mesma* instância na memória.
-   **Encadeamento (`next`):** A propriedade `next: Node?` é o que permite a ligação entre os nós, formando a cadeia da estrutura de dados.
-   **Impressão Amigável (`CustomStringConvertible`):**
