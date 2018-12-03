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
            $qWhere = $qWhere . (empty($p["post_id"]) || !empty($p["posts_id"]) ? "" : "posts_id=" . $p["post_id"]);
            // var_dump($p);
            if (!empty($p["posts_id"])) {
                $inposts = "";
                foreach ($p["posts_id"] as $key => $value) {
                    $inposts = $inposts == "" ? $value : $inposts . ", " . $value;
                }
                $qWhere = "posts_id IN (" . $inposts . ") ";
            }

            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;

            $q = "select posts_id as id, lincks from lincks" . $qWhere;
            $ans = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            foreach ($ans as $key => $value) {
                // var_dump(json_decode($value["lincks"]));
                $posts[$key] = ["id" => $value["id"], "lincks" => json_decode($value["lincks"])->lincks];

            }
            if (empty($posts)) {
                throw new \Exception("Фотографии для постов не найдены");
            }
            return ["posts" => $posts];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
