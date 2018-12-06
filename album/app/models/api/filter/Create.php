<?php
namespace App\Models\Api\Filter;

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
            // проверяем фильтр
            if (empty($p["filter"])) {
                $exceptions["filter"] = "Не указан фильтр";
            }
            $filter = $p["filter"];
            // сохраняем фильтр в сессию
            $_SESSION["filter"] = $filter;
            // проверяем авторизацию
            $auths = $this->container['auths'];
            if ($auths->AuthUser->Authed()) {
                //для авторизованных
                $user_id = $_SESSION["user_id"];
                $db = $this->container['db'];
                //сохраняем фильтр в базу
                $q = "insert into filters (
                    user_id,
                    filter
                ) values ({$user_id}, '{$filter}')";
                $db->query($q, \PDO::FETCH_ASSOC)->fetch();
                return ["massege" => "Фильтр сохранен для авторизованных пользователей"];
            }
            return ["massege" => "Фильтр сохранен для не авторизованных пользователей"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
