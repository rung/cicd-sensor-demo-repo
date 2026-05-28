#!/usr/bin/env bash
set -euo pipefail

home="${1:?usage: create-secret-surfaces.sh <fake-home>}"

case "$home" in
  *cicd-sensor-secret-home*) ;;
  *)
    echo "refusing to initialize unexpected HOME path: $home" >&2
    exit 1
    ;;
esac

rm -rf "$home"

mkdir -p \
  "$home/.aws" \
  "$home/.config/gcloud" \
  "$home/.azure" \
  "$home/.docker" \
  "$home/.kube" \
  "$home/.config/gh" \
  "$home/.ssh" \
  "$home/.gnupg/private-keys-v1.d" \
  "$home/.claude" \
  "$home/.cursor" \
  "$home/.codex" \
  "$home/.config/codex" \
  "$home/.kiro" \
  "$home/.continue"

printf '[default]\naws_access_key_id = dummy\naws_secret_access_key = dummy\n' > "$home/.aws/credentials"
printf '[default]\nregion = us-east-1\n' > "$home/.aws/config"
printf '{"client_id":"dummy","client_secret":"dummy"}\n' > "$home/.config/gcloud/application_default_credentials.json"
printf 'dummy\n' > "$home/.config/gcloud/credentials.db"
printf '[{"accessToken":"dummy"}]\n' > "$home/.azure/accessTokens.json"
printf '{"auths":{"registry.example.invalid":{"auth":"dummy"}}}\n' > "$home/.docker/config.json"
printf 'apiVersion: v1\nclusters: []\ncontexts: []\n' > "$home/.kube/config"
printf 'github.com:\n  oauth_token: dummy\n  user: demo\n' > "$home/.config/gh/hosts.yml"
printf '//registry.npmjs.org/:_authToken=dummy\n' > "$home/.npmrc"
printf '[pypi]\nusername = __token__\npassword = dummy\n' > "$home/.pypirc"
printf 'machine github.com login demo password dummy\n' > "$home/.netrc"
printf 'DEMO_SECRET=dummy\n' > "$home/.env"
printf 'git push https://dummy@example.invalid/repo.git\n' > "$home/.bash_history"
printf 'dummy ssh private key fixture\n' > "$home/.ssh/id_ed25519"
printf 'dummy gpg private key fixture\n' > "$home/.gnupg/private-keys-v1.d/dummy.key"
printf '{"hooks":{"demo":"echo fixture"}}\n' > "$home/.claude/settings.json"
printf '{"mcpServers":{"demo":{"command":"echo"}}}\n' > "$home/.cursor/mcp.json"
printf '{"mcpServers":{"demo":{"command":"echo"}}}\n' > "$home/.config/codex/config.json"
printf '{"mcpServers":{"demo":{"command":"echo"}}}\n' > "$home/.kiro/settings.json"
printf '{"models":[]}\n' > "$home/.continue/config.json"

chmod 0600 "$home/.ssh/id_ed25519" "$home/.netrc"
