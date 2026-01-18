# 图片工具

一个功能丰富的 macOS 图片工具应用，包含图片查看器、图片下载器和用户认证等多个功能模块。

## 功能特性

### 图片查看器
- 选择文件夹加载所有支持的图片格式
- 使用键盘上下方向键切换图片
- 使用界面按钮切换图片
- 自动适应窗口大小显示图片
- 记住上次选择的文件夹

### 图片下载器（开发中）
- 即将推出

### 用户认证
- 支持 Apple Sign-In 登录
- 支持微信登录
- 登录后显示用户头像和信息
- 侧边栏显示登录状态

## 支持的图片格式

- JPG/JPEG
- PNG
- GIF
- BMP
- TIFF
- WebP

## 运行方法

### 使用 Xcode（推荐）

1. 双击打开 `ImageViewer.xcodeproj` 文件
2. 在 Xcode 中选择 `ImageViewer` scheme
3. 点击运行按钮（或按 `Cmd + R`）

### 使用命令行

```bash
xcodebuild -project ImageViewer.xcodeproj -scheme ImageViewer -configuration Debug
```

## 使用说明

### 图片查看器

1. 在侧边栏选择"图片查看器"
2. 点击"选择文件夹"按钮
3. 选择包含图片的文件夹
4. 使用以下方式切换图片：
   - 按键盘 `↑` 键查看上一张图片
   - 按键盘 `↓` 键查看下一张图片
   - 点击界面上的上下箭头按钮
5. 点击"更换文件夹"可以重新选择其他文件夹

### 用户登录

1. 点击侧边栏底部的"使用微信登录"按钮
2. 在登录弹窗中选择登录方式：
   - 使用微信登录（主要方式）
   - 使用 Apple 登录（备选方式）
3. 完成登录后，侧边栏将显示用户头像和信息
4. 点击头像旁的退出按钮可以退出登录

### 侧边栏导航

应用使用侧边栏导航来切换不同的功能模块：
- **图片查看器** - 查看本地文件夹中的图片
- **图片下载器** - 下载网络图片（开发中）

## 技术栈

- Swift 5.0+
- SwiftUI
- Combine
- AuthenticationServices (Apple Sign-In)
- macOS 13.0+

## 项目结构

```
image_view/
├── ImageViewer.xcodeproj/       # Xcode 项目文件
├── ImageViewer/                 # 应用源代码
│   ├── App/                     # 应用入口
│   │   ├── ImageViewerApp.swift
│   │   └── ContentView.swift
│   ├── Features/                # 功能模块
│   │   ├── Authentication/      # 认证功能
│   │   │   ├── AppleSignInManager.swift
│   │   │   ├── WeChatSignInManager.swift
│   │   │   ├── UserSession.swift
│   │   │   ├── AppleSignInButton.swift
│   │   │   └── WeChatSignInButton.swift
│   │   ├── ImageDownloader/     # 图片下载功能
│   │   │   └── ImageDownloaderView.swift
│   │   └── ImageViewer/         # 图片查看功能
│   │       ├── ImageViewerView.swift
│   │       └── ImageViewModel.swift
│   ├── Shared/                  # 共享组件
│   │   ├── AppFeature.swift
│   │   └── SidebarView.swift
│   └── Supporting Files/         # 支持文件
│       ├── Assets.xcassets/
│       └── ImageViewer.entitlements
├── README.md                    # 使用说明
├── PROJECT_STRUCTURE.md         # 项目结构说明
└── .gitignore                   # Git 忽略文件
```

## 开发计划

- [x] 实现图片查看器功能
- [x] 实现用户认证功能（Apple Sign-In 和微信登录）
- [ ] 实现图片下载器功能
- [ ] 添加图片编辑功能
- [ ] 支持更多图片格式
- [ ] 添加图片收藏功能
- [ ] 支持图片导出和分享
