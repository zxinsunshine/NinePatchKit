
Pod::Spec.new do |s|

    s.name             = "NinePatchKit"
    s.version          = "1.0"
    s.summary          = "NinePatch image render framework"
    s.author           = { "Theo" => "zxinsunshine@126.com" }

    s.homepage         = "https://github.com/zxinsunshine/NinePatchKit"
    s.license          = 'MIT'
    
    s.source = {
        :git => 'https://github.com/zxinsunshine/NinePatchKit.git',
        :tag => s.version.to_s,
        :branch => 'master'
    }

    s.source_files = "NinePatchUtils/*.{h,m,mm,swift}", "NinePatchUtils/**/*.{h,m,mm,swift}"
    s.public_header_files = "NinePatchUtils/*.h"

    s.ios.deployment_target = '9.0'
    s.osx.deployment_target = '10.11'
    s.ios.frameworks = 'UIKit'
    s.osx.frameworks = 'Cocoa'
    
end
    
