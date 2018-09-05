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
            $id = $p["id"];
            $login = $p["login"];
            $name = $p["name"];
            $surname = $p["surname"];
            $birthdate = $p["birthdate"];

            // пишем в базу
            $db = $this->container['db'];
            $q = "  select
                        id, login, name, surname, birthdate
                    from
                        users
                        where id={$id}";
            $users = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            
            return ["users"=>$users];
        } catch (RuntimeException | \Exception $e) {

            $exceptions['massege'] = $e->getMessage();
            return $exceptions;
        }
    }
}
