const hre = require('hardhat')

async function main() {
  await hre.run('verify:verify', {
    address: '0xD7AB433b47c06C22c8B8E1cD04aa23930C12CDF5',
    constructorArguments: [],
  })
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })