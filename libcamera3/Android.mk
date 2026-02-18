# Copyright (C) 2015 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)

#################
# libexynoscamera3

include $(CLEAR_VARS)

ifeq ($(TARGET_BOARD_PLATFORM), universal7870)
######## System LSI ONLY ########
BOARD_CAMERA_GED_FEATURE := true
#################################
else
BOARD_CAMERA_GED_FEATURE := false
endif
LOCAL_PROPRIETARY_MODULE := true

LOCAL_PRELINK_MODULE := false

LOCAL_SHARED_LIBRARIES:= libutils libcutils libbinder liblog libcamera_metadata_helper libhardware libui
LOCAL_SHARED_LIBRARIES += libexynosutils libhwjpeg libexynosv4l2 libexynosgscaler libion libcsc
LOCAL_SHARED_LIBRARIES += libexpat libc++
LOCAL_SHARED_LIBRARIES += libpower


LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libbinder
LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libgui_vendor
LOCAL_SHARED_LIBRARIES += libsecnativefeature
LOCAL_SHARED_LIBRARIES += libuniplugin
LOCAL_SHARED_LIBRARIES += libsensorlistener


#ifeq ($(BOARD_CAMERA_GED_FEATURE), true)
#else
#LOCAL_SHARED_LIBRARIES += libsecnativefeature
#LOCAL_SHARED_LIBRARIES += libuniplugin
#endif

ifeq ($(BOARD_CAMERA_SW_VDIS), true)
LOCAL_SHARED_LIBRARIES += libvdis
endif

# misc
LOCAL_CFLAGS += -Wno-implicit-fallthrough
LOCAL_CFLAGS += -Wno-unused-parameter
LOCAL_CFLAGS += -Wno-unused-variable
LOCAL_CFLAGS += -Wno-format
LOCAL_CFLAGS += -Wno-integer-overflow
LOCAL_CFLAGS += -Wno-mismatched-tags
LOCAL_CFLAGS += -Wno-unused-private-field
LOCAL_CFLAGS += -Wno-unused-label

LOCAL_CFLAGS += -Wno-error=date-time
LOCAL_CFLAGS += -Wno-overloaded-virtual

LOCAL_CFLAGS += -DUSE_LIB_ION_LEGACY
LOCAL_CFLAGS += -DGAIA_FW_BETA
LOCAL_CFLAGS += -DMAIN_CAMERA_SENSOR_NAME=$(BOARD_BACK_CAMERA_SENSOR)
LOCAL_CFLAGS += -DFRONT_CAMERA_SENSOR_NAME=$(BOARD_FRONT_CAMERA_SENSOR)
LOCAL_CFLAGS += -DUSE_CAMERA_ESD_RESET
LOCAL_CFLAGS += -DBACK_ROTATION=$(BOARD_BACK_CAMERA_ROTATION)
LOCAL_CFLAGS += -DFRONT_ROTATION=$(BOARD_FRONT_CAMERA_ROTATION)

ifeq ($(TARGET_BOOTLOADER_BOARD_NAME), universal7870)
#LOCAL_CFLAGS += -DUNIVERSAL_CAMERA
endif

ifeq ($(BOARD_CAMERA_GED_FEATURE), true)
LOCAL_CFLAGS += -DCAMERA_GED_FEATURE
endif

LOCAL_CFLAGS += -DUSE_CAMERA2_API_SUPPORT
# LOCAL_CFLAGS += -DBURST_CAPTURE

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../libcamera3 \
	$(TOP)/system/media/camera/include \
	$(TOP)/system/core/libion/include \
	$(TOP)/system/core/libsync/include \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/kernel-$(TARGET_LINUX_KERNEL_VERSION)-headers/kernel-headers \
	$(TOP)/system/memory/libion/kernel-headers \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870 \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/SensorInfos \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Pipes2 \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/MCPipes \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Activities \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Buffers \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Ged \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/PostProcessing \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/SizeTables \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Sec \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Sec/PPUniPlugin \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/7870 \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/7870/hal3 \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/include \
	$(TOP)/hardware/samsung_slsi-linaro/exynos5/include \
	$(TOP)/hardware/samsung_slsi-linaro/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi-linaro/$(TARGET_SOC)/libcamera \
	$(TOP)/hardware/samsung_slsi-linaro/$(TARGET_SOC)/libcamera3 \
	$(TOP)/hardware/samsung_slsi-linaro/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi-linaro/$(TARGET_BOARD_PLATFORM)/libcamera3 \
	$(TOP)/hardware/libhardware/include \
	$(TOP)/hardware/libhardware_legacy/include/hardware_legacy \
	$(TOP)/hardware/interfaces/camera/common/1.0/default/include \
	$(TOP)/vendor/samsung/feature/CscFeature/libsecnativefeature \
	$(TOP)/bionic \
	$(TOP)/external/expat/lib \
	$(TOP)/external/libcxx/include \
	$(TOP)/frameworks/native/include \
	$(TOP)/frameworks/native/libs/nativebase/include \
	$(TOP)/frameworks/native/libs/nativewindow/include \
	$(TOP)/frameworks/native/libs/arect/include \
	$(TOP)/frameworks/native/headers/media_plugin/media/openmax \
	$(TOP)/frameworks/av/include \
	$(TOP)/frameworks/av/include/camera \
	$(TOP)/frameworks/av/camera/include \
	$(TOP)/hardware/camera/SensorListener \
	$(TOP)/hardware/camera/UniPlugin/include

ifeq ($(BOARD_CAMERA_USES_DUAL_CAMERA), true)
LOCAL_C_INCLUDES += \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Fusion \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/libcamera/common_v3_7870/Fusion/DofLut
endif


LOCAL_C_INCLUDES += $(LOCAL_PATH)/../libcamera/SensorInfos


LOCAL_HEADER_LIBRARIES += libcutils_headers libsystem_headers libhardware_headers libexynos_headers

LOCAL_SRC_FILES:= \
	../../exynos/libcamera/common_v3_7870/ExynosCameraFrame.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraMemory.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraFrameManager.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraUtils.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraNode.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraNodeJpegHAL.cpp \
	../../exynos/libcamera/common_v3_7870/SensorInfos/ExynosCameraSensorInfoBase.cpp \
	../../exynos/libcamera/common_v3_7870/SensorInfos/ExynosCamera3SensorInfoBase.cpp \
    ../../exynos/libcamera/common_v3_7870/ExynosCameraTimeLogger.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraFrameSelector.cpp \
	../../exynos/libcamera/common_v3_7870/MCPipes/ExynosCameraMCPipe.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipe.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeFlite.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeVRA.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeGSC.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeJpeg.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipePP.cpp \
	../../exynos/libcamera/common_v3_7870/PostProcessing/ExynosCameraPP.cpp \
	../../exynos/libcamera/common_v3_7870/PostProcessing/ExynosCameraPPLibcsc.cpp \
	../../exynos/libcamera/common_v3_7870/PostProcessing/ExynosCameraPPJPEG.cpp \
	../../exynos/libcamera/common_v3_7870/PostProcessing/ExynosCameraPPGDC.cpp \
	../../exynos/libcamera/common_v3_7870/PostProcessing/ExynosCameraPPFactory.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeSTK_PICTURE.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeSTK_PREVIEW.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeVRAGroup.cpp \
	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraSWPipe.cpp \
	../../exynos/libcamera/common_v3_7870/Buffers/ExynosCameraBufferManager.cpp \
	../../exynos/libcamera/common_v3_7870/Buffers/ExynosCameraBufferLocker.cpp \
	../../exynos/libcamera/common_v3_7870/Activities/ExynosCameraActivityBase.cpp \
	../../exynos/libcamera/common_v3_7870/Activities/ExynosCameraActivityAutofocus.cpp \
	../../exynos/libcamera/common_v3_7870/Activities/ExynosCameraActivityFlash.cpp \
	../../exynos/libcamera/common_v3_7870/Activities/ExynosCameraActivitySpecialCapture.cpp \
	../../exynos/libcamera/common_v3_7870/Activities/ExynosCameraActivityUCTL.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/ExynosCameraActivityAutofocusVendor.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/ExynosCameraActivityFlashVendor.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraRequestManager.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraStreamManager.cpp \
	../../exynos/libcamera/common_v3_7870/ExynosCameraMetadataConverter.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/ExynosCameraFrameSelectorVendor.cpp \
    ../../exynos/libcamera/common_v3_7870/Sec/ExynosCameraMetadataConverterVendor.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/SecAppMarker.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/SecCameraVendorTags.cpp \
	../../exynos/libcamera/common_v3_7870/Sec/SecCameraUtil.cpp \
    ../../exynos/libcamera/common_v3_7870/Sec/SecCameraDngThumbnail.cpp \
    ../../exynos/libcamera/common_v3_7870/Sec/SecCameraHyperMotion.cpp \
	../../exynos/libcamera/7870/ExynosCameraActivityControl.cpp\
	../../exynos/libcamera/7870/ExynosCameraScalableSensor.cpp \
	../../exynos/libcamera/7870/ExynosCameraUtilsModule.cpp


ifeq ($(BOARD_CAMERA_USES_DUAL_CAMERA), true)
LOCAL_SRC_FILES += \
    ../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeSync.cpp \
    ../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeFusion.cpp \
    ../../exynos/libcamera/common_v3_7870/Fusion/ExynosCameraFusionMetaDataConverter.cpp \
    ../../exynos/libcamera/common_v3_7870/Fusion/ExynosCameraFusionWrapper.cpp \
    ../../exynos/libcamera/7870/ExynosCameraFrameFactoryPreviewDual.cpp \
    ../../exynos/libcamera/7870/ExynosCameraFrameReprocessingFactoryDual.cpp
endif

ifeq ($(BOARD_CAMERA_USES_UVS), true)
LOCAL_SRC_FILES += \
 	../../exynos/libcamera/common_v3_7870/Pipes2/ExynosCameraPipeUVS.cpp
endif

#HAL 3.0 source
LOCAL_SRC_FILES += \
	../../exynos/libcamera/7870/hal3/ExynosCameraSizeControl.cpp \
	../../exynos/libcamera/7870/hal3/ExynosCamera3.cpp \
	../../exynos/libcamera/7870/hal3/ExynosCamera3Parameters.cpp \
	../../exynos/libcamera/7870/hal3/ExynosCamera3FrameFactory.cpp \
	../../exynos/libcamera/7870/hal3/ExynosCamera3FrameFactoryPreview.cpp \
	../../exynos/libcamera/7870/hal3/ExynosCamera3FrameReprocessingFactory.cpp

LOCAL_SRC_FILES += ../libcamera/SensorInfos/ExynosCamera3SensorInfo.cpp

#$(foreach file,$(LOCAL_SRC_FILES),$(shell touch '$(LOCAL_PATH)/$(file)'))

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_TARGET_ARCH:= arm
LOCAL_MODULE := libexynoscamera3

include $(TOP)/hardware/samsung_slsi-linaro/exynos/BoardConfigCFlags.mk
include $(BUILD_SHARED_LIBRARY)

$(warning ##########################################)
$(warning ##########################################)
$(warning ########     libcamera 3     #############)
$(warning ##########################################)
$(warning ##########################################)
