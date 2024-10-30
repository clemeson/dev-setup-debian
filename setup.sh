#!/bin/bash


echo "Atualizando pacotes do sistema..."
sudo apt update && sudo apt upgrade -y


echo "Instalando dependências necessárias..."
sudo apt install -y curl wget gnupg lsb-release apt-transport-https unzip software-properties-common ca-certificates


echo "Instalando Terraform..."
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.6.0_linux_amd64.zip
terraform -version


echo "Instalando Docker e Docker Compose..."
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER


echo "Instalando docker-compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


echo "Instalando NVM e Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
node -v
npm -v

# ------------------------------
# 4. Instalar Ansible
# ------------------------------
echo "Instalando Ansible..."
sudo apt update
sudo apt install -y ansible
ansible --version


echo "Instalando AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
aws --version


echo "Instalando Vagrant..."
wget https://releases.hashicorp.com/vagrant/2.4.0/vagrant_2.4.0_linux_amd64.deb
sudo apt install -y ./vagrant_2.4.0_linux_amd64.deb
rm vagrant_2.4.0_linux_amd64.deb
vagrant --version


echo "Instalando Git..."
sudo apt install -y git
git --version


echo "Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code
code --version

echo "Configuração concluída! Reinicie a máquina para que todas as alterações sejam aplicadas."
