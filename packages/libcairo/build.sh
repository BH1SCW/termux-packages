TERMUX_PKG_HOMEPAGE=https://cairographics.org
TERMUX_PKG_DESCRIPTION="Cairo 2D vector graphics library"
TERMUX_PKG_VERSION=1.14.8
TERMUX_PKG_SRCURL=https://cairographics.org/releases/cairo-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d1f2d98ae9a4111564f6de4e013d639cf77155baf2556582295a0f00a9bc5e20
TERMUX_PKG_DEPENDS="libandroid-support, libpixman, fontconfig, freetype, libandroid-shmem"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk-doc-html --enable-xlib=yes"
TERMUX_PKG_RM_AFTER_INSTALL="share/gtk-doc/html"

termux_step_pre_configure () {
	LDFLAGS="$LDFLAGS -landroid-shmem"
}
