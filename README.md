<div align="center">

  # JaneNv
  A modern and lightweight NeoVim configuration that enhances your development experience

  [![NeoVim](https://img.shields.io/badge/v0.9.5-zxc?style=for-the-badge&logo=NeoVim&color=a6e3a1&logoColor=D9E0EE&labelColor=1e1e2e)](//neovim.io/doc)
  [![License](https://img.shields.io/github/license/alsolovyev/nvim-config?style=for-the-badge&logo=starship&color=f5c2e7&logoColor=D9E0EE&labelColor=1e1e2e)](//github.com/alsolovyev/nvim-config/blob/master/LICENSE)
  [![Issues](https://img.shields.io/github/issues/alsolovyev/nvim-config?style=for-the-badge&logo=bilibili&color=eba0ac&logoColor=D9E0EE&labelColor=1e1e2e)](//github.com/alsolovyev/nvim-config/issues)
  [![Telegram](https://img.shields.io/badge/Telegram-white.svg?style=for-the-badge&logo=telegram&color=b4befe&logoColor=D9E0EE&labelColor=1e1e2e)](//t.me/alsolovyev)

  ![Preview](https://github.com/alsolovyev/nvim-config/assets/20425619/4dcdefb8-10bb-40aa-89f0-8d4613388627)

</div>

<br/>

## Features
- catppuccin theme
- custom rename float window
- open links without netrw
- custom statusline
- ...

## Installation
To install this configuration, simply run the following command in your terminal:

```bash
git clone https://github.com/alsolovyev/nvim-config ~/.config/nvim && nvim
```

## Setup
Before using Neovim with this configuration, ensure you have the necessary plugins and language servers installed. You can do this by running the following commands within Neovim:

```bash
TSInstall query vim vimdoc c go bash html javascript json lua markdown markdown_inline python tsx typescript
```

```bash
MasonInstall gopls ruff-lsp typescript-language-server prettier
```

These commands will install required plugins and language servers for various programming
languages and file types.

## Removal
If you wish to remove this Neovim configuration from your system, you can run the following commands:

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

Please note that this will delete all configuration files and plugins associated with Neovim.

## Contributing
This repository is open to pull requests and issues. Feel free to contribute or report any problems you encounter. Your feedback is appreciated!
