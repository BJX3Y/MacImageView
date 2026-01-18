# Xcode 项目重组指南

## 问题说明

由于手动编辑 Xcode 的 `project.pbxproj` 文件极其困难且容易出错，我们采用以下步骤来重组项目结构。

## 当前状态

- ✅ 源代码文件已按新结构组织完成
- ✅ 项目文件已从 git 历史恢复到可用状态
- ⚠️  项目文件中的文件引用需要更新以匹配新结构

## 推荐操作步骤

### 方法 1：使用 Xcode GUI（推荐）

1. **在 Xcode 中打开项目**
   ```bash
   open ImageViewer.xcodeproj
   ```

2. **删除旧的文件引用**
   - 在 Xcode 项目导航器中，右键点击 `ImageViewer` 文件夹
   - 选择 "Delete" → "Remove Reference"
   - 重复此操作删除所有旧的文件引用

3. **添加新的文件结构**
   - 右键点击项目根节点
   - 选择 "Add Files to 'ImageViewer'..."
   - 选择 `ImageViewer` 文件夹
   - 确保勾选 "Create groups" 和 "Create folder references"
   - 点击 "Add"

4. **验证文件结构**
   - 确认项目导航器显示以下结构：
     ```
     ImageViewer
     ├── App
     ├── Features
     │   ├── Authentication
     │   ├── ImageDownloader
     │   └── ImageViewer
     ├── Shared
     └── Supporting Files
     ```

5. **清理构建**
   - Product → Clean Build Folder (Shift + Command + K)
   - Product → Build (Command + B)

### 方法 2：使用 Xcode 命令行工具

如果需要自动化，可以考虑使用以下工具：

1. **xcodeproj** - Ruby 库，用于修改 Xcode 项目文件
   ```bash
   gem install xcodeproj
   ```

2. **XcodeGen** - 更现代的项目生成工具
   ```bash
   brew install xcodegen
   ```

## 注意事项

- ⚠️ 不要手动编辑 `project.pbxproj` 文件
- ⚠️ 每次修改项目结构后，先清理构建再重新编译
- ⚠️ 确保所有文件的 Target Membership 正确设置

## 当前项目结构

```
image_view/
├── ImageViewer/                    # 源代码（已重组）
│   ├── App/                        # 应用入口
│   ├── Features/                   # 功能模块
│   ├── Shared/                     # 共享组件
│   └── Supporting Files/           # 支持文件
│
├── ImageViewer.xcodeproj/          # Xcode 项目（需要更新引用）
├── .gitignore
├── GOOGLE_SIGNIN_SETUP.md
├── LICENSE
├── PROJECT_STRUCTURE.md
└── README.md
```

## 下一步

1. 在 Xcode 中打开项目
2. 按照方法 1 的步骤重新组织文件
3. 测试编译是否成功
