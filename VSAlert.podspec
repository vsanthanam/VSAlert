#
# Be sure to run `pod lib lint VSAlert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VSAlert'
  s.version          = '1.2.4'
  s.summary          = "An drop-in replacement for UIAlertController with more power and better looks."
  s.description      = "An drop-in replacement for UIAlertController that looks a hell of a lot better, built in Objective-C. Based on Codedio's aweomse Swift library, PMAlertController."
  s.homepage         = 'https://github.com/vsanthanam/VSAlert'
  s.license          = { :type => 'Copyright', :text => 'MIT' }
  s.author           = { 'Varun Santhanam' => 'talkto@vsanthanam.com' }
  s.source           = { :git => 'https://github.com/vsanthanam/VSAlert.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'VSAlert/Src/*.{h,m}'
  s.public_header_files = 'VSAlert/Src/*.h'
  s.module_map = 'VSAlert/Supporting/module.modulemap'
end
