
# How to Backup / Restore .vscode settings

1. create `.vscode` folder at home directory
2. link `settings.json` file
    ```
    ln -sf .dotfile/.vscode-settings/settings.json $HOME/.vscode/settings.json
    ```
3. link `argv.json`
    ```
    ln -sf .dotfile/.vscode-settings/argv.json $HOME/.vscode/argv.json
    ```
4. link `.vscode-cli`
    ```
    ln -sf .dotfile/.vscode-settings/.vscode-cli $HOME/.vscode/cli
    ```
