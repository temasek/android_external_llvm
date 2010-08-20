LOCAL_PATH:= $(call my-dir)

# For the host
# =====================================================
include $(CLEAR_VARS)

LOCAL_SRC_FILES :=      \
     EdgeProfiling.cpp   \
     ProfilingUtils.cpp      \
     OptimalEdgeProfiling.cpp

LOCAL_MODULE:= libLLVMInstrumentation

include $(LLVM_HOST_BUILD_MK)
include $(BUILD_HOST_STATIC_LIBRARY)
