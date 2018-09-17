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
            $add_id = $p["add_id"];
            $settlements_id = $p["settlement"];
            $model_id = $p["model"];
            $mileage = $p["mileage"];
            $description = $p["description"];
            $price = $p["price"];
            $year = $p["year"];

            $fuel = $p['fuel'];
            $power = $p['power'];
            $volume = $p['volume'];

            $transmission = $p['transmission'];
            $drive = $p['drive'];
            $body = $p['body'];
            $wheel = $p['wheel'];

            $documentation = $p["documentation"];
            $repair = $p["repair"];
            $exchange = $p["exchange"];

            // фильтруем параметры
            $filters = $this->container['filters'];
            // убирае все кроме цифр
            $fDigits = $filters->Digits;
            $add_id = $fDigits->filter($add_id);

            $settlements_id = $fDigits->filter($settlements_id);
            $model_id = $fDigits->filter($model_id);
            $mileage = $fDigits->filter($mileage);
            $price = $fDigits->filter($price);
            $year = $fDigits->filter($year);
            $fuel = $fDigits->filter($fuel);
            $db = $this->container['db'];

            // формируем запрос
            $qSet = "";
            $qSet = $qSet.(empty($settlements_id) ? "" : " settlements_id={$settlements_id},");
            $qSet = $qSet.(empty($model_id) ? "" : " model_id={$model_id},");
            $qSet = $qSet.(empty($mileage) ? "" : " mileage={$mileage},");
            $qSet = $qSet.(empty($description) ? "" : " description={$description},");
            $qSet = $qSet.(empty($price) ? "" : " price={$price},");
            $qSet = $qSet.(empty($year) ? "" : " year={$year},");
            $qSet = $qSet.(empty($fuel) ? "" : " fuel_id={$fuel},");
            $qSet = $qSet.(empty($power) ? "" : " engin_power={$power},");
            $qSet = $qSet.(empty($volume) ? "" : " engin_volume={$volume},");
            $qSet = $qSet.(empty($transmission) ? "" : " transmission_id={$transmission},");
            $qSet = $qSet.(empty($drive) ? "" : " drive_id={$drive},");
            $qSet = $qSet.(empty($body) ? "" : " body_id={$body},");
            $qSet = $qSet.(empty($wheel) ? "" : " wheel='{$wheel}',");
            $qSet = $qSet.(empty($documentation) ? "" : " documentation=true,");
            $qSet = $qSet.(empty($repair) ? "" : " repair=true,");
            $qSet = $qSet.(empty($exchange) ? "" : " exchange=true,");
            $qSet = (empty($qSet) ? "" : substr($qSet,0,-1));

           $q = "update ads set {$qSet} where id={$add_id} and user_id={$user_id}";
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            
                
            return ["add_id" => $id_add['id'], "massege" => "Объявление изменено успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
