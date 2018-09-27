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
            $qWhere = $qWhere . (empty($p["user_id"]) || !empty($p["users_id"]) ? "" : "user_id=" . $p["user_id"]);
            // var_dump($p);
            if (!empty($p["users_id"])) {
                $inAds = "";
                foreach ($p["users_id"] as $key => $value) {
                    $inAds = $inAds == "" ? $value : $inAds . ", " . $value;
                }
                $qWhere = "user_id IN (" . $inAds . ") ";
            }

            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;

            $q = "select user_id, lincks from avatars" . $qWhere;
            // $q = "select user_id, lincks from avatars where user_id = ".$p["user_id"];
            $ans = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            foreach ($ans as $key => $value) {
                // var_dump(json_decode($value["lincks"]));
                $avatars[$key] = ["user_id" => $value["user_id"], "lincks" => json_decode($value["lincks"])->lincks];
            }
            return ["avatars" => $avatars];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
