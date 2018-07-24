# JavaHub

  Este projeto é uma aplicação feita em Swift para iOS, onde é demonstrado o uso do padrão MVP e algumas ferramentas
pertinentes ao desenvolvimento para iOS nativo.

### Objectivos do Desafio: 

Sua aplicação deve:

- :white_check_mark: suportar versão mínima do iOS: 8.*.
- :white_check_mark: usar um arquivo .gitignore no seu repositório
- :white_check_mark: usar Storyboard e Autolayout
- :white_check_mark: usar gestão de dependências no projeto. Ex: Cocoapods
- :white_check_mark: usar um Framework para Comunicação com API. Ex: AFNetwork
- :white_check_mark: fazer mapeamento json -> Objeto . Ex: Mantle
- :white_check_mark: possuir boa cobertura de testes unitários no projeto. Ex: XCTests / Specta + Expecta

##### Você ganha mais pontos se:

- :white_check_mark: persistir os dados localmente usando Core Data
- :x: criar testes funcionais. Ex: KIF
- :white_check_mark: fazer um app Universal, Ipad | Iphone | Landscape | Portrait (Size Classes)
- :white_check_mark: fazer cache de imagens. Ex SDWebImage

#### Frameworks Usados: 

- [Realm](https://realm.io)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftIconFont](https://github.com/0x73/SwiftIconFont)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [UIScrollView-InfiniteScroll](https://github.com/pronebird/UIScrollView-InfiniteScroll)
- [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)
- [Quick/Nimble](https://github.com/Quick/Nimble)


### Dependências ###
  O projeto esta configurado para gerenciar as dependências com Carthage. Configurado Fastlane para 
 automatizar o processo de avaliação com testes unítários e criação de reporte de qualidade de código com 
 Slather (Cobertura de código) e Xcov (relatório de cobertura de testes). Podendo ser expandido seu uso para 
 automatizar outras tarefas, como geração de Screenshots para publicação, bem como gestão de provisioning 
 profiles e certificados, e publicação do App.
 
 ### Ambiente ###
 
  O projeto possui configurações para o ambiente de Desenvolvimento (DEBUG) e Produção (Release). Para alternar entre os ambientes e acessar informações diferentes, altere o Scheme do projeto. 

 No Xcode, ao lado do botão de "Play" poderá ser visto o Sheme selecionado, clique e alterne conforme a necessidade.
 
  Isso irá afetar: 

- Troca de URL usada pela API
- Troca de icones do aplicativo apresentado na tela do Device. (Icones para Development, terá a label DEBUG)
- Troca do nome do aplicativo apresentado na tela do Device. (Builds para Development irá apresentar o nome "Dbg-Shop Car"

 ## Executando o projeto ##

  É necessário estar usando o Xcode v9.4 com Swift v4.2 (https://developer.apple.com/xcode/)
  
  - Carthage  v0.29.0 (https://github.com/Carthage/Carthage#installing-carthage)
  - Fastlane v2.98.0 (https://docs.fastlane.tools/getting-started/ios/setup/)
  - Xcov v1.4.3 (https://github.com/nakiostudio/xcov)
  - Swiftlint (https://github.com/realm/SwiftLint#installation)
  - Ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]

Recomendo o uso de RVM (Ruby Version Manger - https://rvm.io)


### SwiftLint ### 
 O projeto usa SwiftLint para auxiliar na manutenção do estilo e padrão de escrita do código, ajudando a manter o código limpo e de fácil leitura, evitando geração de código "sujo" ou sem um padrão de escrita.

  Para intalar o Swiftlint use o seguinte comando: 

  `$ brew install swiftlint`

  Para mais detalhes sobre o SwiftLint: https://github.com/realm/SwiftLint

### Gemfile ###

 Após clonar o projeto, use o terminal para acessar a pasta: 

`$ cd <path to folder>/javahub`

  Após acessar a pasta através do terminal use o comando abaixo para instalar algumas depenências a partir do arquivo Gemfile:

`$ bundle install`

Isso irá instalar o Fastlane, Slather, Xcpretty e Xcov.

### Carthage ###
Para instalar as denpendências diretas do projeto, é necessário a instalação do Carthage, caso ainda 
não possua o Carthage instalado, use o comando para instalar usando o HomeBrew (https://brew.sh/index_pt-br): 

`$ brew install carthage`

Para mais informações sobre detalhes de uso e instalação do Carthage, veja: https://github.com/Carthage/Carthage

Após a instalação do Carthage, use o comando apara instalar as dependências: 

`$ carthage update --cache-builds --platform ios`

  Este comando irá baixar os repositórios de cada dependência, e irá realiar um 
build para cada uma delas, gerando um framework compátivel somente para apps 
para iOS. Caso você precise executar o comando mais uma vez, ele NÃO irá realizar
novamente o build de frameworks que já foram criados.

### Instalação de Dependências caso Necessário ###

Após o processo de instalação do Carthage e geração de frameworks, abra o projeto e execute um Build. Caso você receba warnings sobre dependências não encontradas, siga as etapas abaixo: 

1 - Em seguida, abra o projeto com o arquivo 'javahub.xcodproj' com o Xcode, e em uma janela no Finder, 
abra a pasta dentro do projeto: 

`<path to folder>/javahub/Carthage/Build/iOS`

 2 - Selecione e arraste para o projeto, os arquivos de extensão: 

` *.dSYM`

` *.framework`

 3 - No Xcode, no Show Project Navigator (lado esquerdo), selecione o arquivo javahub.xcodeproj, 
 depois selecione o target: `javahub`. Selecione a aba 'Build Phases', dentro do conteúdo desta aba, no 
 canto superior esquedo, terá um sinal de adição '+', clique nele e selecione e opção: 'New Run Script Phase'.

 4 - No novo campo de scripts criado, altere o nome para Carthage ( ou outro que deseje), e na parte 'Input File'
 crie um novo registro para cada framework adicionado ao projeto.

Exemplo: 

    $(SRCROOT)/Carthage/Build/iOS/Alamofire.framework

### CHECAGEM DO PROJETO ###

Para verificar o projeto, em seu terminal dentro da pasta do projeto, execute o seguinte comando lane, 
já configurado no arquivo Fastfile: 

`fastlane check_code env:dev`

 Este comando irá executar as seguintes verificações: 

  - Swiftlint
  - Testes Unitários
  - Geração de reporte do Slather
  - Geração de Reporte do Xcov

# Sobre o Projeto
# Desafio de programação mobile iOS

A idéia deste desafio é nos permitir avaliar melhor as habilidades de candidatos à vagas de programador, de vários níveis.

Este desafio deve ser feito por você em sua casa. Gaste o tempo que você quiser, porém normalmente você não deve precisar de mais do que algumas horas.

## Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no GitHub (crie uma se você não possuir).
1. Em seguida, implemente o projeto tal qual descrito abaixo, em seu próprio fork.
1. Por fim, empurre todas as suas alterações para o seu fork no GitHub e envie um pull request para este repositório original. Se você já entrou em contato com alguém da Myfreecomm sobre uma vaga, avise também essa pessoa por email, incluindo no email o seu usuário no GitHub.

### Instruções alternativas (caso você não queira que sua submissão seja pública)

1. Faça um clone deste repositório.
1. Em seguida, implemente o projeto tal qual descrito abaixo, em seu clone local.
1. Por fim, envie via email um arquivo patch para seu contato na Myfreecomm.

## Descrição do projeto

Você deve criar um aplicativo que irá listar os repositórios públicos mais populares relacionados à Java no GitHub, usando a [API do GitHub](https://developer.github.com/v3/) para buscar os dados necessários.

O aplicativo deve exibir inicialmente uma lista paginada dos repositórios, ordenados por popularidade decrescente (exemplo de chamada da API: `https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1`).

Cada repositório deve exibir Nome do repositório, Descrição do Repositório, Nome / Foto do autor, Número de Stars, Número de Forks.

Ao tocar em um item, deve levar a lista de Pull Requests do repositório. Cada item da lista deve exibir Nome / Foto do autor do PR, Título do PR, Data do PR e Body do PR.

Ao tocar em um item, deve abrir no browser a página do Pull Request em questão.

Você pode se basear neste mockup para criar as telas:

![mockup](https://raw.githubusercontent.com/myfreecomm/desafio-mobile-ios/master/mockup-ios.png)

Sua aplicação deve:

- suportar versão mínima do iOS: 8.*
- usar um arquivo .gitignore no seu repositório
- usar Storyboard e Autolayout
- usar gestão de dependências no projeto. Ex: Cocoapods
- usar um Framework para Comunicação com API. Ex: AFNetwork
- fazer mapeamento json -> Objeto . Ex: [Mantle](https://github.com/Mantle/Mantle#mtlmodel)
- possuir boa cobertura de testes unitários no projeto. Ex: XCTests / Specta + Expecta

Você ganha mais pontos se:

- persistir os dados localmente usando Core Data
- criar testes funcionais. Ex: KIF
- fazer um app Universal, Ipad | Iphone | Landscape | Portrait (Size Classes)
- fazer cache de imagens. Ex SDWebImage

As sugestões de bibliotecas fornecidas são só um guideline, sinta-se a vontade para usar soluções diferentes e nos surpreender. O importante de fato é que os objetivos macros sejam atingidos.

## Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
1. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
1. Você seguiu as instruções de envio do desafio?

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.

## Referência

Este desafio foi baseado neste outro desafio: https://bitbucket.org/suporte_concrete/desafio-ios
