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
            empty($p['user_id']) ? $exceptions["user_id"] = "Не указан" : $userID = $p['user_id'];
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в парамметрах");
            }
            $userID = $p["user_id"];
            $db = $this->container['db'];
            //выбираем фильтр из базы
            $q = "select * from filters where user_id = {$userID};";
            $filter = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            if ($filter != false) {
                return ["filter" => $filter["filter"]];
            } else {
                throw new \Exception("Фильтер не найден");
            }
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
