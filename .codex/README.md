# Codex image

## Getting started

### If using ChatGPT subscription (Plus, Pro)

1. Install codex natively `npm -g install @openai/codex`
2. Login to codex `codex login`
3. Back up auth file: `~/.codex/auth.json`
4. Remove native codex `npm -g uninstall @openai/codex`
5. Check that auth file is still in `~/.codex/auth.json`
6. Run codex in your repository you would like to work:

   ```bash
     docker run -it --rm \
       -v "$(pwd)":/workspace \
       -w /workspace \
       -v ~/.codex/auth.json:/root/.codex/auth.json \
       -p 1455:1455 \
       --name codex \
       codex "$@"
   ```
