node --version
brew install node@10
brew link node@10
node --version
npm install -g phonegap@8.2.2
npm install -g ios-sim
npm install -g appium
npm install -g appium-doctor
npm install -g request
brew install carthage

#phonegap create helloworldapp --template hello-world
#zip -r helloworldapp.zip /Users/travis/build/JWhiteEC/testing/helloworldapp
#curl https://www.ec-gaming.net/beta/node/upload/helloworldapp.zip --data-binary @helloworldapp.zip


pushd appsrc
npm install xcode
echo Install iOS platform
phonegap platform add ios
phonegap plugin add cordova-plugin-iosrtc-simplyrtc
phonegap platform remove ios
phonegap platform add ios

echo Build iOS Emulator
phonegap build ios --emulator
echo Appium check
pwd
popd
pwd


zip -r appsrc.zip /Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios/build/emulator
curl https://www.ec-gaming.net/beta/node/upload/appsrc.zip --data-binary @appsrc.zip

pushd appsrc
echo Build iOS Device
phonegap build ios --device
popd

zip -r appbuild.zip /Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios
curl https://www.ec-gaming.net/beta/node/upload/appbuild.zip --data-binary @appbuild.zip


appium-doctor --ios
echo Running Appium server
appium &
sleep 5
echo Running Tests
npm install yiewd
node test-ios.js

