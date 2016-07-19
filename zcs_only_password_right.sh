[zimbra@mail bin]$ cat zcs_domain_right.sh
#!/bin/bash
# $1 domain
# $2 email
zmprov="/opt/zimbra/bin/zmprov"
file="/var/tmp/zcs_config_value"

echo -e "Setting admin account ($2) ...."

cat <<EOF > $file
 ma $2 zimbraIsDelegatedAdminAccount TRUE
 grantRight account $2 usr $2 +listAccount
 grantRight account $2 usr $2 +setAccountPassword
 grantRight domain $1 usr $2 +domainAdminRights
 grantRight domain $1 usr $2 -set.account.zimbraAccountStatus
 grantRight domain $1 usr $2 -set.account.sn
 grantRight domain $1 usr $2 -set.account.displayName
 grantRight domain $1 usr $2 -set.account.zimbraPasswordMustChange
 grantRight domain $1 usr $2 -set.account.initials
 grantRight domain $1 usr $2 -set.account.givenName
 grantRight domain $1 usr $2 -set.account.zimbraNotes
 grantRight domain $1 usr $2 -set.account.cn
 grantRight domain $1 usr $2 -set.account.mail
 grantRight domain $1 usr $2 -set.account.zimbraCOSId
 grantRight domain $1 usr $2 -set.account.zimbraHideInGal
 grantRight domain $1 usr $2 -renameAccount
 grantRight domain $1 usr $2 -deleteAccount
EOF

$zmprov < $file 1> /dev/null
rm -rf $file

echo -e "The new admin account ($2) is ready"

# grantRight domain $1 usr $2 -domainAdminRights
