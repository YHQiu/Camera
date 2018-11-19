# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'Camera' do
    
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for Camera Project
  pod 'AFNetworking'
  pod 'FMDB'
  pod 'SVProgressHUD'
  pod 'GPUImage'
  pod 'FFmpeg'
  pod 'YYKit'
  pod 'Masonry'
  
  # Pods PrivatePods for Camera
  pod 'HYConfig'    ,:path=> './PrivatePods/HYConfig'
  pod 'HYRoute'     ,:path=> './PrivatePods/HYRoute'
  pod 'HYCore'   ,:path=> './PrivatePods/HYCore'
  pod 'HYCategory'   ,:path=> './PrivatePods/HYCategory'
  pod 'HYWebModule'   ,:path=> './PrivatePods/HYWebModule'
  pod 'HYThirdPartyLibrary'   ,:path=> './PrivatePods/HYThirdPartyLibrary'
  pod 'HYRNModule'   ,:path=> './PrivatePods/HYRNModule'
  pod 'HYDB'   ,:path=> './PrivatePods/HYDB'
  pod 'HYAccount'   ,:path=> './PrivatePods/HYAccount'
  pod 'HYScanter'   ,:path=> './PrivatePods/HYScanter'
  
end

# 解决App Icon显示不了的问题
post_install do |installer|
    copy_pods_resources_path = "Pods/Target Support Files/Pods-Camera/Pods-Camera-resources.sh"
    string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
    assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
    text = File.read(copy_pods_resources_path)
    new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
    File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }
end
