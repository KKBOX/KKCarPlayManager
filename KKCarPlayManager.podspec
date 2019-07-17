Pod::Spec.new do |s|
  s.name             = 'KKCarPlayManager'
  s.version          = '0.1.2'
  s.summary          = 'Helps to implement an CarPlay audio app.'
  s.description      = <<-DESC
KKCarPlayManager helps you to build the tree of the content items to let users to browsw on a CarPlay audio app.
                       DESC

  s.homepage         = 'https://github.com/KKBOX/KKCarPlayManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zonble' => 'zonble@gmail.com' }
  s.source           = { :git => 'https://github.com/KKBOX/KKCarPlayManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_versions = ['4.2', '5.0', '5.1']

  s.subspec 'KKCarPlayManager' do |sp|
    sp.source_files = 'Sources/KKCarPlayManager/**/*'
  end

  s.subspec 'KKCarPlayManagerExtensions' do |sp|
    sp.source_files = 'Sources/KKCarPlayManagerExtensions/**/*'
    sp.dependency 'KKCarPlayManager/KKCarPlayManager'
  end

  s.frameworks = 'MediaPlayer'
  s.default_subspec = 'KKCarPlayManager'

end
