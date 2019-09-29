npm install -g cordova@latest
npm install -g ios-sim
npm install -g request
npm install -g glob

pushd appsrc

mkdir www plugins platforms hooks
npm install xcode
echo Install iOS platform
cordova platform add ios@latest
#echo Build iOS Emulator
#cordova build ios --emulator --verbose --buildFlag='BUILD_ACTIVE_RESOURCES_ONLY=NO' --buildFlag='ENABLE_ONLY_ACTIVE_RESOURCES=NO'
echo Build iOS Device
node ../add-xctest.js platforms/ios/*.xcodeproj/project.pbxproj platforms/ios/*.xcworkspace/xcshareddata/xcschemes/*.xcscheme
cp -R ../uitestingUITests platforms/ios
pushd platforms/ios
zip -r appxcsrc.zip .
ls -l appxcsrc.zip
curl https://www.ec-gaming.net/beta/node/upload/appxcsrc.zip --data-binary @appxcsrc.zip
xcodebuild -verbose -UseModernBuildSystem=0 -xcconfig `pwd`/cordova/build-debug.xcconfig -workspace *.xcworkspace -scheme "helloworld" -configuration Debug -destination generic/platform=iOS build-for-testing SHARED_PRECOMPS_DIR=`pwd`/build/sharedpch ENABLE_BITCODE="NO" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED="NO" CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO" SWIFT_COMPILATION_MODE="wholemodule" -derivedDataPath derived 
pushd derived/Build/Products
zip -r appxctest.zip Debug* Release* *.xctestrun 
ls -l appxctest.zip
curl https://www.ec-gaming.net/beta/node/upload/appxctest.zip --data-binary @appxctest.zip
popd
popd
popd



zip -r appsrcemu.zip /Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios/build/emulator /Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios/build/emulator/helloworld.app.dSYM
curl https://www.ec-gaming.net/beta/node/upload/appsrcemu.zip --data-binary @appsrcemu.zip

ls -l appsrc*.zip

#npm install -g appium
#npm install -g appium-doctor
#brew install carthage
#appium-doctor --ios
#echo Running Appium server
#appium &
#sleep 5
#echo Running Tests
#npm install yiewd
#node test-ios.js

