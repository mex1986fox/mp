<?php
namespace App\Models\Api\Ads;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Length
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
            $ID = array_map('intval', $p["id"]);

            $mdb = $this->container['mongodb'];
            $find = $mdb->albums->find(["_id" => ['$in' => $ID]]);
            $length = array_map(function ($val) {
                return ["id" => $val["_id"], "length" => $val["commentsLength"]];
            }, iterator_to_array($find, true));
            return ["lengths" => $length];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
