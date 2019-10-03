FROM ubuntu:18.04
RUN apt update
RUN apt install git curl zip unzip net-tools iputils-ping make gcc g++  -y
RUN apt full-upgrade -y
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt install nodejs yarn -y
RUN useradd -ms /bin/bash devuser
USER devuser
RUN curl -sL "https://get.sdkman.io" | bash
RUN sed -i 's/sdkman_insecure_ssl=false/sdkman_insecure_ssl=true/g'  ~/.sdkman/etc/config
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh \
    && sdk install java 8.0.222-zulu \
    && sdk install maven \
    && sdk install gradle"
USER root
RUN yarn global add @vue/cli
USER devuser
WORKDIR /home/devuser
RUN mkdir ~/.gradle