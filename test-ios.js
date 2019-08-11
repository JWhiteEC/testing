console.log('Run ios-test');

var yiewd = require("yiewd");

var appDriver = yiewd.remote({hostname: '127.0.0.1',port: 4723});
var config = {};
  
config.ios12 = {
    'automationName': 'XCUITest',
    'app': '/Users/travis/build/JWhiteEC/testing/appsrc/platforms/ios/build/emulator/helloworld.app',
    'platformVersion': '12.1',
    'platformName': 'iOS',
    'deviceName': 'iPhone X',
    'platformName': 'iOS',
    'name' : 'iOS Test',
    'autoWebview': true,
};

config.android19Hybrid = {
  automationName: 'Appium',
  browserName: '',
  platformName: 'Android',
  platformVersion: 19,    // API level integer, or a version string like '4.4.2'
  autoWebview: true,
  deviceName: '...',
  app: "...",
};

console.log('Running!');
appDriver.run(function* () {  // 'this' is appDriver
  var session = yield this.init(config.ios12);
  var scr=null;
  console.log('Inited!');
  yield this.sleep(3000);
  scr=yield this.takeScreenshot();
  console.log('Screenshot',scr);
  yield this.sleep(3000);
  scr=yield this.takeScreenshot();
  console.log('Screenshot',scr);
  yield this.sleep(3000);
  scr=yield this.takeScreenshot();
  console.log('Screenshot',scr);
  console.log('Quitting!');
  this.quit();
});

console.log('Reached EOF');

