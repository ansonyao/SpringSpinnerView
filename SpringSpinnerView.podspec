Pod::Spec.new do |s|
  s.name             = 'SpringSpinnerView'
  s.version          = '1.0.0'
  s.summary          = 'A spinner view which mimics the animation of the spinner view used in google maps.'

  s.description      = <<-DESC
  A spinner view which mimics the animation of the spinner view used in google maps. TLDR                    
  DESC

  s.homepage         = 'https://github.com/ansonyao/SpringSpinnerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'Anson Yao' => 'yaoenxin@gmail.com'  }
  s.source           = { :git => 'https://github.com/ansonyao/SpringSpinnerView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/**/*'
  
end
