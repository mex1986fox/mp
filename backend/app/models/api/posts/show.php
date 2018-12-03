<?php
namespace App\Models\Api\Posts;

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
            //формируем условия выборки
            $qWhere = "";
            // для номера поста
            $qWhere = $qWhere . (empty($id) ? "" : "id=" . $id . " and ");

            $qWhere = empty($qWhere) ? "" : rtrim($qWhere, ' or ');
            $qWhere = empty($qWhere) ? "" : rtrim($qWhere, ' and ');
            $qWhere = (empty($qWhere) ? "" : "where ") . $qWhere;

            $db = $this->container['db'];
            $q = "select * from posts " . $qWhere;
            $ads = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            return ["posts" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
