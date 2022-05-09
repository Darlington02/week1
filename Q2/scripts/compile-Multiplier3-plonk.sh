#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom using PLONK below

cd contracts/circuits

mkdir Multiplier3WithPlonk

echo "Compiling Multiplier3.circom..."

circom Multiplier3.circom --r1cs --wasm --sym -o Multiplier3WithPlonk
snarkjs r1cs info Multiplier3WithPlonk/Multiplier3.r1cs

snarkjs plonk setup Multiplier3WithPlonk/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau Multiplier3WithPlonk/circuit_final.zkey
# snarkjs zkey contribute Multiplier3/circuit_0000.zkey Multiplier3/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey Multiplier3WithPlonk/circuit_final.zkey Multiplier3WithPlonk/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier Multiplier3WithPlonk/circuit_final.zkey ../Multiplier3Verifier.sol

cd ../..