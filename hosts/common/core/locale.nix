{ lib, configVars, ... }:
let
  defaultLocale = configVars.defaultLocale;
  defaultTimeZone = configVars.defaultTimeZone;
in
{
  i18n.defaultLocale = lib.mkDefault defaultLocale;
  time.timeZone = lib.mkDefault defaultTimeZone;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = defaultLocale;
    LC_IDENTIFICATION = defaultLocale;
    LC_MEASUREMENT = defaultLocale;
    LC_MONETARY = defaultLocale;
    LC_NAME = defaultLocale;
    LC_NUMERIC = defaultLocale;
    LC_PAPER = defaultLocale;
    LC_TELEPHONE = defaultLocale;
    LC_TIME = defaultLocale;
  };
}
