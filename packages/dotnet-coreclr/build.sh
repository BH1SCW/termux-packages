TERMUX_PKG_HOMEPAGE=https://www.microsoft.com/net/core
TERMUX_PKG_VERSION=2.1.0
TERMUX_PKG_DESCRIPTION=".NET Core runtime, called CoreCLR, and the base library, called mscorlib"
TERMUX_PKG_SRCURL=https://github.com/dotnet/coreclr/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=69622283a65536257657b687c305ed35b6cb6d97f9a9965fb65eaa65623d6475
TERMUX_PKG_FOLDERNAME=coreclr-$TERMUX_PKG_VERSION
TERMUX_PKG_DEPENDS="libunwind, libuuid, libicu, libandroid-glob"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCLR_CMAKE_PLATFORM_ANDROID=Android
-DCMAKE_BUILD_TYPE=Release
-DENABLE_LLDBPLUGIN=OFF
-DREQUIRE_LLDBPLUGIN=OFF
-DFEATURE_EVENT_TRACE=OFF
-DFILE_OPS_CHECK_FERROR_OF_PREVIOUS_CALL_EXITCODE=1
-DGETPWUID_R_SETS_ERRNO_EXITCODE=1
-DHAS_POSIX_SEMAPHORES_EXITCODE=0
-DHAVE_CLOCK_MONOTONIC_COARSE_EXITCODE=0
-DHAVE_CLOCK_MONOTONIC_EXITCODE=0
-DHAVE_COMPATIBLE_ACOS_EXITCODE=0
-DHAVE_COMPATIBLE_ASIN_EXITCODE=0
-DHAVE_COMPATIBLE_ATAN2_EXITCODE=0
-DHAVE_COMPATIBLE_EXP_EXITCODE=1
-DHAVE_COMPATIBLE_LOG10_EXITCODE=0
-DHAVE_COMPATIBLE_LOG_EXITCODE=0
-DHAVE_COMPATIBLE_POW_EXITCODE=0
-DHAVE_LARGE_SNPRINTF_SUPPORT_EXITCODE=0
-DHAVE_MMAP_DEV_ZERO_EXITCODE=0
-DHAVE_PROCFS_CTL_EXITCODE=1
-DHAVE_PROCFS_MAPS_EXITCODE=0
-DHAVE_PROCFS_STATUS_EXITCODE=0
-DHAVE_PROCFS_STAT_EXITCODE=0
-DHAVE_SCHED_GETCPU_EXITCODE=0
-DHAVE_SCHED_GET_PRIORITY_EXITCODE=0
-DHAVE_VALID_NEGATIVE_INF_POW_EXITCODE=0
-DHAVE_VALID_POSITIVE_INF_POW_EXITCODE=0
-DHAVE_WORKING_CLOCK_GETTIME_EXITCODE=0
-DHAVE_WORKING_GETTIMEOFDAY_EXITCODE=0
-DONE_SHARED_MAPPING_PER_FILEREGION_PER_PROCESS_EXITCODE=1
-DPTHREAD_CREATE_MODIFIES_ERRNO_EXITCODE=1
-DREALPATH_SUPPORTS_NONEXISTENT_FILES_EXITCODE=1
-DSEM_INIT_MODIFIES_ERRNO_EXITCODE=1
-DSSCANF_CANNOT_HANDLE_MISSING_EXPONENT_EXITCODE=1
-DSSCANF_SUPPORT_ll_EXITCODE=0
-DUNGETC_NOT_RETURN_EOF_EXITCODE=1
-DHAVE_CLOCK_THREAD_CPUTIME_EXITCODE=0
-DCLR_CMAKE_WARNINGS_ARE_ERRORS=OFF
-DCLR_CMAKE_PLATFORM_UNIX=1
-DCLR_CMAKE_PLATFORM_LINUX=1
-DHAVE_PT_REGS=0
"

termux_step_pre_configure () {
	case "$TERMUX_ARCH" in
		arm) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLR_CMAKE_PLATFORM_UNIX_ARM=1 -DCLR_CMAKE_TARGET_ARCH=arm";;
		aarch64) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLR_CMAKE_PLATFORM_UNIX_ARM64=1 -DCLR_CMAKE_TARGET_ARCH=arm64";;
		i686) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLR_CMAKE_PLATFORM_UNIX_X86=1 -DCLR_CMAKE_TARGET_ARCH=x86";;
		x86_64) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLR_CMAKE_PLATFORM_UNIX_AMD64=1 -DCLR_CMAKE_TARGET_ARCH=x64";;
	esac

	echo "static char sccsid[] __attribute__((used)) = \"@(#)No version information produced\";" > $TERMUX_PKG_SRCDIR/version.cpp

	LDFLAGS+=" -landroid-glob -llog"
	CFLAGS+=" -fintegrated-as"
	CXXFLAGS+=" -std=c++11 -I$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x/ -I$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x/$TERMUX_HOST_PLATFORM -fintegrated-as"
}

termux_step_post_configure () {
	python -B "$TERMUX_PKG_SRCDIR/src/scripts/genEventing.py" --inc $TERMUX_PKG_BUILDDIR/src/inc --dummy $TERMUX_PKG_BUILDDIR/src/inc/etmdummy.h --man "$TERMUX_PKG_SRCDIR/src/vm/ClrEtwAll.man" --testdir "$TERMUX_PKG_BUILDDIR/eventing/eventprovider/tests"
}
