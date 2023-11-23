{ lib
, llvmPackages
, gnumake
, xorg
}:

llvmPackages.stdenv.mkDerivation rec {
  pname = "stc";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ gnumake ];

  buildInputs = [
    xorg.libX11
    xorg.libXft
  ];

  installPhase = ''                                                                               
    mkdir -p $out/bin
    cp stc $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/fxttr/stc";
    description = ''
      A simple terminal";
    '';
    licencse = licenses.mit;
    platforms = with platforms; linux;
    maintainers = [ maintainers.fxttr ];
  };
}
