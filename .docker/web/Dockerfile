# Base para a nova imagem
FROM ruby:2.6-stretch

# Instalação de pacotes
RUN apt update -qq \
    && mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7 \
    && apt install -y build-essential apt-transport-https curl \
                          ca-certificates apt-utils libpq-dev postgresql-client locales vim \
                          libqt4-dev libqtwebkit-dev xvfb ffmpeg libpq-dev \
                          libzbar-dev gnupg2 gawk autoconf automake bison libffi-dev \
                          libgdbm-dev libncurses5-dev libsqlite3-dev libyaml-dev \
                          libgmp-dev libreadline-dev libssl-dev git phantomjs

# Muda o locale do container para en_US.UTF-8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Instala o nodejs a partir do nodesource
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

# argumentos recebidos  atraves do docker-compose.yml
ARG USER_ID
ARG USER_NAME
ENV USER_ID $USER_ID

# cria usuário e grupo baseado no host para evitar problemas com permissão de arquivos gerados dentro do container
RUN groupadd -g $USER_ID $USER_NAME \
  && useradd -u $USER_ID -g $USER_NAME --create-home $USER_NAME

# Cria o diretório do projeto dentro do container
RUN mkdir -p /tdd_rails \
  && chown $USER_NAME:$USER_NAME /tdd_rails

# declara o usuário padrão do container
USER $USER_NAME

# Importing files from remote source
ADD .docker/web/irbrc.rb /home/${USER_NAME}/.irbrc

# define o diretório padrão da aplicação
WORKDIR /tdd_rails

# Instala a gem bundler
RUN gem install bundler

# variáveis de ambiente baseadas na versão do ruby
ENV PATH $GEM_HOME/ruby/$RUBY_MAJOR.0/bin:$PATH
ENV GEM_PATH $GEM_HOME:$GEM_HOME/ruby/$RUBY_MAJOR.0
