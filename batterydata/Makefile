ARCHS = arm64 armv7 armv7s armv6
TARGET = iphone:clang:latest:9.0
include $(THEOS)/makefiles/common.mk

TOOL_NAME = batterydata
batterydata_FILES = main.mm
batterydata_CFLAGS = -fobjc-arc
batterydata_FRAMEWORKS = IOKit

include $(THEOS_MAKE_PATH)/tool.mk
