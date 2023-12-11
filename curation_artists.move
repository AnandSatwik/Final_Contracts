module my_addrx::Publish {
	use std::vector;
    use std::debug;
    use 0x1::signer;
	use std::string::{String,utf8};

	struct Artist_list has key,drop {
		list_of_users: vector<Artist>    //storing the list of the users
	}
	

	struct Artist has store,drop,copy {
		name:String,                   //information required for a typical user
	}

        //creating a user by adding the user to the existing list and returning the user
	public fun create_user(acc:&signer, new_name:String, wallet:address) acquires Artist_list{
        let addr = signer::address_of(acc);

        let new_user = Artist{
            name : new_name,
            wallet_address: wallet
        };
        
        if(!exists<Users>(addr))
            move_to(acc, Users{list_of_users : (vector[new_user])});
        else if(exists<Users>(addr))
            vector::push_back(&mut borrow_global_mut<Users>(addr).list_of_users,new_user);

		return new_user
	}
	
	#[test(admin = @my_addrx)]
	fun test_create_friend(admin: signer)acquires Users{
        let new_name: String = utf8(b"tarun");

		let createdUser = create_user(&admin,new_name,my_addrx);
        //debug::print(&users);
        assert!(createdUser.name == utf8(b"tarun"),0);
	}
}