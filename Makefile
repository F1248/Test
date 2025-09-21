define evaluate-log
	if grep --quiet "error:" xcodebuild.log; then exit 1; fi
endef

test:
	echo "This is a error: in the file" > xcodebuild.log
	$(evaluate-log)