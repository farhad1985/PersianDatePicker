Pod::Spec.new do |s|
  s.name             = 'PersianDatePicker'
  s.version          = '1.1.0'
  s.summary          = 'PersianDatePicker is a PickerView. by : farhad faramarzi'


  s.homepage         = 'https://github.com/farhad1985/PersianDatePicker'
  s.author           = { 'Farhad Faramarzi' => 'farhad.public@gmail.com' }
  s.license          = { :type => 'GPL2', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/farhad1985/PersianDatePicker.git', :tag => s.version.to_s }

  s.platform = :ios, "11.0"
  s.source_files = 'PersianDatePicker/*'
  s.exclude_files = "PersianDatePicker/**/*.plist"
  s.swift_version = '5'

end
