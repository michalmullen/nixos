{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
      direnv_auto = 1;
      direnv_silent_load = 0;
    };
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    };
    plugins = {
      trouble.enable = true;
      web-devicons.enable = true;
      bufferline.enable = true;
      nvim-tree = {
        enable = true;
        openOnSetupFile = true;
        settings.auto_reload_on_write = true;
      };
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          trouble = true;
        };
      };
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context = {
        enable = true;
        settings = { max_lines = 2; };
      };
      rainbow-delimiters.enable = true;
      lazygit = {
        enable = true;
      };
      telescope = {
        enable = true;
        extensions.fzf-native = { enable = true; };
      };
    };
    keymaps = [
      # telescope
      {
        action = "<cmd>FZF<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
      }
    ];
  };
}
