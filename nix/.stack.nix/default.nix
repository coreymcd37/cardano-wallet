{
  extras = hackage:
    {
      packages = {
        "OddWord" = (((hackage.OddWord)."1.0.2.0").revisions).default;
        "command" = (((hackage.command)."0.1.1").revisions).default;
        "markov-chain-usage-model" = (((hackage.markov-chain-usage-model)."0.0.0").revisions).default;
        "quickcheck-state-machine" = (((hackage.quickcheck-state-machine)."0.7.0").revisions).default;
        "hspec" = (((hackage.hspec)."2.8.2").revisions).default;
        "hspec-core" = (((hackage.hspec-core)."2.8.2").revisions).default;
        "base16-bytestring" = (((hackage.base16-bytestring)."1.0.1.0").revisions).default;
        "bech32" = (((hackage.bech32)."1.1.0").revisions).default;
        "bech32-th" = (((hackage.bech32-th)."1.0.2").revisions).default;
        "Cabal" = (((hackage.Cabal)."3.4.0.0").revisions).default;
        "parsec" = (((hackage.parsec)."3.1.14.0").revisions).default;
        "async-timer" = (((hackage.async-timer)."0.2.0.0").revisions).default;
        "Unique" = (((hackage.Unique)."0.4.7.6").revisions).default;
        "Win32" = (((hackage.Win32)."2.6.2.0").revisions).default;
        "canonical-json" = (((hackage.canonical-json)."0.6.0.0").revisions).default;
        "gray-code" = (((hackage.gray-code)."0.3.1").revisions).default;
        "ip" = (((hackage.ip)."1.5.1").revisions).default;
        "libsystemd-journal" = (((hackage.libsystemd-journal)."1.4.4").revisions).default;
        "micro-recursion-schemes" = (((hackage.micro-recursion-schemes)."5.0.2.2").revisions).default;
        "moo" = (((hackage.moo)."1.2").revisions).default;
        "nothunks" = (((hackage.nothunks)."0.1.2").revisions).default;
        "partial-order" = (((hackage.partial-order)."0.2.0.0").revisions).default;
        "regex-posix-clib" = (((hackage.regex-posix-clib)."2.7").revisions).default;
        "statistics-linreg" = (((hackage.statistics-linreg)."0.3").revisions).default;
        "streaming-binary" = (((hackage.streaming-binary)."0.2.2.0").revisions).default;
        "transformers-except" = (((hackage.transformers-except)."0.1.1").revisions).default;
        "Stream" = (((hackage.Stream)."0.4.7.2").revisions)."ed78165aa34c4e23dc53c9072f8715d414a585037f2145ea0eb2b38300354c53";
        "composition-prelude" = (((hackage.composition-prelude)."3.0.0.2").revisions)."1ffed216bd28d810fce0b5be83a661e2a892696d73b3f8de5c0f5edb9b5f0090";
        "dependent-map" = (((hackage.dependent-map)."0.4.0.0").revisions)."ca2b131046f4340a1c35d138c5a003fe4a5be96b14efc26291ed35fd08c62221";
        "dependent-sum" = (((hackage.dependent-sum)."0.6.2.0").revisions)."bff37c85b38e768b942f9d81c2465b63a96076f1ba006e35612aa357770807b6";
        "dependent-sum-template" = (((hackage.dependent-sum-template)."0.1.0.3").revisions)."0bbbacdfbd3abf2a15aaf0cf2c27e5bdd159b519441fec39e1e6f2f54424adde";
        "lazy-search" = (((hackage.lazy-search)."0.1.2.1").revisions)."c942a01e4a64881f89c72eaef5e3a78eba8750759cd66996c6746a2a7cabe703";
        "monoidal-containers" = (((hackage.monoidal-containers)."0.6.0.1").revisions)."f56ea8fe91ff93da140e38b8dab4b94437b901818c13ba72fc7fc802290323ee";
        "size-based" = (((hackage.size-based)."0.1.2.0").revisions)."1b33da89d270189661dbbda49a88b0c21d2fc2f7a407e7a2b1933e2faf0f5d4d";
        "witherable" = (((hackage.witherable)."0.4.1").revisions)."5b4840efe20d16cab6b13fa2f39ed383703cccbc246f5b710591069fcc6884c0";
        "constraints-extras" = (((hackage.constraints-extras)."0.3.1.0").revisions)."c70fcf437e1d640cfd50a8eda1db47a64e49c96857e08fd0d8c438327d908ac1";
        "indexed-traversable-instances" = (((hackage.indexed-traversable-instances)."0.1").revisions)."3aaf97040001bbe583e29c2b9c7d41660df265e6565a0d2ac09a3ed5b8bc21be";
        "lazysmallcheck" = (((hackage.lazysmallcheck)."0.6").revisions)."dac7a1e4877681f1260309e863e896674dd6efc1159897b7945893e693f2a6bc";
        cardano-wallet-core = ./cardano-wallet-core.nix;
        cardano-wallet-core-integration = ./cardano-wallet-core-integration.nix;
        cardano-wallet-cli = ./cardano-wallet-cli.nix;
        cardano-wallet-launcher = ./cardano-wallet-launcher.nix;
        cardano-numeric = ./cardano-numeric.nix;
        text-class = ./text-class.nix;
        cardano-wallet-test-utils = ./cardano-wallet-test-utils.nix;
        cardano-wallet = ./cardano-wallet.nix;
        strict-non-empty-containers = ./strict-non-empty-containers.nix;
        cardano-addresses-cli = ./cardano-addresses-cli.nix;
        cardano-addresses = ./cardano-addresses.nix;
        cardano-binary = ./cardano-binary.nix;
        cardano-binary-test = ./cardano-binary-test.nix;
        cardano-crypto-class = ./cardano-crypto-class.nix;
        cardano-crypto-praos = ./cardano-crypto-praos.nix;
        cardano-crypto-tests = ./cardano-crypto-tests.nix;
        cardano-slotting = ./cardano-slotting.nix;
        strict-containers = ./strict-containers.nix;
        cardano-crypto = ./cardano-crypto.nix;
        byron-spec-chain = ./byron-spec-chain.nix;
        cardano-crypto-wrapper = ./cardano-crypto-wrapper.nix;
        cardano-crypto-test = ./cardano-crypto-test.nix;
        byron-spec-ledger = ./byron-spec-ledger.nix;
        cardano-ledger-byron = ./cardano-ledger-byron.nix;
        cardano-ledger-byron-test = ./cardano-ledger-byron-test.nix;
        cardano-ledger-core = ./cardano-ledger-core.nix;
        small-steps = ./small-steps.nix;
        small-steps-test = ./small-steps-test.nix;
        shelley-spec-non-integral = ./shelley-spec-non-integral.nix;
        shelley-spec-ledger = ./shelley-spec-ledger.nix;
        shelley-spec-ledger-test = ./shelley-spec-ledger-test.nix;
        cardano-ledger-shelley-ma = ./cardano-ledger-shelley-ma.nix;
        cardano-ledger-alonzo = ./cardano-ledger-alonzo.nix;
        cardano-ledger-shelley-ma-test = ./cardano-ledger-shelley-ma-test.nix;
        cardano-api = ./cardano-api.nix;
        cardano-cli = ./cardano-cli.nix;
        cardano-config = ./cardano-config.nix;
        cardano-node = ./cardano-node.nix;
        cardano-node-chairman = ./cardano-node-chairman.nix;
        cardano-prelude = ./cardano-prelude.nix;
        cardano-prelude-test = ./cardano-prelude-test.nix;
        cardano-sl-x509 = ./cardano-sl-x509.nix;
        goblins = ./goblins.nix;
        contra-tracer = ./contra-tracer.nix;
        iohk-monitoring = ./iohk-monitoring.nix;
        lobemo-backend-aggregation = ./lobemo-backend-aggregation.nix;
        lobemo-backend-ekg = ./lobemo-backend-ekg.nix;
        lobemo-backend-monitoring = ./lobemo-backend-monitoring.nix;
        lobemo-backend-trace-forwarder = ./lobemo-backend-trace-forwarder.nix;
        lobemo-scribe-systemd = ./lobemo-scribe-systemd.nix;
        tracer-transformers = ./tracer-transformers.nix;
        plutus-core = ./plutus-core.nix;
        plutus-ledger-api = ./plutus-ledger-api.nix;
        plutus-tx = ./plutus-tx.nix;
        prettyprinter-configurable = ./prettyprinter-configurable.nix;
        io-sim = ./io-sim.nix;
        io-sim-classes = ./io-sim-classes.nix;
        network-mux = ./network-mux.nix;
        ouroboros-consensus = ./ouroboros-consensus.nix;
        monoidal-synchronisation = ./monoidal-synchronisation.nix;
        ouroboros-consensus-byron = ./ouroboros-consensus-byron.nix;
        ouroboros-consensus-cardano = ./ouroboros-consensus-cardano.nix;
        ouroboros-consensus-shelley = ./ouroboros-consensus-shelley.nix;
        ouroboros-network = ./ouroboros-network.nix;
        ouroboros-network-framework = ./ouroboros-network-framework.nix;
        ouroboros-network-testing = ./ouroboros-network-testing.nix;
        typed-protocols = ./typed-protocols.nix;
        typed-protocols-examples = ./typed-protocols-examples.nix;
        cardano-client = ./cardano-client.nix;
        ntp-client = ./ntp-client.nix;
        ouroboros-consensus-mock = ./ouroboros-consensus-mock.nix;
        Win32-network = ./Win32-network.nix;
        http-client = ./http-client.nix;
        };
      };
  resolver = "lts-17.9";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "cardano-crypto-praos" = {
            flags = { "external-libsodium-vrf" = lib.mkOverride 900 false; };
            };
          "cryptonite" = {
            flags = { "support_rdrand" = lib.mkOverride 900 false; };
            };
          "zip" = { flags = { "disable-bzip2" = lib.mkOverride 900 true; }; };
          };
        })
    { packages = {}; }
    ];
  }