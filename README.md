# Tutorial: Criando uma Imagem Docker para DokuWiki
---

## Pré-requisitos:

- Docker instalado em sua máquina.

## Passo 1: Crie um novo diretório para o projeto

```bash
mkdir meu-dokuwiki
cd meu-dokuwiki
```

## Passo 2: Crie um arquivo chamado Dockerfile

```dockerfile
# Use a imagem base Ubuntu 18.04 para a construção
FROM ubuntu:18.04 AS build

# Defina o diretório de trabalho dentro da imagem
WORKDIR /app

# Atualize os repositórios de pacotes
RUN apt-get update

# Instale as ferramentas necessárias
RUN apt-get install -y wget zip tar 

# Baixe e descompacte o DokuWiki
RUN wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN tar xzf dokuwiki-stable.tgz --strip-components=1
RUN rm dokuwiki-stable.tgz

# Use a imagem PHP 8 com Apache do sistema operacional Bullseye
FROM php:8-apache-bullseye

# Copie os arquivos do diretório de construção para o diretório do servidor web
COPY --from=build /app/ /var/www/html

# Defina as permissões do diretório
RUN chown -R www-data:www-data /var/www/

# Defina as permissões para os arquivos
RUN chmod -R 755 /var/www/html

# Adicione volumes para os diretórios necessários
VOLUME ["/var/www/html/data", "/var/www/html/lib", "/var/www/html/conf"]

# Exponha a porta 80 para o tráfego externo
EXPOSE 80

```
## Passo 3: Construa a imagem Docker

```bash
docker build -t meu-dokuwiki:latest .
```
Substitua "meu-dokuwiki" e "latest" pelos valores desejados.

## Passo 4: Execute o contêiner com volumes

```bash
docker run -p 80:80 -v /caminho/para/data:/var/www/html/data -v /caminho/para/lib:/var/www/html/lib -v /caminho/para/conf:/var/www/html/conf meu-dokuwiki:latest
```

Substitua `/caminho/para/data`, `/caminho/para/lib` e `/caminho/para/conf` pelos caminhos reais em seu sistema onde você deseja armazenar os dados, bibliotecas e configurações do DokuWiki.


## Passo 5: Acesse o DokuWiki
Abra seu navegador e acesse http://ip-do-conteiner para acessar o DokuWiki.

Agora você tem um contêiner Docker em execução com o DokuWiki, permitindo a personalização e persistência de dados. Este tutorial cobre os passos básicos para construir e executar o DokuWiki usando Docker. Personalize conforme necessário para atender aos requisitos específicos do seu projeto.

---
## ou
O Clone o repositório:

```bash
git clone https://github.com/bc-script/doku_wiki.git
```
### Mudar o diretório 
```bash
cd doku_wiki
```

### Construa a imagem Docker

```bash
docker build -t meu-dokuwiki:latest .
```
Substitua "meu-dokuwiki" e "latest" pelos valores desejados.

### Execute o contêiner com volumes

```bash
docker run -p 80:80 -v /caminho/para/data:/var/www/html/data -v /caminho/para/lib:/var/www/html/lib -v /caminho/para/conf:/var/www/html/conf meu-dokuwiki:latest
```

Substitua `/caminho/para/data`, `/caminho/para/lib` e `/caminho/para/conf` pelos caminhos reais em seu sistema onde você deseja armazenar os dados, bibliotecas e configurações do DokuWiki.
