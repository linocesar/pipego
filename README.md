
![icon](https://user-images.githubusercontent.com/790145/113528116-02d3cc80-9596-11eb-8983-ce08e2f9716e.gif)
<br>PIPE-GO! - Ferramenta Computacional para Análise de dados Biológicos resultantes do pipeline PGAP.

#### Instalação de dependências Linux:
```sudo apt install perl-tk libtk-splashscreen-perl```
#### Mover o conteúdo deste repositório para o diretório do PGAP. Adicione permissões necessárias para execução e no diretório PGAP execute o comando: 
```perl pipego.pl```
#### A seguinte tela surgirá:
![tela1 1](https://user-images.githubusercontent.com/790145/113533154-9a8be780-95a3-11eb-94e1-cd6df0de5d4f.png)


#### O campo `datasource`:
* `input`  

![input](https://user-images.githubusercontent.com/790145/113531744-f3598100-959f-11eb-8b25-7a196533e178.png)

Na tela 1 a escolha do diretório (input) onde estão os arquivos pep, nuc e function. Só serão aceitos cepas que possuem 3 arquivos correspondentes.
Na tela 2 a janela de gerenciamento das cepas para análise.

* `output` é o diretório onde os resultados do PGAP serão salvos.
* `dataset` é a janela de gereciamento das cepas como mostra a tela 2

O PGAP oferece 5 análises: `cluster`, `pangenome`, `variation`, `evolution` e `function`. Pode-se usar de acordo com a necessidade.<br>
O Campo `metódo` oferece duas opções: `GF` - gene family e `MP` - multiparanoid. Apenas uma pode ser selecionada por job.<br> 
O campo `número de threads`: número de processadores que serão utilizados pelo PGAP. <br>
O campo `identidade` é a identidade minima no alinhamento entre duas proteínas homólogas.<br>
O campo `cobertura` é a cobertura mínima no alinhamento entre duas proteínas homólogas.<br>
O campo `e-value` é utilizada como parâmetro de corte no BLAST.<br>
O campo `email` não é obrigátorio. Caso utilize é necessária uma configuração prévia de um serviço de e-mail.<br>
O botão `GO` finaliza a interface e executa o PGAP via terminal com os dados de entrada selecionados e parâmetros fixados na interface gráfica.<br>

### Para Utilizar a interface é necessária que O PGAP esteja corretamente configurado previamente com todas as dependências sanadas. 
