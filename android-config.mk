#
# These flags represent the build-time configuration of OpenSSL for android
#
# The value of $(openssl_cflags) was pruned from the Makefile generated
# by running ./Configure from import_openssl.sh.
#
# This script performs minor but required patching for the Android build.
#

# Intentionally excluded http://b/7079965
ifneq (,$(filter -DZLIB, $(openssl_cflags)))
$(error ZLIB should not be enabled in openssl configuration)
endif

LOCAL_CFLAGS += $(openssl_cflags)

LOCAL_CFLAGS := $(filter-out -DTERMIO, $(LOCAL_CFLAGS))

ifeq ($(HOST_OS),windows)
LOCAL_CFLAGS := $(filter-out -DDSO_DLFCN -DHAVE_DLFCN_H,$(LOCAL_CFLAGS))
endif

# Directories
LOCAL_CFLAGS += \
  -DOPENSSLDIR="\"/system/lib/ssl\"" \
  -DENGINESDIR="\"/system/lib/ssl/engines\""

# Debug
# LOCAL_CFLAGS += -DCIPHER_DEBUG

# Add clang here when it works on host
# LOCAL_CLANG := true
