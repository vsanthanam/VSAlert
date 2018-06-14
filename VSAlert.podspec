#
# Be sure to run `pod lib lint VSAlert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VSAlert'
  s.version          = '1.3.3'
  s.summary          = "An drop-in replacement for UIAlertController with more power and better looks."
  s.description      = "An drop-in replacement for UIAlertController that looks a hell of a lot better, built in Objective-C. Based on Codedio's aweomse Swift library, PMAlertController."
  s.homepage         = 'https://vsalert.vsanthanam.com'
  s.license          = { :type => 'Copyright', :text => 'MIT' }
  s.author           = { 'Varun Santhanam' => 'talkto@vsanthanam.com' }
  s.source           = { :git => 'https://github.com/vsanthanam/VSAlert.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'VSAlert/*.{h,m}'
  s.public_header_files = 'VSAlert/*.h'
  s.module_map = 'VSAlert/Supporting/module.modulemap'
  s.documentation_url = 'https://code.vsanthanam.com/VSAlert/Documentation/index.html'
  s.static_framework = true
end
