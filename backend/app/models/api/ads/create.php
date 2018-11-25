<?php
namespace App\Models\Api\Ads;

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
            $settlements_id = $p["settlement"];
            $model_id = $p["model"];
            $mileage = $p["mileage"];
            $description = $p["description"];
            // $documentation = $p["documentation"];
            // $repair = $p["repair"];
            // $exchange = $p["exchange"];
            $price = $p["price"];
            $year = $p["year"];

            // фильтруем параметры
            $filters = $this->container['filters'];
            // убирае все кроме цифр
            $fDigits = $filters->Digits;
            $settlements_id = $fDigits->filter($settlements_id);
            $model_id = $fDigits->filter($model_id);
            $mileage = $fDigits->filter($mileage);
            $price = $fDigits->filter($price);
            $year = $fDigits->filter($year);

            $db = $this->container['db'];
            // выбираем  countries_id
            $q = "select subject_id as subjects_id from locations_settlements where id={$settlements_id}";
            $subjects_id = $db->query($q, \PDO::FETCH_ASSOC)->fetch()["subjects_id"];
            $q = "select country_id as countries_id from locations_subjects where id={$subjects_id}";
            $countries_id = $db->query($q, \PDO::FETCH_ASSOC)->fetch()["countries_id"];
            $q = "select transport_id, brand_id from transports_models where id={$model_id}";
            $qtransport = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            $transport_id = $qtransport["transport_id"];
            $brand_id = $qtransport["brand_id"];
            $q = "insert into ads (
                    user_id,
                    countries_id,
                    subjects_id,
                    settlements_id,
                    transport_id,
                    brand_id,
                    model_id,
                    mileage,
                    description,
                    price,
                    year
                ) values (
                    {$user_id},
                    {$countries_id},
                    {$subjects_id},
                    {$settlements_id},
                    {$transport_id},
                    {$brand_id},
                    {$model_id},
                    {$mileage},
                    '{$description}',
                    {$price},
                    {$year}
                )  RETURNING id;";
            // var_dump($q);
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["add_id" => $id_add['id'], "massege" => "Объявление создано успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
