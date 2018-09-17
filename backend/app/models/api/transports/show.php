<?php
namespace App\Models\Api\Transports;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Show
{
    protected $request, $response, $container;
    public function __construct($container, $request, $response)
    {
        $this->request = $request;
        $this->response = $response;
        $this->container = $container;

    }
    public function run()
    {
        try {

            // читаем базу
            $db = $this->container['db'];
            $qTransports = "select * from transports;";
            $qBrands = "select * from transports_brands;";
            $qModels = "select * from transports_models;";
            $qDrives = "select * from transports_drives;";
            $qVolums = "select * from transports_volums;";
            $qFuels = "select * from transports_fuels;";
            $qBodies = "select * from transports_bodies;";
            $qTransmissions = "select * from transports_transmissions;";

            $transports = $db->query($qTransports, \PDO::FETCH_ASSOC)->fetchAll();
            $brands = $db->query($qBrands, \PDO::FETCH_ASSOC)->fetchAll();
            $models = $db->query($qModels, \PDO::FETCH_ASSOC)->fetchAll();
            $drives = $db->query($qDrives, \PDO::FETCH_ASSOC)->fetchAll();
            $volums = $db->query($qVolums, \PDO::FETCH_ASSOC)->fetchAll();
            $fuels = $db->query($qFuels, \PDO::FETCH_ASSOC)->fetchAll();
            $bodies = $db->query($qBodies, \PDO::FETCH_ASSOC)->fetchAll();
            $transmissions = $db->query($qTransmissions, \PDO::FETCH_ASSOC)->fetchAll();

            $transports = [
                'transports' => $transports,
                'brands' => $brands,
                'models' => $models,
                'drives' => $drives,
                'volums' => $volums,
                'fuels' => $fuels,
                'bodies' => $bodies,
                'transmissions' => $transmissions,
            ];
            return $transports;
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
