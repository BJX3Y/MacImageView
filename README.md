# 图片工具

一个功能丰富的macOS图片工具应用，包含图片查看器和图片下载器等多个功能模块。

## 功能特性

### 图片查看器
- 选择文件夹加载所有支持的图片格式
- 使用键盘上下方向键切换图片
- 使用界面按钮切换图片
- 自动适应窗口大小显示图片
- 记住上次选择的文件夹

### 图片下载器（开发中）
- 即将推出

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

### 图片查看器

1. 在侧边栏选择"图片查看器"
2. 点击"选择文件夹"按钮
3. 选择包含图片的文件夹
4. 使用以下方式切换图片：
   - 按键盘 `↑` 键查看上一张图片
   - 按键盘 `↓` 键查看下一张图片
   - 点击界面上的上下箭头按钮
5. 点击"更换文件夹"可以重新选择其他文件夹

### 侧边栏导航

应用使用侧边栏导航来切换不同的功能模块：
- **图片查看器** - 查看本地文件夹中的图片
- **图片下载器** - 下载网络图片（开发中）

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
│   ├── ContentView.swift       # 主视图（管理侧边栏和内容区域）
│   ├── AppFeature.swift        # 功能模块枚举
│   ├── SidebarView.swift       # 侧边栏导航视图
│   ├── ImageViewerView.swift   # 图片查看器视图
│   ├── ImageDownloaderView.swift # 图片下载器视图
│   ├── ImageViewModel.swift    # 图片查看器视图模型
│   ├── Assets.xcassets/         # 应用资源
│   └── ImageViewer.entitlements # 应用权限配置
├── README.md                    # 使用说明
└── .gitignore                   # Git忽略文件
```

## 开发计划

- [x] 实现图片查看器功能
- [ ] 实现图片下载器功能
- [ ] 添加图片编辑功能
- [ ] 支持更多图片格式
- [ ] 添加图片收藏功能
- [ ] 支持图片导出和分享
