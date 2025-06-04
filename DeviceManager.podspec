Pod::Spec.new do |s|
  s.name             = 'DeviceManager'
  s.version          = '1.0.0'
  s.summary          = 'Binary-only XCFramework for device info.'
  s.description      = <<-DESC
    A binary-only precompiled framework for retrieving iOS device information.
  DESC
  s.homepage         = 'https://github.com/kandaofu/DeviceManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kandaofu' => '' }
  s.platform         = :ios, '13.0'

  s.source = {
    :http => 'https://github.com/kandaofu/DeviceManager/releases/download/1.0.0/DeviceManager.xcframework.zip'
  }

  s.vendored_frameworks = 'DeviceManager.xcframework'
  s.preserve_paths = 'DeviceManager.xcframework'
end