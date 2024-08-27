{
  description = "A collection of flake templates";

  outputs = { self }: {

    python-fhs = {
      path = ./python-fhs;
      description = "Python template using micromamba via fhs";
      welcomeText = '' '';
    };

  };
}
