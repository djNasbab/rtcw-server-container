<?php
define('PIDFILE', __DIR__ . '/gs.pid');

function output($line) {
    echo $line . "\n";
}

function usage() {
    output('Usage: ' . basename(__FILE__) . ' [ip] [port]');
}

if (count($argv) !== 3) {
    usage();
} else {
    $ip   = $argv[1];
    $port = (int) $argv[2];

    if (filter_var($ip, FILTER_VALIDATE_IP) and $port > 1024 and $port <= 65535) {
        if(file_exists(PIDFILE)) {
            shell_exec('kill -9 ' . trim(file_get_contents(PIDFILE)));
        }

        $cmd = __DIR__ . '/wolfded.x86 +set dedicated 2 +set net_IP ' . $ip
               . ' +set net_port ' . $port . ' +set fs_game osp +set fs_homepath '
               . __DIR__ . ' +set fs_basepath ' . __DIR__ . ' +set com_hunkMegs '
               . '512 +exec server_config.cfg +map mp_ice';

        $pid = shell_exec(sprintf('%s > /dev/null 2>&1 & echo $!', $cmd));

        file_put_contents(PIDFILE, trim($pid));

        while(posix_getpgid($pid)) {
            sleep(5);
        }

    } else {
        usage();
    }
}