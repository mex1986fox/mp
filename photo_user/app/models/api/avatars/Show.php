<?php
namespace App\Models\Api\Avatars;

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
            $qWhere = "";
            $qWhere = $qWhere . (empty($p["add_id"]) || !empty($p["ads_id"]) ? "" : "ads_id=" . $p["add_id"]);
            // var_dump($p);
            if (!empty($p["ads_id"])) {
                $inAds = "";
                foreach ($p["ads_id"] as $key => $value) {
                    $inAds = $inAds == "" ? $value : $inAds . ", " . $value;
                }
                $qWhere = "ads_id IN (" . $inAds . ") ";
            }

            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;

            $q = "select ads_id as id, lincks from lincks" . $qWhere;
            $ans = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            foreach ($ans as $key => $value) {
                // var_dump(json_decode($value["lincks"]));
                $ads[$key] = ["id" => $value["id"], "lincks" => json_decode($value["lincks"])->lincks];
            }
            return ["ads" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
