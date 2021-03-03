# System Utilities
Bash scripts utilities for others services

## Use

### Jump Scripts

These script are use to manage users in a jump SSH instance or MV, to create or remove normal users.

- **user-add.sh**: to create a new user, generate its pair key SSH and send a mail with this key.
- **user-del.sh**: to delete a user. Before delete the account, if exists an open SSH connection, then kill it and delete then the user.

*Note: Both scripts are for run with root privileges and in an instance or MV.*
