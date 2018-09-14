<?php
namespace App\Models\Api\Ads;

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
            $settlements_id = $p["settlement"];
            $model_id = $p["model"];
            $mileage = $p["mileage"];
            $description = $p["description"];
            $price = $p["price"];
            $year = $p["year"];

            $fuel = $p['fuel'];
            $power = $p['power'];
            $volume = $p['volume'];

            $transmission=$p['transmission'];
            $drive=$p['drive'];
            $body=$p['body'];
            $wheel=$p['wheel'];
            
            $documentation = $p["documentation"];
            $repair = $p["repair"];
            $exchange = $p["exchange"];

            // фильтруем параметры
            $filters = $this->container['filters'];
            // убирае все кроме цифр
            $fDigits = $filters->Digits;
            $settlements_id = $fDigits->filter($settlements_id);
            $model_id = $fDigits->filter($model_id);
            $mileage = $fDigits->filter($mileage);
            $price = $fDigits->filter($price);
            $year = $fDigits->filter($year);
            $fuel = $fDigits->filter($fuel);
            $db = $this->container['db'];
            $q = "insert into ads (
                    user_id,
                    settlements_id,
                    model_id,
                    mileage,
                    description,
                    price,
                    year
                ) values (
                    {$user_id},
                    {$settlements_id},
                    {$model_id},
                    {$mileage},
                    '{$description}',
                    {$price},
                    {$year}
                )  RETURNING id;";
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["add_id" => $id_add['id'], "massege" => "Объявление создано успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
