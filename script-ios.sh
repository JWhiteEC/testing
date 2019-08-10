brew install node@10
brew link node@10
node --version
npm install -g phonegap@8.2.2
npm install -g ios-sim
phonegap create appsrc --template hello-world
cd appsrc
phonegap run ios
