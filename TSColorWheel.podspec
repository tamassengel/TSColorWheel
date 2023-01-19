Pod::Spec.new do |s|
  s.name = 'TSColorWheel'
  s.version = '2.0.3'
  s.summary = 'A color wheel for watchOS based on Colorful'
  s.homepage = 'https://github.com/tamassengel/TSColorWheel'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Tamás Sengel' => 'info@tamassengel.com' }
  s.source  = { :git => 'https://github.com/tamassengel/TSColorWheel.git', :tag => s.version.to_s }
  s.watchos.deployment_target = '6.2.1'
  s.source_files = 'TSColorWheel/Classes/**/*'
  s.resources = 'TSColorWheel/Assets/**'
  s.swift_version = '5.3'
  s.deprecated_in_favor_of = "QudiaColorWheel"
end
