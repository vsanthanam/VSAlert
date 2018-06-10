Pod::Spec.new do |s|
#1.
s.name               = "VSAlert"
#2.
s.version            = "1.2.3"
#3.
s.summary         = "Drop-in replacement for UIAlertController"
#4.
s.homepage        = "https://vsalert.vsanthanam.com"
#5.
s.license              = "MIT"
#6.
s.author               = "vsanthanam"
#7.
s.platform            = :ios, "10.0"
#8.
s.source              = { :git => "https://github.com/vsanthanam/VSAlert.git", :tag => "1.2.3" }
#9.
s.source_files     = "VSAlert", "VSAlert/**/*.{h,m}"
end
