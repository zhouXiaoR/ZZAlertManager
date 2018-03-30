Pod::Spec.new do |s|
  s.name             = 'ZZAlertManager'
  s.version          = '0.1.0'
  s.summary          = 'ZZAlertManager'

  s.description      = <<-DESC
弹框管理，还你清新屏幕
                       DESC

  s.homepage         = 'https://github.com/zhouXiaoR/ZZAlertManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhouXiaoR' => 'zhouxiaorui@duiba.com.cn' }
  s.source           = { :git => 'https://github.com/zhouXiaoR/ZZAlertManager', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'ZZAlertViewManager/**/*'
  
end
