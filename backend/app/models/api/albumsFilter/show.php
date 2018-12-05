<?php
namespace App\Models\Api\AlbumsFilter;

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
            // проверяем фильтр
            if (!empty($_SESSION["filter"])) {
                //отдаем если он есть в сессие
                return ["filter" => $_SESSION["filter"]];
            }
            // проверяем авторизачцию пользователя
            $auths = $this->container['auths'];
            if (!$auths->AuthUser->Authed()) {
                throw new \Exception("Нет фильтра для не авторизованого пользователя");
            }
            // проверяем фильтр в базе
            $user_id = $_SESSION["user_id"];
            $db = $this->container['db'];
            //сохраняем фильтр в базу
            $q = "select * from albums_filters where user_id = {$user_id};";
            $filter = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            if ($filter != false) {
                return ["filter" => $filter["filter"]];
            } else {
                throw new \Exception("Нет фильтра для пользователя");
            }

        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
