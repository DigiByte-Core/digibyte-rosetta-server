/* DigiByte Networks Params */

const livenet = {
  messagePrefix: '\x19DigiByte Signed Message:\n',
  bech32: 'dgb',
  bip32: {
    public: 0x0488b21e,
    private: 0x0488ade4,
  },
  pubKeyHash: 0x1e,
  scriptHash: 0x3f,
  wif: 0x80,

  // name: 'dgb_livenet',
  // alias: 'dgb_mainnet',
  // bech32prefix: 'dgb',
  // pubkeyhash: 0x1e,
  // privatekey: 0x80,
  // privatekeyOld: 0x9e,
  // scripthash: 0x3f,
  // scripthashTwo: 0x05,
  // xpubkey: 0x0488b21e,
  // xprivkey: 0x0488ade4,
  // networkMagic: 0xfac3b6da,
  // port: 12024,
  // dnsSeeds: [
  //   'seed.digibyte.co',
  //   'seed.digibyte.io',
  //   'digiexplorer.info',
  // ],
};

const testnet = {
  messagePrefix: '\x19DigiByte Signed Message:\n',
  bech32: 'dgbt',
  bip32: {
    public: 0x043587cf,
    private: 0x04358394,
  },
  pubKeyHash: 0x7e,
  scriptHash: 0x8c,
  wif: 0xfe,
};

const regtest = {
  messagePrefix: '\x19DigiByte Signed Message:\n',
  bech32: 'dgbrt',
  bip32: {
    public: 0x043587cf,
    private: 0x04358394,
  },
  pubKeyHash: 0x7e,
  scriptHash: 0x8c,
  wif: 0xfe,
};

module.exports = {
  livenet,
  testnet,
  regtest,
};
