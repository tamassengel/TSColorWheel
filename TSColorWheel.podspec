Pod::Spec.new do |s|
  s.name             = 'TSColorWheel'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TSColorWheel.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Tamás Sengel/TSColorWheel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tamás Sengel' => 'tamas.sengel@toptal.com' }
  s.source           = { :git => 'https://github.com/Tamás Sengel/TSColorWheel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'

  s.source_files = 'TSColorWheel/Classes/**/*'
  s.resources = 'TSColorWheel/Assets/**'
end
