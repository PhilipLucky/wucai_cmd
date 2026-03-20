# wucai_cmd

## 项目简介
这个项目用于在 Windows 资源管理器地址栏中直接输入 `wucai` 启动命令。

目标效果是：

- 在任意文件夹的资源管理器地址栏输入 `wucai` 后回车
- 自动打开一个新的 `CMD` 窗口
- 新窗口的当前路径就是该文件夹
- 并自动执行 `wucai`

它等同于手动执行：

```bat
cmd
wucai
```

## 这是什么
这是一个 `wucai` 的 Windows 地址栏启动适配器，不包含 `wucai` 本体。

它负责解决的是：

- 让 `wucai` 可以从资源管理器地址栏直接启动
- 启动后的工作目录保持为当前文件夹

它不负责分发：

- `wucai` 主程序
- npm 安装产物
- `%APPDATA%\npm\wucai.cmd`

## 前置条件
使用这个项目之前，你需要先在自己的机器上安装 `wucai`。

安装命令：

```bash
npm install -g @wucai/wucai-code
```

安装参考文档：

- http://class.wucai.com/docs/wucai-installation

安装完成后，你的机器上通常应该存在：

```text
%APPDATA%\npm\wucai.cmd
```

如果这个文件不存在，本项目无法正常工作。

## 安装演示视频
可以直接查看安装演示视频：

[install_wucai_cmd_video.mp4](./install_wucai_cmd_video.mp4)

## 为什么不能只靠 PATH
`cmd` 和资源管理器地址栏对 `wucai` 的解析逻辑并不完全一致。

常见情况是：

- `cmd` 可以正确命中 `wucai.cmd`
- 资源管理器地址栏却可能先命中 npm 目录中的无扩展名文件 `wucai`

这时 Windows 会把它当成“文件”而不是“程序”，于是弹出“你要如何打开这个文件”。

所以这里使用的是更稳定的方案：

- 提供真正的 `wucai.exe`
- 通过 `App Paths` 注册给 Windows

这样资源管理器地址栏输入 `wucai` 时，会按启动程序处理。

## 目录说明
- `wucai.exe`：供资源管理器地址栏直接调用的启动器
- `wucai_launcher.cs`：`wucai.exe` 的源码
- `wucai.bat`：批处理兜底方案
- `install_wucai_cmd.cmd`：一键安装脚本，自动按当前目录写入注册表
- `register_wucai_app_path.reg`：注册表示例文件，可选使用
- `install_wucai_cmd_video.mp4`：安装演示视频

## 推荐安装方式
推荐直接使用一键安装脚本，不需要手改路径。

步骤如下：

1. 先执行 `npm install -g @wucai/wucai-code`，确认 `wucai` 已安装。
2. 把本项目放到你自己的固定目录。
3. 双击运行 `install_wucai_cmd.cmd`。
4. 关闭所有资源管理器窗口，再重新打开。
5. 在任意文件夹地址栏输入 `wucai` 后回车测试。

`install_wucai_cmd.cmd` 会自动获取它自己的所在目录，并把当前目录下的 `wucai.exe` 注册到：

```text
HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\wucai.exe
```

因此正常情况下，不需要手动修改路径。

## 手动安装方式
如果你不想用脚本，也可以手动编辑并导入：

- `register_wucai_app_path.reg`

但这种方式需要你自己把里面的路径改成真实路径，所以更推荐用 `install_wucai_cmd.cmd`。

## 验证方式
完成安装后，按下面步骤测试：

1. 打开任意一个文件夹
2. 在地址栏输入 `wucai`
3. 按回车

预期结果：

- 打开一个新的 `CMD` 窗口
- 新窗口当前路径为该文件夹
- 自动执行真实的 `wucai`

## 常见问题

### 1. 仍然弹出“你要如何打开这个文件”
通常说明资源管理器还没有刷新到新的注册信息。

可以尝试：

- 关闭所有资源管理器窗口后重开
- 重启 `explorer.exe`
- 重新登录 Windows

### 2. 打开了 CMD，但没有执行成功
通常说明你本机没有正确安装 `wucai`，或者 `%APPDATA%\npm\wucai.cmd` 不存在。

请先重新检查：

```bash
npm install -g @wucai/wucai-code
```

以及安装文档：

- http://class.wucai.com/docs/wucai-installation

### 3. 下载仓库后是否还需要改 `D:\tool\batch\wucai.exe`
如果使用 `install_wucai_cmd.cmd`，通常不需要改。

因为安装脚本会自动把“脚本当前所在目录”写入注册表。

只有在你选择手动导入 `register_wucai_app_path.reg` 时，才需要自己改路径。

## 致谢
感谢陈博士提供的 `wucai-code`。
