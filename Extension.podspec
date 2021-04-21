Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "Extension"
  s.version      = "0.1.5"
  s.summary      = "方法扩展"
  
  s.description  = "方法扩展"

  s.homepage     = "https://pplan.top"

  # ―――  swift  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.swift_version = '5.0'

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "lihong.zhu" => "lihong.zhu@foxmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "11.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#  s.source       = { :git => "", :tag => "0.0.1" }
  s.source       = { :git => 'https://github.com/zhulihong89/Extension.git' }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = 'Extension/*.swift', 'Extension/Foundation/*.swift', 'Extension/Kit/*.swift','Extension/Kit/*.xib', 'Extension/Foundation/*.h', 'Extension/Foundation/*.m'
  s.exclude_files = "Extension/Exclude"

end
