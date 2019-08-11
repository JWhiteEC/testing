brew install node@10
brew link node@10
node --version
npm install -g phonegap@8.2.2
npm install -g ios-sim
npm install -g appium
npm install -g appium-doctor
brew install carthage
phonegap create appsrc --template hello-world

pushd appsrc
echo Install iOS platform
phonegap platform add ios@latest
echo Build iOS
phonegap build ios
echo Appium check
pwd
popd
pwd

appium-doctor --ios
echo Running Appium server
appium &
sleep 5
echo Running Tests
npm install yiewd
node test-ios.js
