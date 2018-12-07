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
            $qWhere = "";
            $qWhere = $qWhere . (empty($p["album_id"]) ? "" : "albums_id=" . $p["album_id"]);
            // var_dump($p);
            // if (!empty($p["albums_id"])) {
            //     $inalbums = "";
            //     foreach ($p["albums_id"] as $key => $value) {
            //         $inalbums = $inalbums == "" ? $value : $inalbums . ", " . $value;
            //     }
            //     $qWhere = "albums_id IN (" . $inalbums . ") ";
            // }

            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;

            $q = "select albums_id as id, lincks from lincks" . $qWhere;
            $ans = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            foreach ($ans as $key => $value) {
                // var_dump(json_decode($value["lincks"]));
                $lincks = json_decode($value["lincks"])->lincks;
            }
            return ["lincks" => $lincks];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
