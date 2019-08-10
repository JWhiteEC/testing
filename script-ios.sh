brew install node@10
brew link node@10
node --version
npm install -g phonegap@8.2.2
npm install -g ios-sim
phonegap create appsrc --template hello-world
cd appsrc
echo Install iOS platform
phonegap platform add ios@latest
echo Build iOS
phonegap build ios
echo Artifacts
find . -name "*.app"
find . -name "*.ipa"
echo Run iOS
cordova run ios --list
phonegap run ios --target="iPhone-XR, 13.0"

