# 图片查看器

一个简单的macOS图片查看应用，支持浏览文件夹中的图片并使用上下方向键切换。

## 功能特性

- 选择文件夹加载所有支持的图片格式
- 使用键盘上下方向键切换图片
- 使用界面按钮切换图片
- 自动适应窗口大小显示图片
- 记住上次选择的文件夹

## 支持的图片格式

- JPG/JPEG
- PNG
- GIF
- BMP
- TIFF
- WebP

## 运行方法

### 使用Xcode（推荐）

1. 双击打开 `ImageViewer.xcodeproj` 文件
2. 在Xcode中选择 `ImageViewer` scheme
3. 点击运行按钮（或按 `Cmd + R`）

### 使用命令行

```bash
xcodebuild -project ImageViewer.xcodeproj -scheme ImageViewer -configuration Debug
```

## 使用说明

1. 启动应用后，点击"选择文件夹"按钮
2. 选择包含图片的文件夹
3. 使用以下方式切换图片：
   - 按键盘 `↑` 键查看上一张图片
   - 按键盘 `↓` 键查看下一张图片
   - 点击界面上的上下箭头按钮
4. 点击"更换文件夹"可以重新选择其他文件夹

## 技术栈

- Swift 5.0+
- SwiftUI
- macOS 13.0+

## 项目结构

```
image_view/
├── ImageViewer.xcodeproj/       # Xcode项目文件
├── ImageViewer/                 # 应用源代码
│   ├── ImageViewerApp.swift     # 主应用入口
│   ├── ContentView.swift       # 主视图界面
│   ├── ImageViewModel.swift    # 图片加载和切换逻辑
│   ├── Assets.xcassets/         # 应用资源
│   └── ImageViewer.entitlements # 应用权限配置
├── README.md                    # 使用说明
└── .gitignore                   # Git忽略文件
```
