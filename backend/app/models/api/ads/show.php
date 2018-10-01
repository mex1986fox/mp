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
            if (!empty($p["id"])) {
                $id = $p["id"];
            }
            $qWhere = "";
            $qWhere = $qWhere . (empty($id) ? "" : "id=" . $id);
            $qWhere = (empty($qWhere) ? "" : "where ") . $qWhere;

            $db = $this->container['db'];
            $q = "select *, price::numeric(10,0) from ads " . $qWhere;
            $ads = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            return ["ads" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
