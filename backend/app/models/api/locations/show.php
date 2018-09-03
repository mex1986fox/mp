<?php
namespace App\Models\Api\Locations;

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
            $qcountries = "select * from locations_countries;";
            $qsettlements = "select * from locations_settlements;";
            $qsubjects = "select * from locations_subjects;";

            $countries = $db->query($qcountries, \PDO::FETCH_ASSOC)->fetchAll();
            $settlements = $db->query($qsettlements, \PDO::FETCH_ASSOC)->fetchAll();
            $subjects = $db->query($qsubjects, \PDO::FETCH_ASSOC)->fetchAll();

            $locations = [
                'countries' => $countries,
                'settlements' => $settlements,
                'subjects' => $subjects,
            ];
            return $locations;
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
