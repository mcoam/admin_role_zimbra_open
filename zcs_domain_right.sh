#!/bin/bash
# $1 domain
# $2 email
zmprov="/opt/zimbra/bin/zmprov"
file="/var/tmp/zcs_config_value"
log="/var/tmp/zcs_config_value.log"

echo -e ""
echo -e "Setting admin account ($2) ...."
echo -e ""

cat <<EOF > $file

 ma $2 zimbraIsDelegatedAdminAccount TRUE 
 ma $2 zimbraAdminConsoleUIComponents cartBlancheUI zimbraAdminConsoleUIComponents domainListView zimbraAdminConsoleUIComponents accountListView zimbraAdminConsoleUIComponents DLListView
 ma $2 zimbraDomainAdminMaxMailQuota 0 
 grantRight domain $1 usr $2 +createAccount 
 grantRight domain $1 usr $2 +createAlias 
 grantRight domain $1 usr $2 +createCalendarResource
 grantRight domain $1 usr $2 +createDistributionList
 grantRight domain $1 usr $2 +deleteAlias
 grantRight domain $1 usr $2 +listDomain
 grantRight domain $1 usr $2 +domainAdminRights 
 grantRight domain $1 usr $2 +configureQuota 
 grantRight domain $1 usr $2 set.account.zimbraAccountStatus 
 grantRight domain $1 usr $2 set.account.sn 
 grantRight domain $1 usr $2 set.account.displayName 
 grantRight domain $1 usr $2 set.account.zimbraPasswordMustChange 
 grantRight domain $1 usr $2 getDomainQuotaUsage 
 grantRight account $2 usr $2 +deleteAccount 
 grantRight account $2 usr $2 +getAccountInfo
 grantRight account $2 usr $2 +getAccountMembership 
 grantRight account $2 usr $2 +getMailboxInfo 
 grantRight account $2 usr $2 +listAccount 
 grantRight account $2 usr $2 +removeAccountAlias 
 grantRight account $2 usr $2 +renameAccount 
 grantRight account $2 usr $2 +setAccountPassword 
 grantRight account $2 usr $2 +viewAccountAdminUI 
 grantRight account $2 usr $2 +configureQuota
EOF

$zmprov < $file 1> /dev/null

echo -e ""
echo -e "The new admin account ($2) is ready"
echo -e ""
