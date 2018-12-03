<?php
namespace App\Models\Api\Posts;

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
            
            // проверяем авторизацию
            $auths = $this->container['auths'];
            $exceptions = [];
            if (!$auths->AuthUser->Authed()) {
                throw new \Exception("Не авторизован");
            }
            // проверяем наличие обязательных полей
            if (empty($p["name"])) {
                $exceptions['name'] = "Не указано имя альбома";
            }
            if (empty($p["description"])) {
                $exceptions['description'] = "Не указано описание";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в параметрах");
            }

            //передаем параметры в переменные
            $user_id = $_SESSION["user_id"];
            $name = $p["name"];
            $description = $p["description"];

            //пишем в базу
            $db = $this->container['db'];
            $q = "insert into posts (
                    user_id,
                    name,
                    description
                ) values (
                    {$user_id},
                    '{$name}',
                    '{$description}'
                )  RETURNING id;";
            // var_dump($q);
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["id" => $id_add['id'], "massege" => "Пост создан успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
