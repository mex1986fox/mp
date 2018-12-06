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
            // проверяем авторизацию
            $auths = $this->container['auths'];
            if (!$auths->AuthUser->Authed()) {
                throw new \Exception("Не авторизован");
            }

            $p = $this->request->getQueryParams();
            //передаем параметры в переменные
            $user_id = $_SESSION["user_id"];
            if (empty($p["name"])) {
                throw new \Exception("Не указано имя альбома");
            }
            $name = $p["name"];

            $db = $this->container['db'];
            $q = "insert into albums (
                    user_id,
                    name
                ) values (
                    {$user_id},
                    '{$name}'
                )  RETURNING id;";
            // var_dump($q);
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["id" => $id_add['id'], "massege" => "Альбом создан успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
