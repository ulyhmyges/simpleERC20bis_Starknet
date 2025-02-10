
#[starknet::contract]
mod SimpleERC20Contract {

    
use starknet::storage::StoragePointerReadAccess;
use starknet::storage::StoragePointerWriteAccess;
use starknet::storage::Map;
use starknet::storage::StoragePathEntry;
use core::starknet::get_caller_address;
use core::starknet::contract_address::ContractAddress;


    #[storage]
    struct Storage {
        name: felt252,
        symbol: felt252,
        totalSupply: u128,
        balance: Map::<ContractAddress, u128>,
        owner: ContractAddress
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        Transfer: Transfer,
    }

    #[derive(Drop, starknet::Event)]
    pub struct Transfer {
        #[key]
        from: ContractAddress,
        to: ContractAddress,
        amount: u128
    }

    #[constructor]
    fn constructor(ref self: ContractState, totalSupply: u128, name: felt252, symbol: felt252) {
        self.totalSupply.write(totalSupply);
        self.name.write(name);
        self.symbol.write(symbol);
        let caller = get_caller_address();
        self.owner.write(caller);
        self.balance.entry(caller).write(totalSupply);
    }

    #[abi(embed_v0)]
    impl SimpleERC20ContractImpl of erc20bis::interface::simpleERC20::ISimpleERC20Contract<ContractState> {
        fn balanceOf(self: @ContractState, account: ContractAddress ) -> u128 {
            self.balance.entry(account).read()
        }

        fn transfer(ref self: ContractState, recipient: ContractAddress, amount: u128) {
            let caller = get_caller_address();
            let funds = self.balance.entry(caller).read();
            assert(amount != 0, 'Need some funds');
            assert(funds >= amount, 'Not enough funds');
            self.balance.entry(caller).write(funds - amount);
            let funds_recipient = self.balance.entry(recipient).read();
            self.balance.entry(recipient).write(funds_recipient + amount);
            self.emit(Transfer{from: caller, to: recipient, amount: amount});
        }

        fn name(self: @ContractState) -> felt252 {
            self.name.read()
        }

        fn symbol(self: @ContractState) -> felt252 {
            self.symbol.read()
        }

        fn totalSupply(self: @ContractState) -> u128 {
            self.totalSupply.read()
        }

        fn owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
    }
}
