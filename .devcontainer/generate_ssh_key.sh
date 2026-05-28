#!/usr/bin/env bash
# generate_ssh_key.sh
# Generates an Ed25519 SSH key suitable for git operations.
# Usage: ./generate_ssh_key.sh [email] [key_name]

set -euo pipefail

# ── Arguments ────────────────────────────────────────────────────────────────
EMAIL="${1:-}"
KEY_NAME="${2:-id_git_ed25519}"
KEY_PATH="${HOME}/.ssh/${KEY_NAME}"

# ── Prompt for email if not provided ─────────────────────────────────────────
if [[ -z "$EMAIL" ]]; then
  read -rp "Enter the email address for this SSH key: " EMAIL
fi

if [[ -z "$EMAIL" ]]; then
  echo "Error: an email address is required." >&2
  exit 1
fi

# ── Create ~/.ssh if it doesn't exist ────────────────────────────────────────
mkdir -p "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"

# ── Guard against overwriting an existing key ─────────────────────────────────
if [[ -f "$KEY_PATH" ]]; then
  echo "Error: key already exists at ${KEY_PATH}." >&2
  echo "Remove it first, or choose a different name:  $0 <email> <key_name>" >&2
  exit 1
fi

# ── Generate key ──────────────────────────────────────────────────────────────
echo "Generating Ed25519 SSH key for <${EMAIL}> at ${KEY_PATH} …"
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""

echo ""
echo "✓ Key pair created:"
echo "    Private key : ${KEY_PATH}"
echo "    Public key  : ${KEY_PATH}.pub"

# ── Add to ssh-agent (best-effort) ────────────────────────────────────────────
if ssh-add -l &>/dev/null || ssh-agent -s &>/dev/null; then
  ssh-add "$KEY_PATH" 2>/dev/null && echo "✓ Key added to ssh-agent." || true
fi

# ── Append an ~/.ssh/config entry ────────────────────────────────────────────
CONFIG="${HOME}/.ssh/config"
MARKER="# github.com – ${KEY_NAME}"

if grep -qF "$MARKER" "$CONFIG" 2>/dev/null; then
  echo "✓ ~/.ssh/config entry already present, skipping."
else
  cat >> "$CONFIG" <<EOF

${MARKER}
Host github.com
    HostName github.com
    User git
    IdentityFile ${KEY_PATH}
    AddKeysToAgent yes
EOF
  chmod 600 "$CONFIG"
  echo "✓ ~/.ssh/config updated."
fi

echo ""
echo "Public key (copy this if you want to add it manually):"
echo "──────────────────────────────────────────────────────"
cat "${KEY_PATH}.pub"
echo "──────────────────────────────────────────────────────"
echo ""