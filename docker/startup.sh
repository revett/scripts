#! /usr/bin/env bash
#
# Script to run on container startup
#
# @author Charlie Revett

# https://patorjk.com/software/taag/#p=display&f=Small&t=revett%20-%20go%201.17.11
cat ~/ascii.txt
echo ""

# Output Zsh version
echo -e "🛂 checking zsh version..."
echo -e "✅ $(zsh --version)\n"

# Output Go version
if command -v go &> /dev/null
then
  echo -e "🛂 checking go version..."
  echo -e "✅ $(go version)\n"
fi

# Output Node version
if command -v node &> /dev/null
then
  echo -e "🛂 checking node version..."
  echo -e "✅ node $(node --version)\n"
fi

# Check that CONTAINER_PORT is set
echo -e "🛂 checking that \$CONTAINER_PORT is set..."
if [[ -z "${CONTAINER_PORT}" ]]; then
  echo -e '❌ error: "CONTAINER_PORT" environment variable is not set'
  exit 1
fi
echo -e "✅ success: \$CONTAINER_PORT is :$CONTAINER_PORT\n"

echo "🌐 open: http://localhost:$CONTAINER_PORT"