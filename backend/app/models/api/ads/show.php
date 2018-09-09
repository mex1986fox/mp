<?php
namespace App\Models\Api\Ads;

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
            $p = $this->request->getQueryParams();
            $qWhere = "";
            $qWhere = $qWhere . (empty($p["add_id"]) ? "" : "id=" . $p["add_id"]);
            $qWhere = (empty($qWhere) ? "" : "where ") . $qWhere;

            $db = $this->container['db'];
            $q = "select * from ads " . $qWhere;
            $ads = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            return ["ads" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
