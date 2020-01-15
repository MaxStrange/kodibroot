# File required by Buildroot's BR2_EXTERNAL mode, which allows us to build stuff in this directory
# while using buildroot from a different directory.

include $(sort $(wildcard $(BR2_EXTERNAL_KODI_PATH)/package/*/*.mk))
