#[starknet::interface]
pub trait ISimpleERC20Contract<TContractState> {
    fn balanceOf(self: @TContractState, account: starknet::ContractAddress ) -> u128;
    fn transfer(ref self: TContractState, recipient: starknet::ContractAddress, amount: u128);
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn totalSupply(self: @TContractState) -> u128;
}
