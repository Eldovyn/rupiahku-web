#!/bin/sh
set -e

# Generate runtime config.js agar ENV Dokploy kepakai TANPA perlu rebuild
# Vite embed VITE_* saat BUILD, jadi tanpa file ini ganti ENV di Dokploy tidak ngaruh
# Dengan file ini, ENV di-inject saat container START (runtime override)
cat > /usr/share/nginx/html/config.js <<EOF
window.__RUNTIME_CONFIG__ = {
  VITE_API_BASE_URL: "${VITE_API_BASE_URL:-}",
  VITE_STELLAR_CONTRACT_ADDRESS: "${VITE_STELLAR_CONTRACT_ADDRESS:-}",
  VITE_SEPOLIA_CONTRACT_ADDRESS: "${VITE_SEPOLIA_CONTRACT_ADDRESS:-}"
};
EOF

echo "[entrypoint] Generated /usr/share/nginx/html/config.js:"
cat /usr/share/nginx/html/config.js

exec "$@"
