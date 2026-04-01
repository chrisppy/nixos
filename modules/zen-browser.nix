_: {
  flake.modules.homeManager.gui = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.zen-browser.homeModules.beta];

    programs.zen-browser = {
      enable = true;
      package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles."default" = let
        containers = {
          Personal = {
            color = "green";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 2;
          };
        };
      in {
        containersForce = true;
        inherit containers;
        spacesForce = true;
        spaces = {
          "Space" = {
            id = "c6de089c-410d-4206-961d-ab11f988d40a";
            position = 1000;
          };
          "Work" = {
            id = "cdd10fab-4fc5-494b-9041-325e5759195b";
            container = containers."Work".id;
            position = 2000;
          };
        };
      };
    };
  };
}
