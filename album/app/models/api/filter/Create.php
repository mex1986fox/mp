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
            empty($p["filter"]) ? $exceptions["filter"] = "Не указан" : $filter = $p["filter"];
            empty($p['session_id']) ? $exceptions["session_id"] = "Не указан" : $sessionID = $p['session_id'];
            empty($p['user_id']) ? $exceptions["user_id"] = "Не указан" : $userID = $p['user_id'];
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в парамметрах");
            }
            // проверяем авторизацию
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if ($authedUser) {
                $db = $this->container['db'];
                //сохраняем фильтр в базу
                $q = "insert into filters (user_id, filter) VALUES ({$userID}, '{$filter}') 
                on conflict (user_id) do update set user_id={$userID}, filter='{$filter}'";
                $db->query($q, \PDO::FETCH_ASSOC)->fetch();
                return ["massege" => "Фильтр сохранен"];
            }else{
                throw new \Exception("Пользователь не авторизован");
            }

        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
