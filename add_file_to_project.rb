require 'xcodeproj'

# 打开 Xcode 项目
project_path = 'ImageViewer.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# 找到目标目标
app_target = project.targets.find { |target| target.name == 'ImageViewer' }

# 找到 ImageViewer 组
features_group = project.main_group.find_subpath('ImageViewer/Features', true)
image_viewer_group = features_group.find_subpath('ImageViewer', true)

# 创建新文件引用
file_path = 'ImageViewer/Features/ImageViewer/FullScreenImageView.swift'
file_reference = image_viewer_group.new_file(file_path)

# 将文件添加到目标的编译列表中
app_target.add_file_references([file_reference])

# 保存项目
project.save

puts "Added #{file_path} to #{project_path}"
