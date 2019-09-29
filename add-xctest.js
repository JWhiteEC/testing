fs=require('fs')

function addtests(infile,outfile,inscheme,outscheme){
	console.log('Read from ',infile,inscheme);
	var sch=fs.readFileSync(inscheme)+'';
	var pbx=fs.readFileSync(infile)+'';
	var ROOT_ID,TARGET_ID;
	ROOT_ID = pbx.match(/rootObject = ([0-9A-F]*)/)[1];
	TARGET_ID = pbx.match(/targets = \([ \t\r\n]*([0-9A-F]*)/)[1];
	PRODUCT_REF = pbx.match(/productReference = [ \t\r\n]*([0-9A-F]*)/)[1];
	PRODUCT_NAME = pbx.match(/productName = ([^;]*)/)[1];
	DEBUG_BASE = pbx.match(/baseConfigurationReference = ([0-9A-F]*)/)[1];
	if (PRODUCT_NAME.startsWith('"'))
		PRODUCT_NAME=PRODUCT_NAME.substr(1,PRODUCT_NAME.length-2);
	REMOTE_INFO = 'uitesting';	

	console.log('Root',ROOT_ID,'Target',TARGET_ID,'Product',PRODUCT_REF,'Name',PRODUCT_NAME,'Debug',DEBUG_BASE);
	var BUILD = `
                        buildSettings = {
                                PRODUCT_NAME = "$(TARGET_NAME)";
                                INFOPLIST_FILE = uitestingUITests/Info.plist;
                                PRODUCT_BUNDLE_IDENTIFIER = io.cordova.uitestingUITests;
                                TEST_TARGET_NAME = ${PRODUCT_NAME};
                        };
`;
	var objects = `
                CE9F4EC2233C56BF00268AAD /* uitestingUITests.m in Sources */ = {isa = PBXBuildFile; fileRef = CE9F4EC1233C56BF00268AAD /* uitestingUITests.m */; };
                CE9F4EC4233C56BF00268AAD /* PBXContainerItemProxy */ = {
                        isa = PBXContainerItemProxy;
                        containerPortal = ${ROOT_ID} /* Project object */;
                        proxyType = 1;
                        remoteGlobalIDString = ${TARGET_ID};
                        remoteInfo = ${REMOTE_INFO};
                };
                CE9F4EBF233C56BF00268AAD /* uitestingUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = uitestingUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
                CE9F4EC1233C56BF00268AAD /* uitestingUITests.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = uitestingUITests.m; sourceTree = "<group>"; };
                CE9F4EC3233C56BF00268AAD /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                CE9F4EBC233C56BF00268AAD /* Frameworks */ = {
                        isa = PBXFrameworksBuildPhase;
                        buildActionMask = 2147483647;
                        files = (
                        );
                        runOnlyForDeploymentPostprocessing = 0;
                };
                CE9F4EC0233C56BF00268AAD /* uitestingUITests */ = {
                        isa = PBXGroup;
                        children = (
                                CE9F4EC1233C56BF00268AAD /* uitestingUITests.m */,
                                CE9F4EC3233C56BF00268AAD /* Info.plist */,
                        );
                        path = uitestingUITests;
                        sourceTree = "<group>";
                };
                CE9F4EBE233C56BF00268AAD /* uitestingUITests */ = {
                        isa = PBXNativeTarget;
                        buildConfigurationList = CE9F4ECB233C56BF00268AAD /* Build configuration list for PBXNativeTarget "uitestingUITests" */;
                        buildPhases = (
                                CE9F4EBB233C56BF00268AAD /* Sources */,
                                CE9F4EBC233C56BF00268AAD /* Frameworks */,
                                CE9F4EBD233C56BF00268AAD /* Resources */,
                        );
                        buildRules = (
                        );
                        dependencies = (
                                CE9F4EC5233C56BF00268AAD /* PBXTargetDependency */,
                        );
                        name = uitestingUITests;
                        productName = uitestingUITests;
                        productReference = CE9F4EBF233C56BF00268AAD /* uitestingUITests.xctest */;
                        productType = "com.apple.product-type.bundle.ui-testing";
                };
                CE9F4EBD233C56BF00268AAD /* Resources */ = {
                        isa = PBXResourcesBuildPhase;
                        buildActionMask = 2147483647;
                        files = (
                        );
                        runOnlyForDeploymentPostprocessing = 0;
                };
                CE9F4EBB233C56BF00268AAD /* Sources */ = {
                        isa = PBXSourcesBuildPhase;
                        buildActionMask = 2147483647;
                        files = (
                                CE9F4EC2233C56BF00268AAD /* uitestingUITests.m in Sources */,
                        );
                        runOnlyForDeploymentPostprocessing = 0;
                };
                CE9F4EC5233C56BF00268AAD /* PBXTargetDependency */ = {
                        isa = PBXTargetDependency;
                        target = ${TARGET_ID} /* uitesting */;
                        targetProxy = CE9F4EC4233C56BF00268AAD /* PBXContainerItemProxy */;
                };
                CE9F4EC6233C56BF00268AAD /* Debug */ = {
                        isa = XCBuildConfiguration;
${BUILD}
                        name = Debug;
                };
                CE9F4EC7233C56BF00268AAD /* Release */ = {
                        isa = XCBuildConfiguration;
${BUILD}
                        name = Release;
                };
                CE9F4ECB233C56BF00268AAD /* Build configuration list for PBXNativeTarget "uitestingUITests" */ = {
                        isa = XCConfigurationList;
                        buildConfigurations = (
                                CE9F4EC6233C56BF00268AAD /* Debug */,
                                CE9F4EC7233C56BF00268AAD /* Release */,
                        );
                        defaultConfigurationIsVisible = 0;
                };
`;
	pbx=pbx.replace("objects = {","objects = {"+objects)

	var R = new RegExp("children[\\s]*=[\\s]*[\\s\\r\\n\\t (]*"+PRODUCT_REF+".*","m")
	pbx=pbx.replace(R,function(a){return a+`
                                CE9F4EBF233C56BF00268AAD /* uitestingUITests.xctest */,
                                CE9F4EC0233C56BF00268AAD /* uitestingUITests */,`;});
	pbx=pbx.replace(/isa = PBXProject;[\s]*attributes = \{/,function(a){
		return a+`
                                TargetAttributes = {
                                        CE9F4EBE233C56BF00268AAD = {
                                                CreatedOnToolsVersion = 8.1;
                                                ProvisioningStyle = Automatic;
                                                TestTargetID = 1D6058900D05DD3D006BFB54;
                                        };
                                };`
		});
	var R = new RegExp("targets[\\s]*=[\\s]*[\\s\\r\\n\\t (]*"+TARGET_ID+".*","m")
	pbx=pbx.replace(R,function(a){return a+`
                                CE9F4EBE233C56BF00268AAD /* uitestingUITests */,`;});

	sch=sch.replace("<Testables>",`<Testables>
          <TestableReference
             skipped = "NO">
             <BuildableReference
                BuildableIdentifier = "primary"
                BlueprintIdentifier = "CE9F4EBE233C56BF00268AAD"
                BuildableName = "uitestingUITests.xctest"
                BlueprintName = "uitestingUITests"
                ReferencedContainer = "container:${PRODUCT_NAME}.xcodeproj">
             </BuildableReference>
          </TestableReference>
`)


	console.log('Write to ',outfile,outscheme);
	fs.writeFileSync(outfile,pbx);
	fs.writeFileSync(outscheme,sch);
}

addtests(process.argv[2], process.argv[2], process.argv[3], process.argv[3]);
