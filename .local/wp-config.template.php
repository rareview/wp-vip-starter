<?php

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', 'wordpress' );
define( 'DB_HOST', 'database' );

define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$table_prefix = 'wp_';

$memcached_servers = array (
  'default' =>
  array (
    0 => 'memcached:11211',
  ),
);

if ( ! defined( 'WP_DEBUG' ) ) {
    define( 'WP_DEBUG', true );
}

if ( ! defined( 'WP_DEBUG_LOG' ) ) {
    define( 'WP_DEBUG_LOG', '/wp/log/debug.log' );
}

if ( ! defined( 'WP_DEBUG_DISPLAY' ) ) {
	define( 'WP_DEBUG_DISPLAY', true );
}

if ( ! defined( 'JETPACK_DEV_DEBUG' ) ) {
	define( 'JETPACK_DEV_DEBUG', true );
}

if ( ! defined( 'SAVEQUERIES' ) ) {
	define( 'SAVEQUERIES', true );
}

if ( ! defined( 'SCRIPT_DEBUG' ) ) {
	define( 'SCRIPT_DEBUG', true );
}

if ( ! defined( 'STYLE_DEBUG' ) ) {
	define( 'STYLE_DEBUG', true );
}

if ( ! defined( 'COMPRESS_SCRIPTS' ) ) {
	define( 'COMPRESS_SCRIPTS', false );
}

if ( ! defined( 'COMPRESS_CSS' ) ) {
	define( 'COMPRESS_CSS', false );
}

require( __DIR__ . '/wp-config-defaults.php' );
define( 'WP_ALLOW_MULTISITE', false );
define( 'MULTISITE', false );
define( 'SUBDOMAIN_INSTALL', true );
define( 'DOMAIN_CURRENT_SITE', 'DEV_DOMAIN_PLACEHOLDER.vipdev.lndo.site' );
define( 'PATH_CURRENT_SITE', '/' );
define( 'SITE_ID_CURRENT_SITE', 1 );
define( 'BLOG_ID_CURRENT_SITE', 1 );

define('AUTH_KEY',         '_mS8&[Uq41&H./G(T+EBZU@:_3+&:+?b&TX 8G*^[FBnvWik3iPB,[KkRW?^4YFR');
define('SECURE_AUTH_KEY',  'K`K*E:]/x|?ZWsA1#,Rz|65wF-+^)I-% PEA(`88u?b$|4u>`yoM]ADrNq6//}b/');
define('LOGGED_IN_KEY',    '@Cr1H,YP*H](u$2KWA_Gdd<xJ?+V|B!P.SDm)zGx|^:$}9-c9lMHa{j-;>5iD-dH');
define('NONCE_KEY',        '>T#%p:s|Lwi?}4iXROvat+mZi!>Z[Zd1>K--v!EoT-RQ2lHM2+v%CvzEFeV|aW|V');
define('AUTH_SALT',        'jKH-LxcNC%sQuqO{cc|93%d]pb}Jgzv~+;=bS3a@ WjxD^Q~[+V_<LRjBRE~-J|j');
define('SECURE_AUTH_SALT', 'GyH-%V-RCmE+5sH~l!;~`GDr7{=>N~i+X,+]j@[4FIq!:`,io^k8i-Y>:}d.5r`S');
define('LOGGED_IN_SALT',   '=[ZA`/X*e1#jU:BUr|)V>JRf%]N2e}Q+JGSwx(dJ!*0NmKE.+5FOx^AekiGo1<a ');
define('NONCE_SALT',       '5j#8+?=d.fc1~7SNJHGGsXBtv(dWG_H/Iz, gI4Y {sRa%E$S;ZaU2AJ sZ(x;jB');
