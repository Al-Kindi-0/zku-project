

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom"
include "../node_modules/circomlib/circuits/mimcsponge.circom"



template hashCharacter() {
    signal private input attribute[3];
    signal private input hashKey;
    signal output out;

    component mimc = MiMCSponge(4, 220, 1);
    mimc.ins[0] <== attribute[0];
    mimc.ins[1] <== attribute[1];
    mimc.ins[2] <== attribute[2];
    mimc.ins[3] <== hashKey;

    mimc.k <== 0;

    out <== mimc.outs[0];
}

// mint NFT. Users enter three attributes (private) along with a randomly generated private key
// to prevent spam attacks, which are stored locally in the browser. 
// A hash of the NFT is created along with a ZK proof to show that the three attributes satisfy
// a certain criteria.
template mint(MAX_VAL) {
    signal private input attribute1;
    signal private input attribute2;
    signal private input attribute3;
    signal private input hashKey;

    signal output out;   


    component l1 = LessEqThan(32);
    l1.in[0] <== attribute1 + attribute2 + attribute3;
    l1.in[1] <== MAX_VAL;

    l1.out === 1;

    component cHash = hashCharacter();
    cHash.attribute[0] <== attribute1;
    cHash.attribute[1] <== attribute2;
    cHash.attribute[2] <== attribute3;
    cHash.hashKey <== hashKey;

    out <== cHash.out;
}

component main = mint(10);