<?php
namespace App\Models\Api\AdsFilter;

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
            if (empty($p["filter"])) {
                $exceptions["filter"] = "Не указан фильтр";
            }
            $p = $this->request->getQueryParams();
            //передаем параметры в переменные
            $user_id = $_SESSION["user_id"];
            $filter = $p["filter"];
            $db = $this->container['db'];
            $q = "insert into ads_filter (
                    user_id,
                    filter
                ) values (
                    {$user_id},
                    {$filter},
                )  RETURNING id;";
            return ["massege" => "Фильтр сохранен успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
