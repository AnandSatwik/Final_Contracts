
module my_addrx::Bal
{
    use 0x1::coin;
    use 0x1::aptos_coin::AptosCoin; 
    use 0x1::aptos_account;
    use 0x1::vector;
    use 0x1::signer;
    use std::debug::print;

    struct Balance has key{
        satwik:u64
    }
    const E_NOT_ENOUGH_COINS:u64 = 101;

    public entry fun check_bal(from: &signer) acquires Balance
    {
        
        let from_acc_balance:u64 = coin::balance<AptosCoin>(signer::address_of(from));
        let signer_address = signer::address_of(from);
        
        if(!exists<Balance>(signer_address))  //If the resource does not exits corresponding to a given address
        {
            let message = Balance {
                satwik : from_acc_balance         //first create a resouce
            };
            move_to(from,message);        //move that resouce to the account
        }

        else                                 //If the resource exits corresponding to a given address
        {
            let message = borrow_global_mut<Balance>(signer_address); //get the resouce 
            message.satwik=from_acc_balance;                                   //update the resouce
        }

        
    }

    
}