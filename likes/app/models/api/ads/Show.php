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
            $db = $this->container['db'];
            $qWhere = "";
            if (!empty($p["ads_id"])) {
                $inAds = "";
                foreach ($p["ads_id"] as $key => $value) {
                    $inAds = $inAds == "" ? $value : $inAds . ", " . $value;
                }
                $qWhere = "ads_id IN (" . $inAds . ") ";
            }
            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;
            $q = "select ads_id, likes, dislikes from ads" . $qWhere;
            // $q = "select user_id, lincks from avatars where user_id = ".$p["user_id"];
            $ans = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            if (empty($ans)) {
                throw new \Exception("Лайки не найдены");
            }
            return ["likes" => $ans];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
