## sing-box tun 文档

### 目录结构
```
/etc/
  ├── config/
  │   └── tunbox          # tunbox.conf
  ├── init.d/
  │   └── tunbox *        # tunbox.init
  └── tunbox/
      ├── sub *           # 订阅生成核心程序
      ├── template.json   # 生成配置文件的模板
      └── update.sh *     # 管理脚本
```
> [!NOTE]
> 1. 带 * 的文件须要可执行权限。
> 2. template.json 为生成配置文件的模板，采用 [Toperlock/sing-box-subscribe](https://github.com/Toperlock/sing-box-subscribe) 规范。
> 3. sub 文件来自 [rainbend/sing-box-subscribe-cli](https://github.com/rainbend/sing-box-subscribe-cli) 项目。

---

### 日常使用

你可以通过命令行或系统启动项页面进行操作

启用 tunbox 服务
```shell
/etc/init.d/tunbox enable
```
使用以下命令立即启动 tunbox
```shell
/etc/init.d/tunbox start
```
使用以下命令使 tunbox 重新启动
```shell
/etc/init.d/tunbox restart
```
使用以下命令停止运行 tunbox
```shell
/etc/init.d/tunbox stop
```
禁用 tunbox 服务
```shell
/etc/init.d/tunbox disable
```

### 必要配置

- 修改 `/etc/config/tunbox` 文件 `main` 部分 : `option enabled '1'`
- 按注释将订阅地址写入 `/etc/tunbox/update.sh` 文件的指定位置。

### 定时重启/更新订阅

使用系统定时任务功能实现
```shell
13 0 * * * /etc/tunbox/update.sh && /etc/init.d/tunbox restart
```
如订阅地址必须直连
```shell
13 0 * * * /etc/init.d/tunbox stop && /etc/tunbox/update.sh && /etc/init.d/tunbox start
```
