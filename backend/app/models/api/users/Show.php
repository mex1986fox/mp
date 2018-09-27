<?php
namespace App\Models\Api\Users;

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

            // передаем параметры в переменные
            $p = $this->request->getQueryParams();
            $exceptions = [];
            if (!empty($p["user_id"])) {
                $id = $p["id"];
            }
            if (!empty($p["id"])) {
                $id = $p["id"];
            }

            $login = $p["login"];
            $name = $p["name"];
            $surname = $p["surname"];
            $birthdate = $p["birthdate"];

            $qWhere = "";
            $qWhere = $qWhere . (empty($id) || !empty($p["users_id"]) ? "" : " id=" . $id);
            // var_dump($p);
            if (!empty($p["users_id"])) {
                $inUsers = "";
                foreach ($p["users_id"] as $key => $value) {
                    $inUsers = $inUsers == "" ? $value : $inUsers . ", " . $value;
                }
                $qWhere = " id IN (" . $inUsers . ") ";
            }
            $qWhere = (empty($qWhere) ? "" : " where ") . $qWhere;

            // пишем в базу
            $db = $this->container['db'];
            $q = "  select
                        id, login, name, surname, birthdate, settlement_id, phone, email
                    from
                        users " . $qWhere;
            $users = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();

            return ["users" => $users];
        } catch (RuntimeException | \Exception $e) {

            $exceptions['massege'] = $e->getMessage();
            return $exceptions;
        }
    }
}
