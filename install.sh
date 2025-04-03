#!/bin/bash

# Supprimer NeoVim et LunarVim ainsi que les fichiers de configuration
echo "Désinstallation de NeoVim et LunarVim..."

# Supprimer NeoVim
if command -v nvim &>/dev/null; then
  echo "Suppression de NeoVim..."
  sudo apt-get remove --purge -y neovim
  sudo apt-get autoremove -y
  sudo apt-get clean
fi

# Supprimer LunarVim et ses fichiers de configuration
if [ -d "$HOME/.local/share/lunarvim" ]; then
  echo "Suppression de LunarVim..."
  rm -rf ~/.local/share/lunarvim
fi

# Supprimer les fichiers de configuration de NeoVim et LunarVim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/share/lunarvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/state/lunarvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim

echo "Désinstallation complète terminée."

# Installer NeoVim (si non déjà installé)
echo "Installation de NeoVim..."
sudo apt-get update
sudo apt-get install -y neovim

# Installer Packer pour la gestion des plugins
echo "Installation de Packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Télécharger et installer LunarVim
echo "Installation de LunarVim..."
git clone https://github.com/LunarVim/LunarVim.git ~/.local/share/lunarvim

# Exécuter l'installation de LunarVim (pas de fichier install.sh, mais exécution de l'installation)
echo "Installation des dépendances de LunarVim..."
~/.local/share/lunarvim/Lua/install.sh

# Configuration de LunarVim
echo "Configuration de LunarVim..."

# Créer un fichier de configuration minimal si nécessaire
if [ ! -f ~/.config/nvim/lv-config.lua ]; then
  mkdir -p ~/.config/nvim
  cat > ~/.config/nvim/lv-config.lua <<EOL
-- Configuration minimale pour LunarVim
-- Modifier ce fichier selon tes préférences

lvim.plugins = {
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/nvim-compe'},
}

-- Autres configurations ici...
EOL
fi

# Synchroniser les plugins
echo "Synchronisation des plugins..."
nvim +PackerSync +qa

# Fin de l'installation et configuration
echo "LunarVim est installé et configuré. NeoVim est prêt à l'emploi."

