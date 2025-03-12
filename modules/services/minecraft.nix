{
  services.minecraft-server = {
    enable = true;
    eula = true; # set to true if you agree to Mojang's EULA: https://account.mojang.com/documents/minecraft_eula
    declarative = true;

    # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
    serverProperties = {
      server-port = 25565;
      gamemode = "survival";
      motd = "NixOS Minecraft server on Tailscale!";
      max-players = 8;
      enable-rcon = true;
      # This password can be used to administer your minecraft server.
      # Exact details as to how will be explained later. If you want
      # you can replace this with another password.
      "rcon.password" = "hunter2";
      level-seed = "10292992";
    };
  };
}
