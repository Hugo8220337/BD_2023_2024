### Identificação do tipo de entidades: 

| Nome da Entidade | Descrição                                                              | Apelido             | Ocorrência                                                             |
| ---------------- | ---------------------------------------------------------------------- | ------------------- | ---------------------------------------------------------------------- |
| Estrutura        | Local onde são plantados os produtos. Pode ser uma estufa ou polyTunel | Estufa              | Tem de conter uma ou mais secções                                      |
| Manutenção       | Descrição das manutenções realizadas às estruturas                     | Manutenção          | As estruturas precisam de manutenções                                  |
| Produto          | Descrição dos produtos a serem plantados nas estufas                   | Plantas             | Pode ou não estar presente em plantações                               |
| Insumo           | Descrição dos produtos auxiliares para o cultivo de uma planta         | Produtos Auxiliares | Uma plantação precisa de um ou mais insumos                            |
| Secção           | Descrição das secções dentro das estufas ou PolyTuneis                 | Secção              | Tem de estar  associada a uma estrutura                                |
| Plantação        | Descrição de todas as plantaçãoes                                      | Plantação           | Uma plantação só pode ter plantado um produto                          |
| Colheita         | Descrição de todas as colheitas                                        | Colheita            | Uma colheita tem de estar associada a uma plantação                    |
| Funcionário      | Descrição dos funcionários que trabalham nas estufas                   | Funcionário         | Um funcionário trabalha numa estufa e é atribuído a uma ou mais seções |


### Identificação dos relacionamentos:
| Nome da Entidade | Multiplicidade | Relação       | Multiplicidade | Nome da Entidade |
| ---------------- | -------------- | ------------- | -------------- | ---------------- |
| Estrutura        | 1..1           | Contém        | 1..*           | Secção           |
| Estrutura        | 1..1           | Precisa de    | 1..*           | Manutenção       |
| Secção           | 1..1           | Tem           | 0..*           | Plantação        |
| Produto          | 1..1           | Contida numa  | 1..*           | Plantação        |
| Plantação        | 1..1           | Precisa de    | 1..*           | Insumos          |
| Plantação        | 1..1           | Tem           | 1..*           | Colheita         |
| Funcionário      | 1..*           | Trabalha numa | 0..1           | Estrutura        |
| Funcionário      | 1..*           | atribuído a   | 1..*           | Secção           |
