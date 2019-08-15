npm install -g cordova@latest
npm install -g ios-sim
npm install -g appium
npm install -g appium-doctor
npm install -g request
brew install carthage

pushd appsrc
npm install xcode
echo Install iOS platform
cordova platform add ios@latest
echo Build iOS Emulator
cordova build ios --emulator
echo Build iOS Device
cordova build ios --device
popd

zip -r appsrc.zip /Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios/build/emulator
curl https://www.ec-gaming.net/beta/node/upload/appsrc.zip --data-binary @appsrc.zip

appium-doctor --ios
echo Running Appium server
appium &
sleep 5
echo Running Tests
npm install yiewd
node test-ios.js

