require "formula"

class Androidscripts < Formula

  homepage 'https://github.com/dhelleberg/android-scripts'
  url 'https://github.com/dhelleberg/android-scripts/archive/1.0.4.tar.gz'
  sha256 'fd6b541c647c3fce103d7844e62e7161a769cd4900fe449c5ce74d7a5354dcb1'
  head 'https://github.com/dhelleberg/android-scripts.git'

  def install
    bin.install 'upload.sh' => 'kae-android'
  end
end