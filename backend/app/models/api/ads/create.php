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

            $p = $this->request->getQueryParams();
            var_dump($p);
            $user_id = 1; // $_SESSION["user"]["id"];

            $settlements_id = $p["settlement"];
            $model_id = $p["model"];
            $mileage = $p["mileage"];
            $description = $p["description"];
            $documentation = $p["documentation"];
            $repair = $p["repair"];
            $exchange = $p["exchange"];
            $price = $p["price"];
            $year = $p["year"];

            // $exceptions = [];

            $db = $this->container['db'];
            $q = "insert into ads (
                    user_id,
                    settlements_id,
                    model_id,
                    mileage,
                    description,
                    documentation,
                    repair,
                    exchange,
                    price,
                    year
                ) values (
                    {$user_id},
                    {$settlements_id},
                    {$model_id},
                    {$mileage},
                    '{$description}',
                    '{$documentation}',
                    '{$repair}',
                    '{$exchange}',
                    {$price},
                    {$year}
                )  RETURNING id;";
            echo ($q);
            $id_add = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["add_id" => $id_add, "massege" => "Объявление создано успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
