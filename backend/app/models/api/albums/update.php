<?php
namespace App\Models\Api\Albums;

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
            if (!empty($p["album_id"])) {
                $album_id = $p["album_id"];
            } else {
                throw new \Exception("Не указан номер альбома");
            }
            $name = (!empty($p["name"]) ? $p["name"] : "");
            // $country = (!empty($p["country"]) ? $p["country"] : "");
            // $subject = (!empty($p["subject"]) ? $p["subject"] : "");

            if (!empty($p["settlement"])) {
                $settlement_id = $p["settlement"];
                $q = "select subject_id as subjects_id from locations_settlements where id={$settlements_id}";
                $subjects_id = $db->query($q, \PDO::FETCH_ASSOC)->fetch()["subjects_id"];
                $q = "select country_id as countries_id from locations_subjects where id={$subjects_id}";
                $countries_id = $db->query($q, \PDO::FETCH_ASSOC)->fetch()["countries_id"];
            }

            // $transport = (!empty($p["transport"]) ? $p["transport"] : "");
            // $brand = (!empty($p["brand"]) ? $p["brand"] : "");
            if (!empty($p["model"])) {
                $model_id = $p["model"];
                $q = "select transport_id, brand_id from transports_models where id={$model_id}";
                $qtransport = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
                $transport_id=$qtransport['transport_id'];
                $brand_id=$qtransport['brand_id'];
            }
            $year = (!empty($p["year"]) ? $p["year"] : "");
            $db = $this->container['db'];

            // формируем запрос
            $qSet = "";
            $qSet = $qSet . (empty($name) ? "" : " name='{$name}',");
            $qSet = (empty($qSet) ? "" : substr($qSet, 0, -1));

            $q = "update albums set {$qSet} where id={$album_id} and user_id={$user_id}";
            $id = $db->query($q, \PDO::FETCH_ASSOC)->fetch();

            return ["id" => $album_id, "massege" => "Альбом изменен успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
