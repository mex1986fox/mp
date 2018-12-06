<?php
namespace App\Models\Api\Filter;

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

            // проверяем фильтр в базе

            if (!empty($p["user_id"])) {
                $user_id = $p["user_id"];
                $db = $this->container['db'];
                //выбираем фильтр из базы
                $q = "select * from filters where user_id = {$user_id};";
                $filter = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
                if ($filter != false) {
                    return ["filter" => $filter["filter"]];
                } else {
                    throw new \Exception("Нет фильтра для авторизованного пользователя");
                }
            } else {
                throw new \Exception("Нет фильтра для неавторизованного пользователя");
            }

        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
