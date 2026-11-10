# lobster（虾搞）-- 开源免费的安卓版中国象棋学习辅助工具

[![Build-Lobster](https://github.com/DanielQuan618/lobster/actions/workflows/android.yml/badge.svg)](https://github.com/DanielQuan618/lobster/actions/workflows/android.yml)
[![CodeQL](https://github.com/DanielQuan618/lobster/actions/workflows/codeql.yml/badge.svg)](https://github.com/DanielQuan618/lobster/actions/workflows/codeql.yml)
[![Release](https://img.shields.io/github/v/release/DanielQuan618/lobster)](https://github.com/DanielQuan618/lobster/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE)
![Platform](https://img.shields.io/badge/Android-8.0%2B%20(API%2026)-green)

## 介绍

lobster（中文名**虾搞**）是一个开源免费的安卓版中国象棋学习辅助工具：聚焦"连线"功能——
识别其他象棋 App 的棋盘画面（ONNX 角点式 / YOLO 双引擎），在悬浮窗实时给出皮卡鱼引擎
与桔库开局库的走法建议。

打开应用即达连线页：默认"靠近玩家的一侧（屏幕下方）＝我方"，自动判定我方执红还是执黑
（含换边局），**只为我方给出指导**；识别为只读，所有着法由玩家手动完成。连线页内置
**"性能诊断"开关**：开启后每次识别的分段耗时自动落盘到系统 Download 目录（md 文件，
应用内标明位置），识别变慢时可一键采集数据定位瓶颈；**空闲预计算（β 测试版）**：
对方思考时引擎提前计算当前局面，命中预判线零等待出着，可一键关闭；另有**手动"检查更新"按钮**
（不自动检查、不内置下载，仅查询 GitHub 正式版提示）。使用说明与原理见
[docs/assist-helper.md](docs/assist-helper.md)，架构与实现见 [docs/技术报告.md](docs/技术报告.md)。

**免责声明**：本软件（虾搞 / lobster）为象棋学习辅助工具，仅供个人学习、复盘研究与技术交流使用。
仅通过系统录屏授权识别画面并以悬浮窗显示走法建议，不包含自动走子、触摸注入、无障碍服务等功能；
**严禁用于任何正式比赛、等级分对局、网络对局平台或赌博等违反平台规则与法律法规的场景**。
设计边界与自行验证方法见 [DESIGN_BOUNDARIES.md](DESIGN_BOUNDARIES.md)；
应用内免责声明全文以首启弹窗为准。

## 上游来源与 fork 说明（重要）

本项目是 **[Silva6c/chess-dike](https://github.com/Silva6c/chess-dike)**（GPL-3.0）的
二次开发 fork，代码对齐上游 **v3.3 稳定版**（2026-11-02）；上游项目名与本 fork 的
品牌无关，本 fork 以自己的名义独立发布。上游项目及其作者的著作权依 GPL-3.0 保留，
第三方组件的版权与许可义务见 [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)。

**签名与发布说明（fork 差异）**：

- 上游自 v3.2 起轮换了发布签名密钥并进入"安全版本线"，其官方签名证书指纹仅适用于
  **上游官方 Release**；**本 fork 的构建不使用、也无法伪造上游证书**，请勿用上游指纹核验本 fork 的安装包。
- 本仓库**不包含任何签名密钥**（`*.jks` 已在 `.gitignore` 排除）。从源码构建时，
  若 `local.properties` 未配置 `CCHES_STORE_PWD` / `CCHES_KEY_PWD`，release 构建
  自动回退 debug 签名以便直接出包；如你以自己身份发布，请替换为自有 keystore。
- 本 fork 的应用内"检查更新"只查询本仓（DanielQuan618/lobster）的 Releases 元数据，
  不检查上游版本。

## 版权与许可

- **本 fork 的修改部分**：Copyright (C) 2026 DanielQuan618，以 GPL-3.0 发布。
- **上游项目 chess-dike**：Copyright (C) Silva6c 及其贡献者；本 fork 依 GPL-3.0
  使用其代码二次开发，原项目的著作权与许可声明依原样保留。上游品牌名不在本 fork
  中作为本项目品牌使用。
- **第三方组件与版权物**：来源与许可义务见 [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)；
  完整许可条款见 [LICENSE](LICENSE)。对外分发 APK 时请遵守 GPL-3.0 的源码提供义务。

## 相关项目：内阁 Cabinet（上游原作者的姊妹项目）

如果你喜欢本项目的"连线"功能，上游原作者的另一条路线
**[内阁 Cabinet](https://github.com/Silva6c/cabinet)** 值得认真一试——"手机做眼睛，
电脑做脑子"：手机端录屏识别棋盘、悬浮窗展示建议，皮卡鱼引擎与开局库放在电脑端，
经 WSS（局域网 / Tailscale 组网）实时分析。两个项目遵循同样的只读合规底线
（无自动走子、无触摸注入、无无障碍服务）与开源免费原则——**随手练棋用本项目，
深度复盘与长时间使用用内阁**。

| | lobster（本项目） | 内阁 Cabinet |
|---|---|---|
| 架构 | **全离线单机**：识别、引擎、开局库全在手机，零外部依赖 | **双端协作**：手机识别 + 悬浮窗，电脑跑引擎与开局库，WSS 通信（局域网 / Tailscale） |
| 算力 | 受手机 SoC 封顶：神经网络推理与 NNUE 搜索抢同一颗 CPU | 吃满电脑算力：Hash 可开到 GB 级、线程全给，开局库命中秒回 |
| 手机负载 | **高**：屏幕采集 + ONNX 推理（4 线程）+ 皮卡鱼（半核）同时跑 | **低**：只做采集、识别与悬浮窗绘制 |
| 发热与降频 | 长时间使用会发热；触发系统温控后 CPU 降频，**识别与出着速度都会下降**（见下方警告） | 手机基本不热，搜索负载在电脑侧 |
| 部署 | 装 APK 即用：免网络、免配对、免电脑 | 需一台常开的 Windows 电脑 + 一次扫码配对；可选用 Tailscale 组网 |
| 建议信息 | 走法箭头、中文着法、优劣势、深度、MultiPV 变招 | 更丰富：胜率 / WDL / 多路 PV / 算力悬浮窗直调 |
| **适用** | 随手练棋、无电脑环境、短时使用、开箱即用 | 深度复盘、长时间连续使用、追求最强引擎、有常开电脑 |
| **不适用** | 长时间高强度连续使用（发热降频，见下） | 无电脑 / 不愿部署 / 只想要一个 App 就用的场景 |
| 共同原则 | 只读屏幕、悬浮窗提示；**无自动走子、无触摸注入、无障碍服务** | 同左 |

> **⚠️ 发热与性能警告（重要）**：本项目把**识别（ONNX 4 线程）**与**皮卡鱼引擎
> （核心数的一半，给识别与系统留核）**都放在手机上跑。识别侧另有自适应节拍器
> （画面变化后自动收紧、空闲时自动放宽）与停稳门槛（跳过走子动画帧），日常使用的
> 响应与发热已明显优化；但**长时间连续连线（尤其夏季、边充边用、戴厚保护壳）仍会
> 造成机身发热**；系统温控介入后 CPU 降频，**识别单帧耗时上升、建议更新变慢，
> 引擎同深度出着也更慢**——这是单机全栈方案的固有代价，不是 Bug。
>
> 缓解办法：避免边充边用；摘掉厚壳或加散热背夹；长时间使用中途暂停识别让手机休息；
> 对即时性要求高时选**时间制**（固定时长收束，节奏可预期）而非深度制；必要时降低深度档、
> 或切到较轻的 YOLO 引擎。
>
> 如果你的场景是**长时间、高强度**使用，建议改用[内阁 Cabinet](https://github.com/Silva6c/cabinet)：
> 引擎跑在电脑上，手机只做识别与显示，几乎不发热。

## 鸣谢

- 上游项目 **chess-dike**（作者 Silva6c，[GitHub](https://github.com/Silva6c/chess-dike)）——
  本项目在其基础上二次开发（GPL-3.0），代码对齐其 v3.3 稳定版；
- 原项目"象棋鱼"（作者 zfdang，[GitHub](https://github.com/zfdang/chinese-chess-android)）——
  上游项目曾在其基础上二次开发（对弈/打谱功能已在上游 v3.0 裁撤，仅存历史渊源）；
- [Vincentzyx/VinXiangQi](https://github.com/Vincentzyx/VinXiangQi) —— YOLO 棋子检测权重文件来源（GPL-3.0）；
- [yolo12138/Chinese_Chess_Recognition](https://huggingface.co/spaces/yolo12138/Chinese_Chess_Recognition) ——
  ONNX 两步式识别引擎（RTMPose 角点 + Swin 分类）的模型与算法来源；
- [Shirakawa-Kotone/chinese-chess-helper](https://github.com/Shirakawa-Kotone/chinese-chess-helper) ——
  两步式识别的工程实现参考（OnnxRecognizer 原实现）；
- [Pikafish](https://github.com/official-pikafish/Pikafish) 引擎团队与
  [DroidFish](https://github.com/peterosterlund2/droidfish)（Peter Österlund）—— 引擎框架基座（GPL-3.0）。

## 从源码构建

要求：Android Studio（或 Gradle 8.x + JDK 17）+ Android SDK 34 + NDK 25。

```bash
./gradlew :app:assembleArmv8-dotprodRelease      # 推荐：dotprod 变体
./gradlew :app:assembleArmv8Release              # 兼容变体
./gradlew :app:testArmv8-dotprodDebugUnitTest    # 单元测试
```

两个变体都内置 `armv8` 与 `armv8-dotprod` 两个引擎文件，运行时按 CPU 特性
**自动选择**（dotprod 机型的 NNUE 推理走专用指令，快数倍）——装哪个变体都不会
选错引擎，flavor 仅作产物命名与回退值区分。

**大文件说明**（本仓库已内置/未内置）：

| 内容 | git 仓库 | 本地构建 | 说明 |
| --- | --- | --- | --- |
| Pikafish 引擎（`libpikafish-armv8.so` / `-dotprod.so`，GPL-3.0） | ✅ 分发 | ✅ 内置 | `app/src/main/pikafish/arm64-v8a/` |
| Pikafish NNUE 权重（`libpikafish.nnue.so`，GPL-3.0） | ✅ 分发 | ✅ 内置 | 同上，约 45MB |
| YOLO 棋子检测模型（`assets/yolov5n_xq_fp16.tflite`） | ✅ 分发 | ✅ 内置 | 权重来自 VinXiangQi |
| **ONNX 识别模型**（`assets/models/*.onnx`，共约 21.5MB） | ❌ `.gitignore` 排除 | 需自行放置 | 两步式识别引擎（RTMPose 角点 + Swin 分类，模型来自 Hugging Face Chinese_Chess_Recognition）；**未放置时应用自动回退 YOLO，连线页 ONNX 选项自动禁用**，见 `assets/models/README.md` |
| **桔库开局库**（`assets/databases/*.obk.zip`） | ❌ `.gitignore` 排除 | 需自行获取放置 | 第三方版权内容不入 git；**缺失时连线自动降级为纯引擎模式**，不影响使用 |

**签名**：本仓库不分发签名密钥。release 构建优先读取 `local.properties` 中的
`CCHES_STORE_PWD` / `CCHES_KEY_PWD` 与本地 keystore（默认文件名
`app/cchess.release.2026.jks`，自行放置，不入库）；任一缺失时自动回退 debug
签名保证可构建。CI 如配置了仓库 Secrets（`ANDROID_KEYSTORE_B64` /
`ANDROID_STORE_PWD` / `ANDROID_KEY_PWD`）则使用注入的同钥真签，未配置则为
debug 签名。

**CI 自动出包**：推送 `v*` 语义化版本 tag（如 `v3.3.0`）可触发构建
（单元测试 + 双 flavor 出包）。版权物由构建时从本仓 `assets` 预发布 Release
拉取注入（可选；本 fork 未内置版权物时自动跳过并回退对应功能）；本 fork 的
签名指纹门禁仅在检测到注入密钥时生效，debug 签名包不会进入正式 Release。
本地构建则按上表自行放置大文件。

## 获取渠道与签名核验

- 本 fork 的发布渠道：[github.com/DanielQuan618/lobster 的 Releases](https://github.com/DanielQuan618/lobster/releases)；
  上游原项目：[github.com/Silva6c/chess-dike](https://github.com/Silva6c/chess-dike)。
- **请勿混用两边的安装包与证书**：上游官方 Release 由其官方密钥签名，本 fork
  若以自有密钥发布则证书不同；跨来源安装通常需要先卸载再安装。
- 本 fork 的构建若未配置签名密钥则为 debug 签名（仅适合自行测试）；正式分发
  请自行以自有 keystore 签名，并用 `apksigner verify --print-certs <apk>` 核验。

**版本规则**：`versionCode` = git 提交数（`app/build.gradle.kts` 的 `gitCommitCount`，
无 git 环境兜底为 1，且带 43 的下限地板——保证历次交付版本号单调递增、老设备可覆盖升级）；
`versionName` 不手写，由 git 标签推导（`git describe --tags --match "v*"` 去掉前导
`v`）——发布提交上 = `3.3.0`，标签后的开发构建 = `3.3.0-1-g<hash>`，无 git/标签回退
`0.0.0-dev`，版本号只有 tag 这一个事实源；
APK 产物名 `Lobster_<日期>_<versionCode>_<变体>-<构建类型>.apk`。

## 文档

| 文档 | 内容 |
|---|---|
| [DESIGN_BOUNDARIES.md](DESIGN_BOUNDARIES.md) | 客观能力边界：只读输入、输出形态、权限与网络面、红线清单、自行验证方法 |
| [docs/技术报告.md](docs/技术报告.md) | 架构定稿：识别管线、引擎链路、悬浮窗、测试体系 |
| [docs/assist-helper.md](docs/assist-helper.md) | 连线功能使用说明与原理 |
| [docs/README.md](docs/README.md) | 文档地图 |
| [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) | 第三方组件与许可义务清单（GPL 合规） |

## 开源免费

希望更多人能参与进来，一起打造一个好用的安卓Android版的中国象棋学习工具！

## 参考

#### 基于Android的中国象棋
https://github.com/kongxiangchx/ChineseChess

#### DroidFish Android Chess App
https://github.com/peterosterlund2/droidfish

#### cchess是一个Python版的中国象棋库
https://github.com/walker8088/cchess
