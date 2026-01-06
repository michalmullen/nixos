# Global variables for the NixOS configuration
{
  # User configuration
  users = {
    primary = {
      username = "po252";
      fullName = "Mitchell Mullen";
      email = "michalmullen@gmail.com";
    };
  };

  # System configuration
  system = {
    architecture = "x86_64-linux";
    stateVersion = "25.11";
  };
}
