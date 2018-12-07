<?php
namespace App\Models\Api\Albums;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Create
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

            //передаем параметры в переменные
            empty($p["name"])? $exceptions["name"] = "Не указан" : $name = $p["name"];
            empty($p['session_id']) ? $exceptions["session_id"] = "Не указан" : $sessionID = $p['session_id'];
            empty($p['user_id']) ? $exceptions["user_id"] = "Не указан" : $userID = $p['user_id'];
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в парамметрах");
            }

            // проверяем авторизацию
            $auths = $this->container['auths'];
            if (!$auths->AuthUser->Authed($sessionID, $userID)) {
                throw new \Exception("Не авторизован");
            }

            $db = $this->container['db'];
            $q = "insert into albums (
                    user_id,
                    name
                ) values (
                    {$userID},
                    '{$name}'
                )  RETURNING id;";
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["id" => $id_add['id'], "massege" => "Альбом создан успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
