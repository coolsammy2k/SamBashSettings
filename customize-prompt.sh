apt update
apt install git -y
sudo apt-get install zsh -y
sudo chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "source <(kubectl completion zsh)" >> ~/.zshrc
echo 'alias k=kubectl' >> ~/.zshrc
echo 'complete -F __start_kubectl k' >> ~/.zshrc

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

