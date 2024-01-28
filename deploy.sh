#  deploy.sh
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd public

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.gitee.io
# git push -f git@gitee.com:<USERNAME>/<USERNAME>.gitee.io.git master

# 如果发布到 https://<USERNAME>.gitee.io/<REPO>
git push -f git@gitee.com:codecwg/blog.git master:pages

cd -