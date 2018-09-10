<?php
namespace App\Models\Api\Photos;

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
            $db = $this->container['db'];
            $q = "select lincks from lincks where ads_id=" . $p["add_id"];
            $resp = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();

            $lincks = json_decode($resp[0]["lincks"])->lincks;
            return ["lincks" => $lincks];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
