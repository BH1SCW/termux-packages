TERMUX_PKG_HOMEPAGE=https://www.imagemagick.org/
TERMUX_PKG_DESCRIPTION="Suite to create, edit, compose, or convert images in a variety of formats"
TERMUX_PKG_VERSION="7.0.5-6"
TERMUX_PKG_SRCURL=https://dl.bintray.com/termux/upstream/ImageMagick-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f60c3e3466ccbf9a0e643284ffec3467363edf9611f16a98387f927a974b49ab
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-largefile
--without-x
--without-gvc
--without-ltdl
--with-magick-plus-plus=no
--with-bzlib=no
--with-xml=yes
--with-lzma
ac_cv_func_ftime=no
ac_cv_header_complex_h=no"
TERMUX_PKG_RM_AFTER_INSTALL="bin/Magick-config bin/MagickCore-config bin/MagickWand-config bin/Wand-config share/ImageMagick-6/francais.xml share/man/man1/Magick-config.1 share/man/man1/MagickCore-config.1 share/man/man1/MagickWand-config.1 share/man/man1/Wand-config.1"
TERMUX_PKG_DEPENDS="fftw, pango, glib, libbz2, libjpeg-turbo, liblzma, libpng, libtiff, libxml2, openjpeg, littlecms"
