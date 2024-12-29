# bcmdhd
#
# Portions of this code are copyright (c) 2024 Cypress Semiconductor Corporation
#
# Copyright (C) 1999-2018, Broadcom Corporation
#
#      Unless you and Broadcom execute a separate written software license
# agreement governing use of this software, this software is licensed to you
# under the terms of the GNU General Public License version 2 (the "GPL"),
# available at http://www.broadcom.com/licenses/GPLv2.php, with the
# following added to such license:
#
#      As a special exception, the copyright holders of this software give you
# permission to link this software with independent modules, and to copy and
# distribute the resulting executable under terms of your choice, provided that
# you also meet, for each linked independent module, the terms and conditions of
# the license of that module.  An independent module is a module which is not
# derived from this software.  The special exception does not apply to any
# modifications of the software.
#
#      Notwithstanding the above, under no circumstances may you combine this
# software in any way with any other Broadcom software provided under a license
# other than the GPL, without Broadcom's express prior written consent.
#
#
# <<Broadcom-WL-IPTag/Open:>>
#

######################
# Compilation control
######################

#CONFIG_BCMDHD:=m
#CONFIG_BCMDHD_SDIO:=y
#CONFIG_BCMDHD_SDMMC:=y
#CONFIG_BCMDHD_PCIE:=y
#CONFIG_DHD_OF_SUPPORT:=y
#CONFIG_BCMDHD_FW_PATH:=\"/lib/firmware/cypress/cyfmacUNKNOWN.bin\"
#CONFIG_BCMDHD_NVRAM_PATH:=\"/lib/firmware/cypress/cyfmacUNKNOWN.txt\"
#CONFIG_BCMDHD_CLM_PATH:=\"/lib/firmware/cypress/cyfmacUNKNOWN.clm_blob\"
#CONFIG_BROADCOM_WIFI_RESERVED_MEM:=y
#CONFIG_DHD_USE_STATIC_BUF:=y
#CONFIG_BCMDHD_DPC_IN_ISR:=y
#CONFIG_BCMDHD_OOB_HOST_WAKE:=y
#CONFIG_BCMDHD_WPA3:=y
#CONFIG_BCMDHD_WIFI6:=y
#CONFIG_BCMDHD_WIFI6_6E:=y

ifneq ($(CONFIG_BCMDHD),)
DHDCFLAGS += -DCONFIG_BCMDHD=$(CONFIG_BCMDHD)
endif

ifeq ($(CONFIG_BCMDHD_SDIO),y)
DHDCFLAGS += -DCONFIG_BCMDHD_SDIO=$(CONFIG_BCMDHD_SDIO)
endif

ifeq ($(CONFIG_BCMDHD_SDMMC),y)
DHDCFLAGS += -DCONFIG_BCMDHD_SDMMC=$(CONFIG_BCMDHD_SDMMC)
endif

ifeq ($(CONFIG_BCMDHD_PCIE),y)
DHDCFLAGS += -DCONFIG_BCMDHD_PCIE=$(CONFIG_BCMDHD_PCIE)
endif

ifeq ($(CONFIG_CYW43022),y)
DHDCFLAGS += -DCONFIG_CYW43022=$(CONFIG_CYW43022)
endif

ifeq ($(CONFIG_DHD_OF_SUPPORT),y)
DHDCFLAGS += -DCONFIG_DHD_OF_SUPPORT=$(CONFIG_DHD_OF_SUPPORT)
endif

ifneq ($(CONFIG_BCMDHD_FW_PATH),)
DHDCFLAGS += -DCONFIG_BCMDHD_FW_PATH=$(CONFIG_BCMDHD_FW_PATH)
endif

ifneq ($(CONFIG_BCMDHD_NVRAM_PATH),)
DHDCFLAGS += -DCONFIG_BCMDHD_NVRAM_PATH=$(CONFIG_BCMDHD_NVRAM_PATH)
endif

ifneq ($(CONFIG_BCMDHD_CLM_PATH),)
DHDCFLAGS += -DCONFIG_BCMDHD_CLM_PATH=$(CONFIG_BCMDHD_CLM_PATH)
endif

ifeq ($(CONFIG_BROADCOM_WIFI_RESERVED_MEM),y)
DHDCFLAGS += -DCONFIG_BROADCOM_WIFI_RESERVED_MEM=$(CONFIG_BROADCOM_WIFI_RESERVED_MEM)
endif

ifeq ($(CONFIG_DHD_USE_STATIC_BUF),y)
DHDCFLAGS += -DCONFIG_DHD_USE_STATIC_BUF=$(CONFIG_DHD_USE_STATIC_BUF)
endif

ifeq ($(CONFIG_DHD_USE_SCHED_SCAN),y)
DHDCFLAGS += -DCONFIG_DHD_USE_SCHED_SCAN=$(CONFIG_DHD_USE_SCHED_SCAN)
endif

ifeq ($(CONFIG_DHD_SET_RANDOM_MAC_VAL),y)
DHDCFLAGS += -DCONFIG_DHD_SET_RANDOM_MAC_VAL=$(CONFIG_DHD_SET_RANDOM_MAC_VAL)
endif

ifeq ($(CONFIG_WL_AP_IF),y)
DHDCFLAGS += -DCONFIG_WL_AP_IF=$(CONFIG_WL_AP_IF)
endif

ifeq ($(CONFIG_ENABLE_HOGSQS),y)
DHDCFLAGS += -DCONFIG_ENABLE_HOGSQS=$(CONFIG_ENABLE_HOGSQS)
endif

ifeq ($(CONFIG_BCMDHD_DPC_IN_ISR),y)
DHDCFLAGS += -DCONFIG_BCMDHD_DPC_IN_ISR=$(CONFIG_BCMDHD_DPC_IN_ISR)
endif

ifeq ($(CONFIG_BCMDHD_OOB_HOST_WAKE),y)
DHDCFLAGS += -DCONFIG_BCMDHD_OOB_HOST_WAKE=$(CONFIG_BCMDHD_OOB_HOST_WAKE)
endif

ifeq ($(CONFIG_BCMDHD_GET_OOB_STATE),y)
DHDCFLAGS += -DCONFIG_BCMDHD_GET_OOB_STATE=$(CONFIG_BCMDHD_GET_OOB_STATE)
endif

ifeq ($(CONFIG_BCMDHD_WPA3),y)
DHDCFLAGS += -DCONFIG_BCMDHD_WPA3=$(CONFIG_BCMDHD_WPA3)
endif

ifeq ($(CONFIG_BCMDHD_WIFI6),y)
DHDCFLAGS += -DCONFIG_BCMDHD_WIFI6=$(CONFIG_BCMDHD_WIFI6)
endif

ifeq ($(CONFIG_BCMDHD_WIFI6_6E),y)
DHDCFLAGS += -DCONFIG_BCMDHD_WIFI6_6E=$(CONFIG_BCMDHD_WIFI6_6E)
endif

##################
# Logging control
##################

# SDLX_MSG(x) debug message
#DHDCFLAGS += -DDHD_SDLX_MSG
# KSO_DBG(x) debug message
#DHDCFLAGS += -DDHD_KSO_DEBUG
# SI_VMSG(args) debug message
#DHDCFLAGS += -DBCMDBG_SI
# SI_MSG(args) debug message
#DHDCFLAGS += -DDHD_SI_MSG
# SI_ERROR(args) debug message
DHDCFLAGS += -DSI_ERROR_ENFORCE
# PKT Statistics
#DHDCFLAGS += -DPKT_STATICS
# Protocol debug
#DHDCFLAGS += -DDHD_ARP_DUMP -DDHD_DHCP_DUMP -DDHD_ICMP_DUMP -DDHD_DNS_DUMP
# wlfc debug
#DHDCFLAGS += -DPROP_TXSTATUS_DEBUG

################
# Basic feature
################

DHDCFLAGS += -Wall -Wstrict-prototypes -Dlinux -DLINUX -DBCMDRIVER        \
	-DBCMDONGLEHOST -DUNRELEASEDCHIP -DBCMDMA32 -DBCMFILEIMAGE            \
	-DDHDTHREAD -DSHOW_EVENTS -DBCMDBG -DWLP2P                            \
	-DWIFI_ACT_FRAME -DARP_OFFLOAD_SUPPORT                                \
	-DKEEP_ALIVE -DCSCAN -DPKT_FILTER_SUPPORT                             \
	-DEMBEDDED_PLATFORM -DPNO_SUPPORT -DSHOW_LOGTRACE                     \
	-DGET_CUSTOM_MAC_ENABLE                                               \
	-DSEC_ENHANCEMENT -DDHD_FW_COREDUMP -DCHIPS_CUSTOMER_HW6              \
	-DDHD_RND_DEBUG                                                       \
	-DDHD_DONOT_FORWARD_BCMEVENT_AS_NETWORK_PKT

GCCVERSIONGTEQ7 := $(shell expr `$(CROSS_COMPILE)gcc -dumpversion | cut -f1 -d.` \>= 7)
ifeq "$(GCCVERSIONGTEQ7)" "1"
DHDCFLAGS += -Wimplicit-fallthrough=3
DHDCFLAGS += $(call cc-disable-warning, format-truncation)
endif
DHDCFLAGS += $(call cc-disable-warning, date-time)
DHDCFLAGS += $(call cc-disable-warning, stringop-overflow)
DHDCFLAGS += $(call cc-disable-warning, missing-prototypes)
DHDCFLAGS += $(call cc-disable-warning, missing-declarations)

#################
# Common feature
#################

# WAR
DHDCFLAGS += -DEXPLICIT_DISCIF_CLEANUP
DHDCFLAGS += -DMULTIPLE_SUPPLICANT
DHDCFLAGS += -DDISABLE_CCODE_CHANGE_FROM_USER
DHDCFLAGS += -DDHD_NOTIFY_MAC_CHANGED

DHDCFLAGS += -DAUTOMOTIVE_FEATURE
DHDCFLAGS += -DWL_VIRTUAL_APSTA

# Dongle init fail
DHDCFLAGS += -DDEBUG_DNGL_INIT_FAIL
DHDCFLAGS += -DPOWERUP_MAX_RETRY=0

# Wapi
DHDCFLAGS += -DBCMWAPI_WPI -DBCMWAPI_WAI

# Allow wl event forwarding as network packet
#DHDCFLAGS += -DWL_EVENT_ENAB

DHDCFLAGS += -DWL_CFG80211
# Print out kernel panic point of file and line info when assertion happened
DHDCFLAGS += -DBCMASSERT_LOG

# Enable Log Dump
DHDCFLAGS += -DDHD_LOG_DUMP
DHDCFLAGS += -DOEM_ANDROID

# Enable Register access via dhd IOVAR
DHDCFLAGS += -DDHD_PCIE_REG_ACCESS -DDHD_BUS_MEM_ACCESS

# CUSTOMER4 flags
DHDCFLAGS += -DDHD_PKTID_AUDIT_ENABLED
DHDCFLAGS += -DSUPPORT_HIDDEN_AP
DHDCFLAGS += -DPASS_ALL_MCAST_PKTS -DESCAN_BUF_OVERFLOW_MGMT -DPKTPRIO_OVERRIDE
DHDCFLAGS += -DUSE_INITIAL_SHORT_DWELL_TIME
DHDCFLAGS += -DSOFTAP_UAPSD_OFF
DHDCFLAGS += -DSUPPORT_LTECX -DSUPPORT_2G_VHT
DHDCFLAGS += -DSUPPORT_WL_TXPOWER -DSUPPORT_DEEP_SLEEP
DHDCFLAGS += -DSUPPORT_AMPDU_MPDU_CMD -DSOFTAP_SEND_HANGEVT -DNUM_SCB_MAX_PROBE=3
DHDCFLAGS += -DCUSTOM_TCPACK_DELAY_TIME=10
DHDCFLAGS += -DDEBUGFS_CFG80211
DHDCFLAGS += -DSUPPORT_SOFTAP_WPAWPA2_MIXED
DHDCFLAGS += -DSUPPORT_2G_VHT -DSUPPORT_5G_1024QAM_VHT
DHDCFLAGS += -DEWP_ETD_PRSRV_LOGS

# DMA64 suppports on 64bit Architecture
ifeq ($(CONFIG_64BIT),y)
DHDCFLAGS := $(filter-out -DBCMDMA32,$(DHDCFLAGS))
DHDCFLAGS += -DBCMDMA64OSL
endif

# keepalive
DHDCFLAGS += -DCUSTOM_KEEP_ALIVE_SETTING=28000

# OWE enable in dhd
DHDCFLAGS += -DWL_OWE

DHDCFLAGS += -DVSDB

# For p2p connection issue
DHDCFLAGS += -DWL_SCB_TIMEOUT=10

# TDLS enable
DHDCFLAGS += -DWLTDLS -DWLTDLS_AUTO_ENABLE
# For TDLS tear down inactive time 40 sec
DHDCFLAGS += -DCUSTOM_TDLS_IDLE_MODE_SETTING=10000
# for TDLS RSSI HIGH for establishing TDLS link
DHDCFLAGS += -DCUSTOM_TDLS_RSSI_THRESHOLD_HIGH=-80
# for TDLS RSSI HIGH for tearing down TDLS link
DHDCFLAGS += -DCUSTOM_TDLS_RSSI_THRESHOLD_LOW=-85

# Roaming
DHDCFLAGS += -DROAM_AP_ENV_DETECTION
DHDCFLAGS += -DROAM_ENABLE -DROAM_CHANNEL_CACHE -DROAM_API
DHDCFLAGS += -DENABLE_FW_ROAM_SUSPEND
# Roaming trigger
DHDCFLAGS += -DCUSTOM_ROAM_TRIGGER_SETTING=-75
DHDCFLAGS += -DCUSTOM_ROAM_DELTA_SETTING=10
# Set PM 2 always regardless suspend/resume
DHDCFLAGS += -DSUPPORT_PM2_ONLY
# Opportunistic Key Caching
DHDCFLAGS += -DOKC_SUPPORT

# FT roam
DHDCFLAGS += -DWLFBT -DGTK_OFFLOAD_SUPPORT
DHDCFLAGS += -DBCMCCX
DHDCFLAGS += -DWBTEXT
DHDCFLAGS += -DDHD_LOSSLESS_ROAMING

# 4 Way Handshake offload
DHDCFLAGS += -DBCMSUP_4WAY_HANDSHAKE
ifeq ($(CONFIG_BCMDHD_WPA3),y)
DHDCFLAGS += -DBCMSUP_4WAY_HANDSHAKE_SAE
endif
DHDCFLAGS += -DWL_IDAUTH

# Hog flags
ifeq ($(CONFIG_ENABLE_HOGSQS),y)
DHDCFLAGS += -DENABLE_HOGSQS
DHDCFLAGS += -DM_HOGSQS_CFG=0x1910
endif

# For special PNO Event keep wake lock for 10sec
DHDCFLAGS += -DCUSTOM_PNO_EVENT_LOCK_xTIME=10
DHDCFLAGS += -DMIRACAST_AMPDU_SIZE=8
# Vendor Extension
#DHDCFLAGS += -DWL_VENDOR_EXT_SUPPORT
# Gscan
DHDCFLAGS += -DGSCAN_SUPPORT
# PNO Scan Result Version
DHDCFLAGS += -DPFN_SCANRESULT_2
# RSSI Monitor
DHDCFLAGS += -DRSSI_MONITOR_SUPPORT
# APF
DHDCFLAGS += -DAPF
# NDOffload
DHDCFLAGS += -DNDO_CONFIG_SUPPORT
DHDCFLAGS += -DIPV6_NDO_SUPPORT

# Link Statistics
DHDCFLAGS += -DLINKSTAT_SUPPORT

# Debugaility
DHDCFLAGS += -DDBG_PKT_MON -DDBG_PKT_MON_INIT_DEFAULT
DHDCFLAGS += -DWL_SCHED_SCAN
DHDCFLAGS += -DDNGL_EVENT_SUPPORT

# RSSI Monitor
DHDCFLAGS += -DRSSI_MONITOR_SUPPORT

# Early suspend
DHDCFLAGS += -DDHD_USE_EARLYSUSPEND

# For Scan result patch
DHDCFLAGS += -DESCAN_RESULT_PATCH

# NAN
#DHDCFLAGS += -DWL_NAN -DWL_NAN_DISC_CACHE

# For Static Buffer
ifeq ($(CONFIG_DHD_USE_STATIC_BUF),y)
DHDCFLAGS += -DCONFIG_DHD_USE_STATIC_BUF=$(CONFIG_DHD_USE_STATIC_BUF)
DHDCFLAGS += -DENHANCED_STATIC_BUF
DHDCFLAGS += -DSTATIC_WL_PRIV_STRUCT
DHDCFLAGS += -DDHD_USE_STATIC_MEMDUMP
ifeq ($(CONFIG_BCMDHD_PCIE),y)
DHDCFLAGS += -DDHD_USE_STATIC_CTRLBUF
endif
endif

ifeq ($(CONFIG_BROADCOM_WIFI_RESERVED_MEM),y)
DHDCFLAGS += -DCONFIG_BROADCOM_WIFI_RESERVED_MEM=$(CONFIG_BROADCOM_WIFI_RESERVED_MEM)
DHDOFILES += dhd_custom_memprealloc.o
endif

ifeq ($(CONFIG_DHD_USE_SCHED_SCAN),y)
DHDCFLAGS += -DWL_SCHED_SCAN
endif

# Prevent rx thread monopolize
DHDCFLAGS += -DWAIT_DEQUEUE

# idle count
DHDCFLAGS += -DDHD_USE_IDLECOUNT

# SKB TAILPAD to avoid out of boundary memory access
DHDCFLAGS += -DDHDENABLE_TAILPAD

# Wi-Fi Direct
DHDCFLAGS += -DWL_CFG80211_VSDB_PRIORITIZE_SCAN_REQUEST
DHDCFLAGS += -DWL_CFG80211_STA_EVENT
DHDCFLAGS += -DWL_IFACE_COMB_NUM_CHANNELS
DHDCFLAGS += -DWL_SUPPORT_MULTIP2P
# SCAN time
DHDCFLAGS += -DCUSTOM_SET_SHORT_DWELL_TIME
DHDCFLAGS += -DCUSTOM_FORCE_NODFS_FLAG

# Disable Self Managed Regdom
# SEGFAULT of hostapd is found if we use self managed
# regdom and update wiphybands during wl_cfg80211_up()
# with ACS survey dump enabled.
#DHDCFLAGS += -DWL_SELF_MANAGED_REGDOM

# ACS survey dump
DHDCFLAGS += -DWL_SUPPORT_ACS
# ACS offload
DHDCFLAGS += -DWL_SUPPORT_ACS_OFFLOAD
DHDCFLAGS += -DWL_SUPPORT_AUTO_CHANNEL

ifeq ($(CONFIG_ANDROID),y)
DHDCFLAGS += -DKEEP_WIFION_OPTION
DHDCFLAGS += -Wno-date-time

CONFIG_ANDROID_VERSION ?= 0
DHDCFLAGS += -DCONFIG_ANDROID_VERSION=$(CONFIG_ANDROID_VERSION)

# for Android 12 and higher
ifeq ($(shell expr '$(CONFIG_ANDROID_VERSION)' \>= 12), 1)
DHDCFLAGS += -Wno-unused-const-variable
DHDCFLAGS += -Wno-unneeded-internal-declaration
ifeq ($(shell expr '$(CONFIG_ANDROID_VERSION)' \>= 13), 1)
DHDCFLAGS += -Wno-unused-but-set-variable

DHDCFLAGS += -DDEBUGABILITY
DHDCFLAGS += -DDHD_ANDROID_BRIDGE_SUPPORT
DHDCFLAGS += -DEWP_ECNTRS_LOGGING

ifeq ($(shell expr '$(CONFIG_ANDROID_VERSION)' \>= 14), 1)
DHDCFLAGS += -DDHD_FILE_DUMP_EVENT
DHDCFLAGS += -DDHD_HAL_RING_DUMP
endif

KERNELVER=$(VERSION)_$(PATCHLEVEL)
ifeq "$(KERNELVER)" "5_15"
ifeq ($(CONFIG_HAVE_IMX8_SOC),y)
# for IMX android kernel 5.15
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V1
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V2
else ifeq ($(CONFIG_ARCH_MESON),y)
# for VIM3 android kernel 5.15
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V1
else
# for common android kernel 5.15-lts.
ifeq ($(shell expr $(SUBLEVEL) \>= 44), 1)
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V1
endif
ifeq ($(shell expr $(SUBLEVEL) \>= 81), 1)
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V2
endif
ifeq ($(shell expr $(SUBLEVEL) \>= 99), 1)
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V3
endif
endif
endif

ifeq "$(KERNELVER)" "6_1"
DHDCFLAGS += -Wno-implicit-fallthrough
ifeq ($(shell expr $(SUBLEVEL) \>= 22), 1)
DHDCFLAGS += -DDHD_ANDROID_CFG80211_BACKPORT_V3
endif
endif
endif

DHDCFLAGS += -DP2P_RAND
DHDCFLAGS += -DSOFTAP_RAND
DHDCFLAGS += -DSTA_RAND
# To support Android12 CDD [C-1-7] [C-1-8] [C-1-9] [C-1-10]
DHDCFLAGS += -DSUPPORT_RANDOM_MAC_SCAN

# To support recovery
DHDCFLAGS += -DWL_CFGVENDOR_SEND_HANG_EVENT

DHDCFLAGS += -DDHD_DIRECT_SET_MAC
DHDCFLAGS += -DWL_SUPPORT_BSS_BOOTTIME

# To support Android Common kernel
#DHDCFLAGS += -DDHD_SUPPORT_REQFW_FOR_FIRMWARE_DOWNLOADING -DDHD_DENY_DIRECT_FS_ACCESS
endif
endif

# SoftAP
DHDCFLAGS += -DSET_RANDOM_MAC_SOFTAP
DHDCFLAGS += -DWL_CFG80211_ACL

# Static IF support
DHDCFLAGS += -DWL_IFACE_MGMT
ifeq ($(CONFIG_WL_AP_IF),y)
DHDCFLAGS += -DWL_STATIC_IF
DHDCFLAGS += -DDHD_NUM_STATIC_IFACES=1
endif

# QT support
ifeq ($(CONFIG_QT), y)
DHDCFLAGS += -DBCMQT_HW -DBCMSLTGT -DBCMQT
endif

# Disable FRAMEBURST on VSDB
DHDCFLAGS += -DDISABLE_FRAMEBURST_VSDB

# WPS
DHDCFLAGS += -DWL_WPS_SYNC -DBCMCRYPTO_COMPONENT

# WPA3
ifeq ($(CONFIG_BCMDHD_WPA3),y)
DHDCFLAGS += -DWL_SAE
endif

ifeq ($(CONFIG_BCMDHD_PCIE),y)
DHDCFLAGS += -DDHD_4WAYM4_FAIL_DISCONNECT
endif

# 802.11ax Support
ifeq ($(CONFIG_BCMDHD_WIFI6),y)
DHDCFLAGS += -DWL11AX
endif

# 802.11ax and 6Ghz Support
ifeq ($(CONFIG_BCMDHD_WIFI6_6E),y)
DHDCFLAGS += -DWL11AX
DHDCFLAGS += -DWL_6E
endif

# XR Support
ifeq ($(CONFIG_BCMDHD_XR_SUPPORT),y)
DHDCFLAGS += -DWL_DHD_XR -DWL_DHD_XR_LOG
DHDCFLAGS += -DWL_DHD_XR_PARALLEL_SCAN
# Supporting SDIO/PCI
#DHDCFLAGS += -DWL_DHD_XR_PCISDIO
ifneq ($(CONFIG_BCMDHD),)
DHDCFLAGS += -DWL_DHD_XR_MASTER
endif
ifneq ($(CONFIG_BCMDHDX),)
DRIVER_TYPE ?= $(CONFIG_BCMDHDX)
DHDCFLAGS += -DBCMDHDX -DWL_DHD_XR_CLIENT
endif
# Bandsteer support
DHDCFLAGS += -DDHD_BANDSTEER
DHDOFILES += wl_cfg80211_xr.o dhd_linux_xr.o
endif

ifeq ($(CONFIG_BCMDHD_DUAL_DRIVER_SUPPORT),y)
DHDCFLAGS += -DWL_DHD_DUAL_LOG
ifneq ($(CONFIG_BCMDHD),)
DHDCFLAGS += -DWL_DHD_DUAL_CHIP1
endif
ifneq ($(CONFIG_BCMDHDX),)
DRIVER_TYPE ?= $(CONFIG_BCMDHDX)
DHDCFLAGS += -DBCMDHDX -DWL_DHD_DUAL_CHIP2
endif
endif

# IFX cfg80211 support
ifeq ($(CONFIG_BCMDHD_IFX_CFG80211),y)
# For 5.4.21 kernel
DHDCFLAGS += -DIFX_CFG80211_5_4_21
endif

# Uncomment the below line for AP to receive disconnect management frame.
#DHDCFLAGS += -DWL_CFG80211_AP_RX_MGMT_DISCONNECT

# Bandsteer support
#DHDCFLAGS += -DDHD_BANDSTEER

##########################
# driver type
# m: module type driver
# y: built-in type driver
##########################
ifneq ($(CONFIG_BCMDHD),)
DRIVER_TYPE ?= $(CONFIG_BCMDHD)
endif

#############################
# Bring up WARs for CYW89570.
# To be removed later
#############################
ifneq ($(CONFIG_WIRELESS_EXT),)
DHDOFILES += wl_iw.o bcm_app_utils.o
DHDCFLAGS += -DWL_WIRELESS_EXT -DWLLXIW -DUSE_IW
endif

ifeq ($(CONFIG_TRXHDR_V3),y)
DHDCFLAGS += -DBCMTRXV3
else
DHDCFLAGS += -DBCMTRXV4
endif

#########################
# Chip dependent feature
#########################

ifeq ($(CONFIG_CYW43022),y)
DHDCFLAGS += -DDHD_43022
DHDCFLAGS += -DDHD_ULP
endif

# Perform auto phy calibration per multiple secs
DHDCFLAGS += -DSUPPORT_SET_CAL_PERIOD -DCUSTOM_CAL_PERIOD=600

DHDCFLAGS += -DENABLE_MCHAN_SBDC
DHDCFLAGS += -DUSE_WL_TXBF
DHDCFLAGS += -DCUSTOM_DPC_CPUCORE=0

# New Features
DHDCFLAGS += -DWL11U
DHDCFLAGS += -DMFP
# Disabling LPC for 89570 for now.
#DHDCFLAGS += -DDHD_ENABLE_LPC
DHDCFLAGS += -DCUSTOM_COUNTRY_CODE
DHDCFLAGS += -DNDO_CONFIG_SUPPORT
DHDCFLAGS += -DIPV6_NDO_SUPPORT
DHDCFLAGS += -DIGUANA_LEGACY_CHIPS

ifeq ($(CONFIG_BCMDHD_SDMMC),y)
DHDCFLAGS += -DBCMLXSDMMC -DCUSTOM_TXGLOM=1
DHDCFLAGS += -DBCMSDIOH_STATIC_COPY_BUF
ifeq ($(CONFIG_HAVE_IMX8_SOC),y)
DHDCFLAGS += \
	-DCONFIG_DTS \
	-DOEM_EMBEDDED_LINUX \
	-DPLATFORM_IMX
ifeq ($(CONFIG_FCIPA_CHIP),y)
DHDCFLAGS += -DFCIPA_CHIP
endif
ifeq ($(shell expr '$(CONFIG_ANDROID_VERSION)' \>= 13), 1)
DHDCFLAGS += -Wno-unused-function
endif
endif
endif

ifeq ($(CONFIG_BCMDHD_SDIOH_STD),y)
DHDCFLAGS += -DBCMSDIOH_STD
endif

ifeq ($(CONFIG_BCMDHD_SDIO),y)
DHDCFLAGS += -DBDC -DDHD_BCMEVENTS -DMMC_SDIO_ABORT
DHDCFLAGS += -DBCMSDIO -DUSE_SDIOFIFO_IOVAR
DHDCFLAGS += -DPROP_TXSTATUS -DLIMIT_BORROW
DHDCFLAGS += -DPROP_TXSTATUS_VSDB
DHDCFLAGS += -DUSE_WL_FRAMEBURST
# tput enhancement
DHDCFLAGS += -DCUSTOM_GLOM_SETTING=8
#DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=128
DHDCFLAGS += -DCUSTOM_SDIO_F2_BLKSIZE=128
DHDCFLAGS += -DBCMSDIOH_TXGLOM -DAMPDU_HOSTREORDER
DHDCFLAGS += -DDHDTCPACK_SUPPRESS
DHDCFLAGS += -DRXFRAME_THREAD
DHDCFLAGS += -DCUSTOM_MAX_TXGLOM_SIZE=40
DHDCFLAGS += -DMAX_HDR_READ=128
DHDCFLAGS += -DDHD_FIRSTREAD=64
DHDCFLAGS += -DDHD_WAKE_STATUS -DDHD_WAKE_RX_STATUS
ifeq ($(CONFIG_BCMDHD_OOB_HOST_WAKE),y)
DHDCFLAGS += -DCONFIG_BCMDHD_OOB_HOST_WAKE=$(CONFIG_BCMDHD_OOB_HOST_WAKE)
DHDCFLAGS += -DOOB_INTR_ONLY -DHW_OOB
else ifeq ($(CONFIG_BCMDHD_DPC_IN_ISR),y)
DHDCFLAGS += -DSDIO_ISR_THREAD
endif

# bcn_timeout
DHDCFLAGS += -DCUSTOM_BCN_TIMEOUT_SETTING=5

DHDCFLAGS += -DREVERSE_AIFSN

# btsharedsdio
ifeq ($(CONFIG_BT_OVER_SDIO),y)
DHDCFLAGS += -DBT_OVER_SDIO
endif
endif

# Expand TCP tx queue to 10 times of default size
DHDCFLAGS += -DTSQ_MULTIPLIER=10

ifeq ($(CONFIG_BCMDHD_PCIE),y)
DHDCFLAGS += -DPCIE_FULL_DONGLE -DBCMPCIE -DCUSTOM_DPC_PRIO_SETTING=-1
# tput enhancement
DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64
#DHDCFLAGS += -DPROP_TXSTATUS_VSDB
# HEAP ASLR
DHDCFLAGS += -DBCM_ASLR_HEAP
DHDCFLAGS += -DMAX_CNTL_TX_TIMEOUT=1
ifeq ($(CONFIG_DHD_USE_STATIC_BUF),y)
DHDCFLAGS += -DCONFIG_DHD_USE_STATIC_BUF=y
DHDCFLAGS += -DDHD_USE_STATIC_IOCTLBUF
endif
DHDCFLAGS += -DDHD_USE_COHERENT_MEM_FOR_RING
# Enable health check event handling
DHDCFLAGS += -DDNGL_EVENT_SUPPORT
DHDCFLAGS += -DHCHK_COMMON_SW_EVENT

# Enable Load Balancing support by default.
# DHD_LB_RXP - Perform RX Packet processing in parallel
# DHD_LB_TXP - Perform TX Packet processing in parallel
# DHD_LB_STATS - To display the Load Blancing statistics
DHDCFLAGS += -DDHD_LB -DDHD_LB_RXP -DDHD_LB_STATS
DHDCFLAGS += -DDHD_LB_TXP -DDHD_LB_TXP_DEFAULT_ENAB
DHDCFLAGS += -DDHD_LB_PRIMARY_CPUS=0xF0 -DDHD_LB_SECONDARY_CPUS=0x0E

# Runtime PM feature
#DHDCFLAGS += -DDHD_PCIE_RUNTIMEPM -DMAX_IDLE_COUNT=11 -DCUSTOM_DHD_RUNTIME_MS=100

# debug info
DHDCFLAGS += -DDHD_WAKE_STATUS -DDHD_WAKE_RX_STATUS

# Enable SSSR Dump
DHDCFLAGS += -DDHD_SSSR_DUMP

ifeq ($(CONFIG_BCMDHD_OOB_HOST_WAKE),y)
DHDCFLAGS += -DCONFIG_BCMDHD_OOB_HOST_WAKE=$(CONFIG_BCMDHD_OOB_HOST_WAKE)
DHDCFLAGS += -DBCMPCIE_OOB_HOST_WAKE
else ifeq ($(CONFIG_BCMDHD_DPC_IN_ISR),y)
DHDCFLAGS += -DPCIE_ISR_THREAD
endif

# Use a writeonly method to reset watchdog
DHDCFLAGS += -DCC_WD_RST_WRITEONLY
endif

# Print 802.1X packets
DHDCFLAGS += -DDHD_8021X_DUMP
# prioritize 802.1x packet
DHDCFLAGS += -DEAPOL_PKT_PRIO

# Enable MSI interrupt Support
DHDCFLAGS += -DDHD_MSI_SUPPORT

# Enabling temporarily due to build failure
DHDCFLAGS += -DDHD_PKTTS -DTX_STATUS_LATENCY_STATS

#EXTRA_LDFLAGS += --strip-debug

ifeq ($(DRIVER_TYPE),y)
#DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
# Use kernel strlcpy() implementation instead of one, defined in bcmstdlib_s.c
DHDCFLAGS += -DBCM_USE_PLATFORM_STRLCPY
endif

DHDOFILES += dhd_pno.o dhd_common.o dhd_ip.o dhd_custom_gpio.o \
	dhd_linux.o dhd_linux_sched.o dhd_cfg80211.o dhd_linux_wq.o aiutils.o \
	bcmevent.o bcmutils.o bcmwifi_channels.o hndpmu.o linux_osl.o linux_pkt.o \
	sbutils.o siutils.o wl_android.o wl_roam.o wl_cfg80211.o wl_cfgscan.o wl_cfgp2p.o \
	wl_cfg_btcoex.o wldev_common.o dhd_linux_platdev.o \
	dhd_pno.o dhd_linux_pktdump.o wl_cfg_btcoex.o hnd_pktq.o \
	hnd_pktpool.o wl_cfgvendor.o bcmxtlv.o bcm_app_utils.o dhd_debug.o \
	dhd_debug_linux.o dhd_mschdbg.o bcmbloom.o dhd_dbg_ring.o bcmstdlib_s.o \
	dhd_linux_exportfs.o wl_twt.o dhd_ulp.o

ifeq ($(CONFIG_DHD_MONITOR_INTERFACE),y)
DHDCFLAGS += -DDHD_MONITOR_INTERFACE
DHDOFILES += wl_linux_mon.o
endif

ifeq ($(CONFIG_DHD_OF_SUPPORT),y)
DHDCFLAGS += -DDHD_OF_SUPPORT
ifeq ($(CONFIG_ARCH_MESON),y)
DHDCFLAGS += -DBOARD_VIM3
DHDOFILES += dhd_custom_vim3.o
endif

ifeq ($(CONFIG_ARCH_MSM),y)
DHDOFILES += dhd_custom_msm.o
endif

ifeq ($(CONFIG_ARCH_ROCKCHIP),y)
DHDCFLAGS += -DCONFIG_DHD_PLAT_ROCKCHIP
DHDOFILES += dhd_custom_rockchip.o
endif

ifeq ($(CONFIG_ARCH_LOMBO),y)
DHDOFILES += dhd_custom_lombo.o
endif
endif

ifeq ($(CONFIG_BCMDHD_SDMMC),y)
DHDOFILES += bcmsdh_sdmmc.o bcmsdh_sdmmc_linux.o
endif

ifeq ($(CONFIG_BCMDHD_SDIO),y)
DHDOFILES += bcmsdh.o bcmsdh_linux.o
DHDOFILES += dhd_cdc.o dhd_wlfc.o dhd_sdio.o
endif

ifeq ($(CONFIG_BCMDHD_SDIOH_STD),y)
DHDOFILES += bcmsdstd.o bcmsdstd_linux.o
endif

ifeq ($(CONFIG_BCMDHD_PCIE),y)
DHDOFILES += dhd_pcie.o dhd_pcie_linux.o dhd_msgbuf.o dhd_flowring.o
DHDOFILES += pcie_core.o dhd_wlfc.o
endif

ifneq ($(filter -DDHD_LB, $(DHDCFLAGS)),)
DHDOFILES += dhd_linux_lb.o
endif
ifneq ($(filter -DDHD_BANDSTEER, $(DHDCFLAGS)),)
DHDOFILES += dhd_bandsteer.o
endif

ifneq ($(CONFIG_QT),y)
DHDCFLAGS += -DRTT_SUPPORT -DRTT_DEBUG
DHDOFILES += dhd_rtt.o
endif
EXTRA_CFLAGS += $(DHDCFLAGS) -DDHD_DEBUG
EXTRA_CFLAGS += -DSRCBASE=\"$(src)\"
EXTRA_CFLAGS += -I$(src)/include/ -I$(src)/
KBUILD_CFLAGS += -I$(KDIR)/include -I$(CURDIR)

ifneq ($(CONFIG_BCMDHD),)
bcmdhd-objs := $(DHDOFILES)
obj-$(DRIVER_TYPE) += bcmdhd.o
endif

ifneq ($(CONFIG_BCMDHDX),)
bcmdhdx-objs := $(DHDOFILES)
obj-$(DRIVER_TYPE) += bcmdhd.o bcmdhdx.o
endif

all:
	@echo "$(MAKE) --no-print-directory -C $(KDIR) M=$(CURDIR) modules"
	@$(MAKE) --no-print-directory -C $(KDIR) M=$(CURDIR) modules

clean:
	rm -rf *.o *.ko *.mod.c *~ .*.o .*.cmd *.o.cmd .*.o.cmd .*.o.d \
	*.mod *.dwo Module.symvers modules.order .tmp_versions \
	modules.builtin

install:
	@$(MAKE) --no-print-directory -C $(KDIR) \
		M=$(CURDIR) modules_install
