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
│   │   ├── AppleSignInManager.swift      # Apple 登录管理器
│   │   ├── WeChatSignInManager.swift    # 微信登录管理器
│   │   ├── UserSession.swift               # 用户会话管理
│   │   ├── AppleSignInButton.swift        # Apple 登录按钮
│   │   └── WeChatSignInButton.swift       # 微信登录按钮
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
    └── ImageViewer.entitlements   # 应用权限配置
```

## 模块说明

### App
- **ImageViewerApp.swift**: 应用程序入口，配置应用生命周期
- **ContentView.swift**: 主内容视图，管理侧边栏和功能视图的切换

### Features
功能模块按功能划分，每个功能独立管理：

#### Authentication
- **AppleSignInManager**: 管理 Apple OAuth 认证流程，使用 AuthenticationServices 框架
- **WeChatSignInManager**: 管理微信登录流程（待集成微信 SDK）
- **UserSession**: 用户会话状态管理，使用 Combine 进行响应式更新，支持多种登录方式
- **AppleSignInButton**: 自定义 Apple 登录按钮组件
- **WeChatSignInButton**: 自定义微信登录按钮组件

#### ImageDownloader
- **ImageDownloaderView**: 图片下载功能的主视图（待实现）

#### ImageViewer
- **ImageViewerView**: 图片查看器的主视图
- **ImageViewModel**: 图片查看器的视图模型，管理图片加载和切换逻辑

### Shared
- **AppFeature**: 定义应用的所有功能模块，用于侧边栏导航
- **SidebarView**: 侧边栏视图，显示功能列表和用户登录状态，支持登录弹窗

### Supporting Files
- **Assets.xcassets**: 应用资源文件，包括应用图标等
- **ImageViewer.entitlements**: 应用权限配置文件

## 架构特点

1. **模块化设计**: 每个功能独立成模块，便于维护和扩展
2. **MVVM 架构**: 使用视图模型分离业务逻辑和 UI
3. **响应式编程**: 使用 Combine 框架进行状态管理
4. **清晰分层**: App、Features、Shared 分层明确，职责清晰
5. **可扩展性**: 新增功能只需在 Features 目录下创建新模块
6. **多登录支持**: 支持多种登录方式，易于扩展新的登录方式

## 开发指南

### 添加新功能
1. 在 `Features/` 目录下创建新功能文件夹
2. 创建视图和视图模型文件
3. 在 `Shared/AppFeature.swift` 中添加功能定义
4. 在 `Shared/SidebarView.swift` 中添加导航项

### 添加新的登录方式
1. 在 `Features/Authentication/` 目录下创建新的登录管理器
2. 在 `UserSession.swift` 中添加对新登录方式的支持
3. 创建对应的登录按钮组件
4. 在 `SidebarView.swift` 中添加登录按钮

### 修改现有功能
- 每个功能模块独立，修改时只需关注对应目录
- 共享组件在 `Shared/` 目录中，修改会影响多个功能

### 依赖管理
- Apple Sign-In 使用系统自带的 AuthenticationServices 框架
- 微信登录需要集成微信 SDK（待实现）
- 其他第三方库建议使用 Swift Package Manager

## 认证流程

### Apple Sign-In 流程
1. 用户点击"使用 Apple 登录"按钮
2. `AppleSignInManager` 创建 ASAuthorizationAppleIDProvider 请求
3. 弹出系统登录窗口
4. 用户完成认证
5. `AppleSignInManager` 接收回调并更新用户信息
6. `UserSession` 监听登录状态变化并更新 UI

### 微信登录流程（待实现）
1. 用户点击"使用微信登录"按钮
2. `WeChatSignInManager` 调用微信 SDK
3. 弹出微信登录窗口
4. 用户完成认证
5. `WeChatSignInManager` 接收回调并更新用户信息
6. `UserSession` 监听登录状态变化并更新 UI

## 状态管理

应用使用 Combine 框架进行响应式状态管理：

- **UserSession**: 使用 `@Published` 属性发布登录状态变化
- **SidebarView**: 订阅 `UserSession` 的状态变化，自动更新 UI
- **各功能模块**: 可以订阅 `UserSession` 获取登录状态

## 下一步计划

- [ ] 集成微信 SDK 实现完整的微信登录
- [ ] 实现图片下载器功能
- [ ] 添加用户设置功能
- [ ] 实现图片收藏和分享功能
