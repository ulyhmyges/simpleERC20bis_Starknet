## Create a ERC20 token from scratch with Cairo

### Contract
- name : SimpleERC2OContract
- path : src/core/simpleERC20.cairo

### Build project
```
scarb build
```

### Declare contract
```
starkli declare --network=sepolia --keystore=$STARKNET_KEYSTORE --account=$STARKNET_ACCOUNT target/dev/<CONTRACT>_class.json
```

### Deploy contract on Sepolia
```
starkli deploy 
--network=sepolia 
--keystore=$STARKNET_KEYSTORE 
--account=$STARKNET_ACCOUNT 
<CLASS-HASH>
50 358434828907 5461067
```

starkli deploy --network=sepolia --keystore=$STARKNET_KEYSTORE --account=$STARKNET_ACCOUNT 0x068a70f3af67db632f0b9ec4e39ba2396d92edfe2e644de862d8b8e2dcb97f97 500000 1414485071 1414485071
