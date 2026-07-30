# LeetCode 笔记发布说明

## 目录关系

- 编辑源：`D:\obsidian\note\zzliang\LeetCode`
- Quartz 工程：`D:\Codex_memory\leetcode-quartz`
- 发布镜像：`D:\Codex_memory\leetcode-quartz\content`

只在 Obsidian 的 LeetCode 目录中编辑内容。不要直接编辑 `content`，因为下一次同步会覆盖它。

## 首次连接 GitHub

1. 在 GitHub 新建一个空仓库，例如 `leetcode-notes`，不要初始化 README、License 或 `.gitignore`。
2. 在本工程运行：

   ```powershell
   git remote set-url origin https://github.com/你的用户名/leetcode-notes.git
   git push -u origin v5
   ```

3. 将 `quartz.config.yaml` 中的 `baseUrl` 改为：

   ```yaml
   baseUrl: 你的用户名.github.io/leetcode-notes
   ```

4. 在 GitHub 仓库打开 `Settings → Pages`，把 Source 设为 `GitHub Actions`。

## 同步和发布

手动发布：

```powershell
.\sync-and-publish.ps1
```

只同步并提交、不推送：

```powershell
.\sync-and-publish.ps1 -NoPush
```

每次推送到 `v5` 分支后，GitHub Actions 会重新构建并更新 GitHub Pages。

## 自动同步

确认手动发布成功后，可在 Windows“任务计划程序”中创建任务：

- 触发器：登录时启动，之后每 5 分钟重复。
- 程序：`powershell.exe`
- 参数：`-NoProfile -ExecutionPolicy Bypass -File "D:\Codex_memory\leetcode-quartz\sync-and-publish.ps1"`
- 起始于：`D:\Codex_memory\leetcode-quartz`

## 隐私边界

脚本只镜像 LeetCode 目录，并排除 `.obsidian`、`.git` 和 `private` 目录。GitHub Pages 页面是公开的，请勿在该目录放置密码、Token、Cookie 或私人信息。
