//
//  batterydata
//
//  Prints battery info from IOKit to console.
//  For iOS.
//
//  by Flobul
//

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/ps/IOPowerSources.h>


int main(int argc, char **argv, char **envp) {
	
	NSMutableString *batteryInfo = [NSMutableString new];
	
	CFTypeRef data = IOPSCopyPowerSourcesInfo();
	CFArrayRef sources = IOPSCopyPowerSourcesList(data);
	
	[batteryInfo appendString:@"Data from IOPSCopyPowerSourcesInfo:\n-------------------------\n"];
	
	if (CFArrayGetCount(sources) > 0) {
		NSDictionary *limitedBatteryInfo = ( (NSDictionary *) ((NSArray *)CFBridgingRelease(data))[0] );
		for (NSString *key in limitedBatteryInfo.allKeys) {
			[batteryInfo appendString:[NSString stringWithFormat:@"%@ : %@", key, limitedBatteryInfo[key]]];
			[batteryInfo appendString:@"\n"];
		}
	}
	
	[batteryInfo appendString:@"\n\nData from IOPMPowerSource:\n-------------------------\n"];
	
	io_service_t powerSource = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPMPowerSource"));
	CFMutableDictionaryRef batteryProperties = NULL;
	IORegistryEntryCreateCFProperties(powerSource, &batteryProperties, NULL, 0);
	NSDictionary *fullBatteryInfo = (__bridge_transfer NSDictionary *)batteryProperties;
	for (NSString *key in fullBatteryInfo.allKeys) {
		[batteryInfo appendString:[NSString stringWithFormat:@"%@ : %@", key, fullBatteryInfo[key]]];
		[batteryInfo appendString:@"\n"];
	}

	printf("\nIOKit Battery Info >>\n\n%s\n", batteryInfo.UTF8String);
	
	return 0;
}
