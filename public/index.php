<?php

require_once __DIR__ . '/../vendor/autoload.php';

$app = new Silex\Application();

$app->get('/', function() use ($app) {
    return 'Hello World';
});

$app->get('/__g2g', function() use ($app) {
    return 'OK';
});

$app->run();
