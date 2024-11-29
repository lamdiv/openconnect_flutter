
Pod::Spec.new do |s|
  s.name             = 'openconnect_flutter'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://naviddev.info'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Navid Shokoufeh' => 'navidshokoufeh.dev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.preserve_path = ['ext/ExtParser.framework','openconnect/openconnect.framework' ]
  s.vendored_frameworks  = ['ext/ExtParser.framework','openconnect/openconnect.framework' ]

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386','OTHER_LDFLAGS' => ['-framework ExtParser','-framework openconnect']}
end
