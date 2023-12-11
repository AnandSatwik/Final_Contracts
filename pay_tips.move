
module my_addrx::MultiSender
{
    use 0x1::coin;
    use 0x1::aptos_coin::AptosCoin; 
    use 0x1::aptos_account;
    use 0x1::vector;
    use 0x1::signer;

    const E_NOT_ENOUGH_COINS:u64 = 101;

    public entry fun ms_trans(from: &signer,to: address, amount:u64)  
    {
        
        let from_acc_balance:u64 = coin::balance<AptosCoin>(signer::address_of(from));

        assert!( amount <= from_acc_balance, E_NOT_ENOUGH_COINS);

        aptos_account::transfer(from,to,amount); 
    
    }
}