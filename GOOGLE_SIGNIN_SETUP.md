# Google Sign-In 配置指南

本文档说明如何为图片工具应用配置 Google Sign-In SDK。

## 前置要求

1. **Google Cloud 账号**
   - 访问 [Google Cloud Console](https://console.cloud.google.com/)
   - 创建一个新项目或选择现有项目

2. **Xcode 项目**
   - 确保已安装 Xcode 14.0 或更高版本
   - macOS 13.0 或更高版本

## 配置步骤

### 1. 在 Google Cloud Console 中创建 OAuth 2.0 凭据

1. 访问 [Google Cloud Console](https://console.cloud.google.com/)
2. 选择或创建一个项目
3. 进入 **API 和服务 > 凭据**
4. 点击 **创建凭据** > **OAuth 客户端 ID**
5. 选择应用类型：
   - 选择 **macOS 应用**
   - 输入应用名称（例如：ImageViewer）
   - 输入 Bundle ID：`com.example.ImageViewer`
6. 点击 **创建**
7. 复制生成的 **客户端 ID**（格式：`XXXXXXXXXX.apps.googleusercontent.com`）

### 2. 配置应用

1. 打开项目中的 `ImageViewer/GoogleService-Info.plist` 文件
2. 将以下占位符替换为你的实际值：

```xml
<key>CLIENT_ID</key>
<string>YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com</string>

<key>REVERSED_CLIENT_ID</key>
<string>com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID</string>

<key>API_KEY</key>
<string>YOUR_API_KEY</string>

<key>GCM_SENDER_ID</key>
<string>YOUR_GCM_SENDER_ID</string>

<key>PROJECT_ID</key>
<string>YOUR_PROJECT_ID</string>

<key>STORAGE_BUCKET</key>
<string>YOUR_STORAGE_BUCKET</string>

<key>GOOGLE_APP_ID</key>
<string>1:YOUR_PROJECT_ID:ios:YOUR_APP_ID</string>

<key>BUNDLE_ID</key>
<string>com.example.ImageViewer</string>
```

3. 保存文件

### 3. 安装依赖

#### 使用 Swift Package Manager

项目已配置 Swift Package Manager，但需要手动安装 Google Sign-In SDK：

1. 在 Xcode 中，选择 **File > Add Package Dependencies**
2. 输入包 URL：`https://github.com/google/GoogleSignIn-iOS.git`
3. 选择版本：`7.0.0` 或更高版本
4. 点击 **Add Package**

#### 使用 CocoaPods（可选）

如果使用 CocoaPods：

1. 在项目根目录运行：
```bash
pod install
```

2. 打开生成的 `.xcworkspace` 文件

### 4. 配置 URL Scheme

1. 在 Xcode 中选择项目
2. 选择 **Info** 标签
3. 在 **URL Types** 部分添加：
   - **Identifier**: `com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID`
   - **Role**: Editor
   - **URL Schemes**: 添加你的反向客户端 ID

### 5. 测试登录

1. 在 Xcode 中构建并运行应用
2. 点击侧边栏底部的"使用 Google 登录"按钮
3. 应该会弹出 Google 登录窗口
4. 完成登录后，侧边栏应显示你的 Google 账户信息

## 常见问题

### Q: 登录窗口没有弹出？
A: 检查以下几点：
- 确保 `CLIENT_ID` 在 `GoogleService-Info.plist` 中正确配置
- 确保应用的 Bundle ID 与 Google Cloud Console 中配置的一致
- 检查 Xcode 控制台是否有错误信息

### Q: 登录后没有显示用户信息？
A: 
- 检查网络连接
- 查看控制台日志，确认登录是否成功
- 确保应用有访问网络的权限

### Q: 如何获取反向客户端 ID？
A:
- 反向客户端 ID 会在创建 OAuth 客户端 ID 时自动生成
- 格式为：`com.googleusercontent.apps.XXXXXXXXXXXXXX`
- 可以在 Google Cloud Console 的凭据页面找到

## 安全注意事项

1. **不要将凭据提交到版本控制**
   - `GoogleService-Info.plist` 包含敏感信息
   - 将其添加到 `.gitignore`
   - 为每个开发者使用不同的凭据

2. **使用生产环境凭据**
   - 开发和测试使用不同的 OAuth 客户端 ID
   - 发布时使用生产环境的凭据

3. **限制应用范围**
   - 只请求必要的权限
   - 在 Google Cloud Console 中配置正确的 OAuth 范围

## 相关资源

- [Google Sign-In for iOS and macOS 文档](https://developers.google.com/identity/sign-in/ios/)
- [Google Cloud Console](https://console.cloud.google.com/)
- [Google Sign-In GitHub 仓库](https://github.com/google/GoogleSignIn-iOS)
