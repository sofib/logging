<?php

openlog('app1', LOG_CONS | LOG_PERROR, LOG_LOCAL0);
syslog(LOG_ERR, 'An error message');
closelog();

require_once './vendor/autoload.php';
use Laminas\Log\Formatter\Json;

$writer = new \Laminas\Log\Writer\Syslog([
  'application' => 'app2',
  'facility' => LOG_USER,
  //'filters' => [],
  'formatter' => new Json()
]);

$logger = new \Laminas\Log\Logger();
$logger->addWriter($writer);
$logger->addWriter(new Laminas\Log\Writer\Stream('php://output'));

// goes to system log
$logger->info('Informational message');

