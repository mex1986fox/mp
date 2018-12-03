<?php
namespace App\Models\Api\Posts;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Update
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
            if (!empty($p["post_id"])) {
                $post_id = $p["post_id"];
            } else {
                throw new \Exception("Не указан номер поста");
            }
            $name = (!empty($p["name"]) ? $p["name"] : "");
            $description = (!empty($p["description"]) ? $p["description"] : "");

            $db = $this->container['db'];

            // формируем запрос
            $qSet = "";
            $qSet = $qSet . (empty($name) ? "" : " name='{$name}',");
            $qSet = $qSet . (empty($description) ? "" : " description='{$description}',");
            $qSet = (empty($qSet) ? "" : substr($qSet, 0, -1));

            $q = "update posts set {$qSet} where id={$post_id} and user_id={$user_id}";
            $id = $db->query($q, \PDO::FETCH_ASSOC)->fetch();

            return ["id" => $post_id, "massege" => "Пост изменен успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
