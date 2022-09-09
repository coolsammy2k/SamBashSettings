FROM ubuntu:18.04
RUN apt-get update -yq \
    && apt-get install curl -yq \
    && apt-get install -yq vim git 
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 

ADD vimrc /root/.vimrc

RUN vim -E -s -u "$HOME/.vimrc"
