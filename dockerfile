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
