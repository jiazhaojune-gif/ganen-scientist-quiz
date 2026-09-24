#!/bin/bash
# 问天刷题舱 · 一键发布到 GitHub（在你自己的终端里运行，避免后台进程被杀）
# 用法：bash push_to_github.sh
set -e

DIR="/Users/juno/Downloads/21级会计学1班赵嘉-感恩中国科学家奖学金申请/ganen-scientist-quiz"
REPO="ganen-scientist-quiz"

# 找 gh：优先用下载的临时版本，没有就用系统装的
if [ -x /tmp/gh_2.101.0_macOS_arm64/bin/gh ]; then
  GH=/tmp/gh_2.101.0_macOS_arm64/bin/gh
elif command -v gh >/dev/null 2>&1; then
  GH=gh
else
  echo "❌ 没找到 gh。请先安装：brew install gh"; exit 1
fi

cd "$DIR"

# 1) 登录（浏览器授权，请用 jiazhaojune-gif 账号）
if ! $GH auth status >/dev/null 2>&1; then
  echo "👉 即将打开 GitHub 授权，请在浏览器里粘贴一次性验证码并点 Authorize"
  $GH auth login --hostname github.com --git-protocol https --web
fi
OWNER=$($GH api user --jq .login)
echo "✅ 已登录：$OWNER"

# 2) 建公开仓库并推送
if $GH repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  echo "ℹ️  仓库已存在，直接推送"
  git remote remove origin 2>/dev/null || true
  $GH repo set-default "$OWNER/$REPO"
  git remote add origin "https://github.com/$OWNER/$REPO.git" 2>/dev/null || true
  git push -u origin main
else
  $GH repo create "$REPO" --public --source=. --remote=origin --push \
    --description "🚀 感恩中国近现代科学家奖助学金笔试刷题小站 · 140 道各校通用普适题 · 纯前端零依赖，fork 后加一个 my-school.js 就能变成自己学校的版本"
fi
echo "✅ 代码已推送：https://github.com/$OWNER/$REPO"

# 3) 开启 GitHub Pages
TOKEN=$($GH auth token)
curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$OWNER/$REPO/pages" \
  -d '{"source":{"branch":"main","path":"/"}}' > /tmp/pages_resp.json
if grep -q "html_url\|moved permanently\|already exists\|build_type" /tmp/pages_resp.json 2>/dev/null; then
  echo "✅ GitHub Pages 已开启（首次生效需 1–3 分钟）"
else
  echo "⚠️  Pages 自动开启可能失败，请手动：仓库 Settings → Pages → Source 选 main / 根目录"
  cat /tmp/pages_resp.json | head -3
fi

# 4) 补充仓库信息
$GH repo edit "$OWNER/$REPO" --add-topic quiz --add-topic chinese-scientists --add-topic vite-coding 2>/dev/null || true

echo ""
echo "🎉 完成！在线地址： https://$OWNER.github.io/$REPO/"
echo "   （Pages 刚开启可能需要等 1–3 分钟才能访问）"
echo "   把这个链接发给我，我补进小红书文案里。"
