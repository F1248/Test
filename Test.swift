import Foundation

func main(bundlePath: String, className: String, instanceName: String, propertyName: String) -> String {
	guard Bundle(path: bundlePath)?.load() ?? false else {
		return "Failed to load bundle!"
	}

	guard let theClass: NSObject.Type = NSClassFromString(className) as? NSObject.Type else {
		return "Falied to create `theClass`!"
	}

	guard
		theClass.responds(to: NSSelectorFromString(instanceName)),
		let instance: NSObject = theClass.perform(NSSelectorFromString(instanceName))?.takeUnretainedValue() as? NSObject
	else {
		return "Failed to create `instance`!"
	}

	guard
		instance.responds(to: NSSelectorFromString(propertyName)),
		let property: Any = instance.perform(NSSelectorFromString(propertyName))?.takeUnretainedValue()
	else {
		return "Failed to create `property`"
	}
	return "\"\(property)\" of type \(type(of: property))"
}
print(main(
	bundlePath: "/System/Library/PrivateFrameworks/AboutSettings.framework",
	className: "ASPlatformInfo",
	instanceName: "shared",
	propertyName: "regulatoryID",
))
