#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'keyboard_visibility'
  s.version          = '0.5.0'
  s.summary          = 'Flutter keyboard visibility project.'
  s.description      = <<-DESC
Flutter keyboard visibility project.
                       DESC
  s.homepage         = 'http://github.com/adee42/keyboard_visibility'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Reachability'

  s.ios.deployment_target = '8.0'
end
