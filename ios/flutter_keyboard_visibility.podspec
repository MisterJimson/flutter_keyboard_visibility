#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_keyboard_visibility'
  s.version          = '0.7.0'
  s.summary          = 'Flutter keyboard visibility.'
  s.description      = <<-DESC
Flutter keyboard visibility project.
                       DESC
  s.homepage         = 'https://github.com/MisterJimson/flutter_keyboard_visibility'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Jason Rai' => 'jason.c.rai@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end
