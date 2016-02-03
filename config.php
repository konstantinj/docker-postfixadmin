<?php
$CONF['configured'] = true;
$CONF['database_type'] = 'mysqli';
$CONF['database_host'] = getenv('MYSQL_HOST');
$CONF['database_user'] = getenv('MYSQL_USER');
$CONF['database_password'] = getenv('MYSQL_PASSWORD');
$CONF['database_name'] = getenv('MYSQL_DATABASE');
$CONF['encrypt'] = 'dovecot:SHA512-CRYPT';
$CONF['dovecotpw'] = "/usr/bin/doveadm pw";
$CONF['domain_path'] = 'YES';
$CONF['domain_in_mailbox'] = 'NO';
$CONF['fetchmail'] = 'NO';
$CONF['default_aliases'] = array (
    'abuse' => 'admin',
    'hostmaster' => 'admin',
    'postmaster' => 'admin',
    'webmaster' => 'admin'
);
$CONF['show_footer_text'] = 'NO';

foreach (glob('/config/*.php') as $f) {
  require_once $f;
}
