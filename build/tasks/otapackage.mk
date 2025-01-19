# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
# Copyright (C) 2024 risingOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# RisingOS OTA update package

RISING_TARGET_PACKAGE := $(PRODUCT_OUT)/RisingOS-$(RISING_BUILD_VERSION)-ota.zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bacon
bacon: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(RISING_TARGET_PACKAGE)
	$(hide) $(SHA256) $(RISING_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(RISING_TARGET_PACKAGE).sha256sum
	@echo ""
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "  ______ _____ _______ _____ __   _  ______      _____  _______" >&2
	@echo " |_____/   |   |______   |   | \  | |  ____     |     | |______" >&2
	@echo " |    \_ __|__ ______| __|__ |  \_| |_____|     |_____| ______|" >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                   rising from the bottom                      " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo ""
	@echo "Creating json OTA..." >&2
	$(hide) ./vendor/rising/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) RisingOS-$(RISING_BUILD_VERSION)-ota.zip $(RISING_VERSION) $(RISING_CODENAME) $(RISING_PACKAGE_TYPE) $(RISING_RELEASE_TYPE)
	$(hide) cp -f $(PRODUCT_OUT)/$(TARGET_DEVICE).json vendor/official_devices/OTA/device/$(RISING_PACKAGE_TYPE)/$(TARGET_DEVICE).json
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo " Size            : $(shell du -hs $(RISING_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Size(in bytes)  : $(shell wc -c $(RISING_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Package Complete: $(RISING_TARGET_PACKAGE)" >&2
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo ""
