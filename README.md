# Desafio de programação mobile iOS

A idéia deste desafio é nos permitir avaliar melhor as habilidades de candidatos à vagas de programador, de vários níveis.

Este desafio deve ser feito por você em sua casa. O tempo limite é de três dias, porém normalmente você não deve precisar de mais do que algumas horas.

## Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no GitHub (crie uma se você não possuir).
1. Em seguida, implemente o projeto tal qual descrito abaixo, em seu próprio fork.
1. Por fim, empurre todas as suas alterações para o seu fork no GitHub e envie um pull request para este repositório original. 

## Descrição do projeto

Você deve criar um aplicativo que irá listar os repositórios públicos mais populares relacionados à Swift no GitHub, usando a [API do GitHub](https://developer.github.com/v3/) para buscar os dados necessários.

O aplicativo deve exibir inicialmente uma lista paginada dos repositórios, ordenados por popularidade decrescente (exemplo de chamada da API: `https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1`).

Cada repositório deve exibir Nome do repositório, Descrição do Repositório, Nome / Foto do autor, Número de Stars, Número de Forks.

Ao tocar em um item, deve levar a lista de Pull Requests do repositório. Cada item da lista deve exibir Nome / Foto do autor do PR, Título do PR, Data do PR e Body do PR.

Ao tocar em um item, deve abrir no browser a página do Pull Request em questão.

Você pode se basear neste mockup para criar as telas:

![mockup](https://raw.githubusercontent.com/myfreecomm/desafio-mobile-ios/master/mockup-ios.png)

Sua aplicação deve:

- suportar versão mínima do iOS: 9.*
- usar um arquivo .gitignore no seu repositório
- usar Storyboard e Autolayout
- usar gestão de dependências no projeto. Ex: Cocoapods
- usar um Framework para Comunicação com API. Ex: Alamofire
- possuir boa cobertura de testes unitários no projeto. Ex: XCTests / Quick + Nimble

Você ganha mais pontos se:

- utilizar RxSwift.
- persistir os dados localmente usando Core Data / Realm / Firebase
- fazer um app Universal, Ipad | Iphone | Landscape | Portrait (Size Classes)
- fazer cache de imagens. Ex: SDWebImage/Kingfisher/AlamofireImage
- utilizar alguma biblioteca de injeção de dependência. Ex: Swinject https://github.com/Swinject/Swinject


As sugestões de bibliotecas fornecidas são só um guideline, sinta-se a vontade para usar soluções diferentes e nos surpreender. O importante de fato é que os objetivos macros sejam atingidos.

## Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
1. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
1. Você seguiu as instruções de envio do desafio?

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.
