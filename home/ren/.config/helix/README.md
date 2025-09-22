# Helix Configuration

## Paths
1. `~/.config/helix/`
2. `/usr/lib/helix/`

**Arch Linux**
Put themes to `/usr/lib/helix` if you don't have themes foldier in `~/.config/helix`

## Fetch Snippets with [`simple-completion-language-server`](https://github.com/estin/simple-completion-language-server)

```bash
# Clone or update snippets source repos to `~/.config/helix/external-snippets/<repo path>`
mkdir -p  ~/.config/helix/external-snippets
simple-completion-language-server fetch-external-snippets

# Try to find and parse snippets
simple-completion-language-server validate-snippets
```
