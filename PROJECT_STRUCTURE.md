# ImageViewer 项目结构

## 目录组织

```
ImageViewer/
├── App/                           # 应用入口和主视图
│   ├── ImageViewerApp.swift       # 应用程序入口
│   └── ContentView.swift          # 主内容视图
│
├── Features/                      # 功能模块
│   ├── Authentication/            # 认证功能
│   │   ├── GoogleSignInManager.swift      # Google 登录管理器
│   │   ├── UserSession.swift                # 用户会话管理
│   │   ├── SignInSheetView.swift           # 登录弹窗视图
│   │   ├── SignInViewController.swift      # 登录视图控制器
│   │   └── GoogleSignInButton.swift        # Google 登录按钮
│   │
│   ├── ImageDownloader/           # 图片下载功能
│   │   └── ImageDownloaderView.swift      # 图片下载视图
│   │
│   └── ImageViewer/               # 图片查看功能
│       ├── ImageViewerView.swift           # 图片查看视图
│       └── ImageViewModel.swift            # 图片查看视图模型
│
├── Shared/                        # 共享组件
│   ├── AppFeature.swift           # 应用功能定义
│   └── SidebarView.swift          # 侧边栏视图
│
└── Supporting Files/              # 支持文件
    ├── Assets.xcassets/           # 资源文件
    │   ├── AppIcon.appiconset/
    │   └── Contents.json
    ├── ImageViewer.entitlements   # 应用权限配置
    └── GoogleService-Info.plist   # Google Sign-In 配置
```

## 模块说明

### App
- **ImageViewerApp.swift**: 应用程序入口，配置应用生命周期
- **ContentView.swift**: 主内容视图，管理侧边栏和功能视图的切换

### Features
功能模块按功能划分，每个功能独立管理：

#### Authentication
- **GoogleSignInManager**: 管理 Google OAuth 认证流程
- **UserSession**: 用户会话状态管理，使用 Combine 进行响应式更新
- **SignInSheetView**: 登录弹窗的 SwiftUI 视图
- **SignInViewController**: 登录弹窗的 AppKit 视图控制器
- **GoogleSignInButton**: 自定义 Google 登录按钮组件

#### ImageDownloader
- **ImageDownloaderView**: 图片下载功能的主视图（待实现）

#### ImageViewer
- **ImageViewerView**: 图片查看器的主视图
- **ImageViewModel**: 图片查看器的视图模型，管理图片加载和切换逻辑

### Shared
- **AppFeature**: 定义应用的所有功能模块，用于侧边栏导航
- **SidebarView**: 侧边栏视图，显示功能列表和用户登录状态

### Supporting Files
- **Assets.xcassets**: 应用资源文件，包括应用图标等
- **ImageViewer.entitlements**: 应用权限配置文件
- **GoogleService-Info.plist**: Google Sign-In SDK 配置文件（已加入 .gitignore）

## 架构特点

1. **模块化设计**: 每个功能独立成模块，便于维护和扩展
2. **MVVM 架构**: 使用视图模型分离业务逻辑和 UI
3. **响应式编程**: 使用 Combine 框架进行状态管理
4. **清晰分层**: App、Features、Shared 分层明确，职责清晰
5. **可扩展性**: 新增功能只需在 Features 目录下创建新模块

## 开发指南

### 添加新功能
1. 在 `Features/` 目录下创建新功能文件夹
2. 创建视图和视图模型文件
3. 在 `Shared/AppFeature.swift` 中添加功能定义
4. 在 `Shared/SidebarView.swift` 中添加导航项

### 修改现有功能
- 每个功能模块独立，修改时只需关注对应目录
- 共享组件在 `Shared/` 目录中，修改会影响多个功能

### 依赖管理
- Google Sign-In SDK 需要通过 Xcode Package Manager 添加
- 其他第三方库建议使用 Swift Package Manager
