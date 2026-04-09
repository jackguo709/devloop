#!/usr/bin/env bash
# Detect the user's full AI, engineering, and dev environment.
# Runs once during onboarding. Output is read by the main agent.
set -uo pipefail

echo "=== OS ==="
uname -s -r -m
if [ "$(uname -s)" = "Darwin" ]; then
  sw_vers 2>/dev/null || true
elif [ -f /etc/os-release ]; then
  cat /etc/os-release 2>/dev/null | head -5
fi

echo ""
echo "=== SHELL ==="
echo "$SHELL"
echo "node: $(node -v 2>/dev/null || echo 'not found')"
echo "npm: $(npm -v 2>/dev/null || echo 'not found')"
echo "bun: $(bun -v 2>/dev/null || echo 'not found')"
echo "deno: $(deno -v 2>/dev/null || echo 'not found')"
echo "python3: $(python3 --version 2>/dev/null || echo 'not found')"
echo "pip: $(pip3 --version 2>/dev/null | head -1 || echo 'not found')"
echo "go: $(go version 2>/dev/null || echo 'not found')"
echo "rust: $(rustc --version 2>/dev/null || echo 'not found')"
echo "cargo: $(cargo --version 2>/dev/null || echo 'not found')"
echo "ruby: $(ruby -v 2>/dev/null || echo 'not found')"
echo "java: $(java -version 2>&1 | head -1 || echo 'not found')"
echo "dotnet: $(dotnet --version 2>/dev/null || echo 'not found')"
echo "swift: $(swift --version 2>/dev/null | head -1 || echo 'not found')"

echo ""
echo "=== PACKAGE MANAGERS ==="
echo "--- brew ---"
brew list --formula 2>/dev/null | tr '\n' ', ' || echo "not installed"
echo ""
echo "--- npm global ---"
npm ls -g --depth=0 2>/dev/null || echo "none"
echo "--- bun global ---"
bun pm ls -g 2>/dev/null || echo "none or not installed"
echo "--- pip ---"
pip3 list --format=columns 2>/dev/null | head -30 || echo "none"
echo "--- cargo ---"
cargo install --list 2>/dev/null | head -20 || echo "none or not installed"
echo "--- go ---"
gopath=$(go env GOPATH 2>/dev/null)
if [ -n "$gopath" ] && [ -d "$gopath/bin" ]; then
  ls "$gopath/bin" 2>/dev/null | head -20
else
  echo "none or not installed"
fi

echo ""
echo "=== AI TOOLS ==="
echo "--- claude ---"
command -v claude &>/dev/null && claude --version 2>/dev/null || echo "not found"
echo "--- codex ---"
command -v codex &>/dev/null && codex --version 2>/dev/null || echo "not found"
echo "--- cursor ---"
if [ "$(uname -s)" = "Darwin" ]; then
  [ -d /Applications/Cursor.app ] && echo "installed" || echo "not found"
elif command -v cursor &>/dev/null; then
  echo "installed"
else
  echo "not found"
fi
echo "--- copilot ---"
gh extension list 2>/dev/null | grep copilot || echo "not found"
echo "--- aider ---"
command -v aider &>/dev/null && aider --version 2>/dev/null || echo "not found"
echo "--- cline ---"
command -v cline &>/dev/null && echo "installed" || echo "not found"

echo ""
echo "=== IDEs & EDITORS ==="
if [ "$(uname -s)" = "Darwin" ]; then
  for app in "Visual Studio Code" "Visual Studio Code - Insiders" "Cursor" "Zed" "WebStorm" "IntelliJ IDEA" "PyCharm" "Xcode" "Android Studio" "Sublime Text" "Nova" "Fleet"; do
    [ -d "/Applications/${app}.app" ] && echo "$app: installed"
  done
else
  for cmd in code code-insiders cursor zed webstorm idea pycharm subl; do
    command -v "$cmd" &>/dev/null && echo "$cmd: installed"
  done
fi
echo "--- vscode extensions ---"
code --list-extensions 2>/dev/null | head -30 || echo "not available"
echo "--- cursor extensions ---"
cursor --list-extensions 2>/dev/null | head -30 || echo "not available"

echo ""
echo "=== CLAUDE CONFIG ==="
echo "--- settings.json ---"
cat ~/.claude/settings.json 2>/dev/null || echo "not found"
echo ""
echo "--- user skills ---"
ls ~/.claude/skills/ 2>/dev/null || echo "none"
echo "--- project skills ---"
find . -path "*/.claude/skills/*" -name "SKILL.md" 2>/dev/null | head -10 || echo "none"
echo "--- plugins ---"
cat ~/.claude/plugins/installed_plugins.json 2>/dev/null | python3 -c "
import sys,json
try:
  d=json.load(sys.stdin)
  for name in d.get('plugins',{}):
    print(f'  {name}')
except: pass
" 2>/dev/null || echo "none"

echo ""
echo "=== MCP SERVERS ==="
claude mcp list 2>/dev/null || echo "not available"
# Check claude.ai managed MCP servers
if [ "$(uname -s)" = "Darwin" ]; then
  ls ~/Library/Application\ Support/Claude/claude_desktop_config.json 2>/dev/null && \
    python3 -c "
import json
with open('$HOME/Library/Application Support/Claude/claude_desktop_config.json') as f:
  d = json.load(f)
  for name in d.get('mcpServers', {}):
    print(f'  desktop: {name}')
" 2>/dev/null || true
elif [ -f ~/.config/claude/claude_desktop_config.json ]; then
  python3 -c "
import json
with open('$HOME/.config/claude/claude_desktop_config.json') as f:
  d = json.load(f)
  for name in d.get('mcpServers', {}):
    print(f'  desktop: {name}')
" 2>/dev/null || true
fi

echo ""
echo "=== PROJECTS ==="
echo "--- cli session slugs ---"
for dir in ~/.claude/projects/*/; do
  [ -d "$dir" ] || continue
  slug=$(basename "$dir")
  sessions=$(ls "$dir"/*.jsonl 2>/dev/null | wc -l | tr -d ' ')
  echo "$slug ($sessions sessions)"
done

echo ""
echo "--- projects on disk (from cli session slugs) ---"
git_user=$(git config --global user.email 2>/dev/null || echo "unknown")
git_username=$(git config --global user.name 2>/dev/null || echo "")
# Build ownership pattern: username + whoami + GitHub orgs
ownership_pattern="$(whoami)"
[ -n "$git_username" ] && ownership_pattern="${ownership_pattern}|${git_username}"
gh_orgs=$(gh api user/orgs --jq '.[].login' 2>/dev/null | tr '\n' '|' || true)
[ -n "$gh_orgs" ] && ownership_pattern="${ownership_pattern}|${gh_orgs%|}"
echo "git user: $git_user"
echo "ownership match: $ownership_pattern"
# Resolve project paths from cli session slugs by greedy directory matching.
# Slugs encode paths with / replaced by - (e.g. -Users-foo-my-app → /Users/foo/my-app).
# Since directory names can contain dashes, we walk the slug left-to-right, greedily
# consuming as many segments as form a valid directory before taking the next slash.
resolve_slug() {
  local slug="${1#-}" # strip leading dash
  local path="/"
  local remaining="$slug"
  while [ -n "$remaining" ]; do
    local best="" best_rest=""
    local try="$remaining"
    # Try longest possible segment first (greedy), then shorten
    while [ -n "$try" ]; do
      local candidate="$path$try"
      if [ -d "$candidate" ] || [ -f "$candidate" ]; then
        best="$candidate"
        # What's left after this segment
        best_rest="${remaining#"$try"}"
        best_rest="${best_rest#-}" # strip leading dash from remainder
        break
      fi
      # Remove last -segment to try a shorter match
      case "$try" in
        *-*) try="${try%-*}" ;;
        *) break ;;
      esac
    done
    if [ -n "$best" ]; then
      path="$best/"
      remaining="$best_rest"
    else
      # No valid directory found, give up
      echo ""
      return
    fi
  done
  # Remove trailing slash
  echo "${path%/}"
}
seen_projects=""
for dir in ~/.claude/projects/*/; do
  [ -d "$dir" ] || continue
  slug=$(basename "$dir")
  # Skip worktree and conductor session slugs
  case "$slug" in *-claude-worktrees-*|*-session-[0-9]*) continue ;; esac
  proj=$(resolve_slug "$slug")
  [ -z "$proj" ] && continue
  [ -d "$proj/.git" ] || continue
  # Deduplicate
  case "$seen_projects" in *"|$proj|"*) continue ;; esac
  seen_projects="${seen_projects}|$proj|"
  remote=$(git -C "$proj" remote get-url origin 2>/dev/null || echo "no remote")
  # Ownership: check if remote matches user or their orgs
  ownership="USER"
  if [ "$remote" != "no remote" ]; then
    if ! echo "$remote" | grep -qiE "$ownership_pattern" 2>/dev/null; then
      ownership="THIRD_PARTY"
    fi
  fi
  # Agent/assistant markers
  extras=""
  for m in SOUL.md IDENTITY.md AGENTS.md TOOLS.md; do
    [ -f "$proj/$m" ] && extras="$extras assistant:$m" && break
  done
  # Agent frameworks in deps
  if [ -f "$proj/package.json" ]; then
    fw=$(grep -oE '"@anthropic-ai/claude-agent-sdk"|"@langchain/core"|"crewai"|"autogen"|"@openai/agents"' "$proj/package.json" 2>/dev/null | tr -d '"' | tr '\n' ',' || true)
    [ -n "$fw" ] && extras="$extras frameworks:$fw"
  fi
  if [ -f "$proj/requirements.txt" ]; then
    fw=$(grep -oE 'langchain|crewai|autogen|openai-agents' "$proj/requirements.txt" 2>/dev/null | tr '\n' ',' || true)
    [ -n "$fw" ] && extras="$extras py-frameworks:$fw"
  fi
  echo "$ownership: $proj | $remote${extras:+ | $extras}"
done

echo ""
echo "--- desktop sessions ---"
# Check both current and legacy directory names
if [ "$(uname -s)" = "Darwin" ]; then
  base="$HOME/Library/Application Support/Claude"
elif [ "$(uname -s)" = "Linux" ]; then
  echo "No Claude Desktop on Linux"
  base=""
else
  base="$HOME/AppData/Roaming/Claude"
fi
if [ -n "$base" ]; then
  for dirname in "claude-code-sessions" "local-agent-mode-sessions"; do
    desktop_path="$base/$dirname"
    if [ -d "$desktop_path" ]; then
      session_count=$(find "$desktop_path" -name "audit.jsonl" 2>/dev/null | wc -l | tr -d ' ')
      echo "Desktop sessions ($dirname): $session_count audit.jsonl files"
    fi
  done
  [ ! -d "$base/claude-code-sessions" ] && [ ! -d "$base/local-agent-mode-sessions" ] && echo "No desktop sessions found"
fi

echo ""
echo "=== INFRA & DEPLOY ==="
echo "docker: $(docker --version 2>/dev/null || echo 'not found')"
echo "docker-compose: $(docker compose version 2>/dev/null || echo 'not found')"
echo "kubectl: $(kubectl version --client --short 2>/dev/null || echo 'not found')"
echo "terraform: $(terraform version 2>/dev/null | head -1 || echo 'not found')"
echo "fly: $(fly version 2>/dev/null || echo 'not found')"
echo "vercel: $(vercel --version 2>/dev/null || echo 'not found')"
echo "netlify: $(netlify --version 2>/dev/null || echo 'not found')"
echo "railway: $(railway --version 2>/dev/null || echo 'not found')"
echo "render: $(render --version 2>/dev/null || echo 'not found')"
echo "supabase: $(supabase --version 2>/dev/null || echo 'not found')"
echo "firebase: $(firebase --version 2>/dev/null || echo 'not found')"
echo "aws: $(aws --version 2>/dev/null || echo 'not found')"
echo "gcloud: $(gcloud --version 2>/dev/null | head -1 || echo 'not found')"
echo "az: $(az --version 2>/dev/null | head -1 || echo 'not found')"
echo "heroku: $(heroku --version 2>/dev/null || echo 'not found')"
echo "gh: $(gh --version 2>/dev/null | head -1 || echo 'not found')"

echo ""
echo "=== DB TOOLS ==="
echo "psql: $(psql --version 2>/dev/null || echo 'not found')"
echo "mysql: $(mysql --version 2>/dev/null || echo 'not found')"
echo "sqlite3: $(sqlite3 --version 2>/dev/null || echo 'not found')"
echo "redis-cli: $(redis-cli --version 2>/dev/null || echo 'not found')"
echo "mongosh: $(mongosh --version 2>/dev/null || echo 'not found')"
