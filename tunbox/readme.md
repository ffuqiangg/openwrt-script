## sing-box tun 文档

```
tunbox.conf > /etc/config/tunbox
tunbox.init > /etc/init.d/tunbox *
sub > /etc/tunbox/sub *
template.json > /etc/tunbox/template.json
update.sh > /etc/tunbox/update.sh *
```

> [!NOTE]
> 1. 带 * 的文件须要可执行权限。
> 2. 订阅地址填入 update.sh 文件的订阅配置部分。
> 3. 执行 update.sh 脚本下载订阅并生成配置文件。
> 4. template.json 文件为生成订阅文件的模板，模板采用 [Toperlock/sing-box-subscribe](https://github.com/Toperlock/sing-box-subscribe) 规范。
> 5. sub 文件来自 [rainbend/sing-box-subscribe-cli](https://github.com/rainbend/sing-box-subscribe-cli) 项目。
