# spaceneovim 🛠️

Welcome to spaceneovim, a powerful and flexible framework designed to enhance your Neovim experience, inspired by Spacemacs. Our framework is dedicated to providing a highly customizable and easy-to-use environment for all users, whether you're an experienced developer or just getting started with Neovim. 🌟

## Inspired by Spacemacs

spaceneovim draws inspiration from Spacemacs, aiming to bring its efficient, mnemonic, and enjoyable key-binding system to the Neovim environment. This inspiration guides our approach to making development faster, more efficient, and enjoyable for programmers of all skill levels.

## Features 🎉

- **GPL-3.0 Licensed** 📜: spaceneovim is open source and free to use, modify, and distribute under the terms of the GNU General Public License v3.0.
- **Built Following Clean Architecture Pattern** 🏛️: Embracing the principles of Clean Architecture, spaceneovim ensures that the configuration structure is intuitive, maintainable, and scalable.
- **Easy to Configure** ⚙️: We prioritize simplicity and efficiency, making it straightforward for users to adjust settings and preferences to fit their needs.
- **Plugin Flexibility** 🔄: Switching between plugins or adding new ones has never been easier. Our framework is designed to accommodate changes seamlessly, empowering users to customize their development environment to their liking.

## Getting Started 🚀

1. **Installation**: Clone this repository to your local machine and follow the installation instructions provided in the `INSTALL.md` file to set up the framework with Neovim.

   ```bash
   git clone https://github.com/yourusername/spaceneovim.git
   cd spaceneovim
   ```

2. **Configuration**: Navigate to the `config` directory to customize your Neovim settings. We've provided a comprehensive guide in the `CONFIGURE.md` file to help you get started.

3. **Plugin Management**: To add or remove plugins, edit the `plugins.lua` file in the `plugins` directory. Our framework supports a variety of plugin managers, and detailed instructions can be found in `PLUGINS.md`.

## File Structure 📂

The framework follows a Clean Architecture pattern to ensure a modular, scalable, and maintainable setup. Here is the structure of the configuration:

<pre>
├── init.lua
├── ftplugin
│   ├── java.lua
│   └── typescript.lua
├── lua
│   ├── application
│   │   ├── hooks
│   │   │   ├── init.lua
│   │   │   ├── buffer.lua
│   │   │   ├── ...
│   │   │   └── lsp.lua
│   │   └── use_cases
│   │       ├── bookmarker.lua
│   │       ├── buffer.lua
│   │       ├── ...
│   │       └── zen.lua
│   ├── config
│   │   ├── default.lua
│   │   └── init.lua
│   ├── domain
│   │   ├── environments.lua
│   │   ├── log_levels.lua
│   │   └── maps
│   │       ├── application.lua
│   │       ├── buffer.lua
│   │       ├── ...
│   │       └── zoom.lua
│   └── infraestrucuture
│       ├── adapters
│       │   ├── bookmarker.lua
│       │   ├── buffer.lua
│       │   ├── ...
│       │   └── zen.lua
│       ├── events
│       │   ├── buffer.lua
│       │   ├── init.lua
│       │   └── lifecycle.lua
│       ├── plugins
│       │   ├── bookmarker.lua
│       │   ├── buffer.lua
│       │   ├── ...
│       │   ├── lazy
│       │   │   ├── configs
│       │   │   │   ├── bookmarker.lua
│       │   │   │   ├── buffer.lua
│       │   │   │   ├── ...
│       │   │   │   └── zen.lua
│       │   │   └── init.lua
│       │   ├── logger.lua
│       │   ├── lsp.lua
│       │   ├── ...
│       │   └── zen.lua
│       └── utils
│           └── file.lua
└── README.md
</pre>

## Documentation 📚

For more detailed information about the framework's architecture, configuration options, and plugin management, please refer to the `docs` directory. Here you'll find everything you need to customize your Neovim setup to your heart's content.

## Contributing 🤝

We welcome contributions from the community! Whether it's adding new features, improving existing ones, or fixing bugs, your help is invaluable. Please see `CONTRIBUTING.md` for guidelines on how to contribute to this project.

## License 📄

This project is licensed under the GNU General Public License v3.0. For more information, please see the `LICENSE` file.

## Contact 📩

For questions, suggestions, or support, please open an issue in the GitHub repository, or contact us directly at [your email].

Happy coding with Neovim! 💻🎈
