## sing-box tun 文档

```
 /etc
  ├── config
  |     └── tunbox.conf > tunbox
  ├── init.d
  |     └── tunbox.init > tunbox *
  └── tunbox
        ├── sub > sub *
        ├── template.json > template.json
        └── update.sh > update.sh *
```

- 带 * 的文件须要可执行权限。
- 订阅地址填入 update.sh 文件的订阅配置部分。
- 执行 update.sh 脚本下载订阅并生成配置文件。
- template.json 文件为生成订阅文件的模板，模板采用 [Toperlock/sing-box-subscribe](https://github.com/Toperlock/sing-box-subscribe) 规范。
- sub 文件来自 [rainbend/sing-box-subscribe-cli](https://github.com/rainbend/sing-box-subscribe-cli) 项目。
