<?php

use App\Kernel;
use Symfony\Component\HttpFoundation\Request;

require_once dirname(__DIR__).'/vendor/autoload.php';

// Valeurs par défaut si APP_ENV ou APP_DEBUG ne sont pas définis
$env = $_SERVER['APP_ENV'] ?? 'prod';
$debug = isset($_SERVER['APP_DEBUG']) ? (bool) $_SERVER['APP_DEBUG'] : false;

$kernel = new Kernel($env, $debug);
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);