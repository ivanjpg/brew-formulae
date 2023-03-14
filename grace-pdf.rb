class GracePdf < Formula
  desc "WYSIWYG 2D plotting tool for X11 (with PDFLibLite 7)"
  homepage "https://plasma-gate.weizmann.ac.il/Grace/"
  url "https://deb.debian.org/debian/pool/main/g/grace/grace_5.1.25.orig.tar.gz"
  sha256 "751ab9917ed0f6232073c193aba74046037e185d73b77bab0f5af3e3ff1da2ac"
  license "GPL-2.0-only"

  # depends_on "cmake" => :build

  conflicts_with "grace"

  depends_on "fftw"
  depends_on "jpeg-turbo"
  depends_on "libice"
  depends_on "libpng"
  depends_on "libsm"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxmu"
  depends_on "libxp"
  depends_on "libxpm"
  depends_on "libxt"
  depends_on "openmotif"
  depends_on "pdflib-lite"

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    system "./configure", *std_configure_args,
                          "--enable-grace-home=#{prefix}",
        "--with-extra-incpath=/usr/local/Cellar/pdflib-lite/7.0.5p3/include:/usr/local/Cellar/openmotif/2.3.8_2/include",
        "--with-extra-ldpath=/usr/local/Cellar/pdflib-lite/7.0.5p3/lib:/usr/local/Cellar/openmotif/2.3.8_2/lib"
    system "make", "install"
    share.install "fonts", "examples"
    man1.install Dir["doc/*.1"]
    doc.install Dir["doc/*"]
  end

  test do
    system bin/"gracebat", share/"examples/test.dat"
    assert_equal "12/31/1999 23:59:59.999",
                 shell_output("#{bin}/convcal -i iso -o us 1999-12-31T23:59:59.999").chomp
  end
end
